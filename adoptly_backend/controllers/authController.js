const User = require('../models/User');
const jwt = require('jsonwebtoken');

// Generar token JWT
const generateToken = (userId, role = 'usuario') => {
  return jwt.sign({ userId, role }, process.env.JWT_SECRET || 'tu_secreto_jwt', {
    expiresIn: '7d'
  });
};

// Middleware para verificar token
const authenticateToken = (req, res, next) => {
  const token = req.header('Authorization')?.replace('Bearer ', '');

  if (!token) {
    return res.status(401).json({ error: 'Acceso denegado. Token requerido.' });
  }

  try {
    const verified = jwt.verify(token, process.env.JWT_SECRET || 'tu_secreto_jwt');
    req.user = verified;
    next();
  } catch (error) {
    res.status(400).json({ error: 'Token inválido' });
  }
};

// Middleware para verificar roles
const authorizeRole = (roles) => {
  return async (req, res, next) => {
    if (!req.user) {
      return res.status(401).json({ error: 'Usuario no autenticado' });
    }

    try {
      // Buscar el usuario en la base de datos para obtener su rol actual
      const user = await User.findById(req.user.userId);
      if (!user) {
        return res.status(401).json({ error: 'Usuario no encontrado' });
      }

      if (!roles.includes(user.rol)) {
        return res.status(403).json({ error: 'Acceso denegado. Rol insuficiente.' });
      }

      req.user.role = user.rol; // Actualizar el rol en el request
      next();
    } catch (error) {
      res.status(500).json({ error: 'Error al verificar permisos' });
    }
  };
};

// Registro de usuario
const register = async (req, res) => {
  try {
    const { nombre, correo, contrasena, rol = 'usuario' } = req.body;

    // Verificar si el usuario ya existe
    const existingUser = await User.findOne({ correo });
    if (existingUser) {
      return res.status(400).json({ error: 'El correo ya está registrado' });
    }

    // Crear nuevo usuario
    const user = new User({
      nombre,
      correo,
      contrasena,
      rol
    });

    await user.save();

    // Generar token
    const token = generateToken(user._id, user.rol);

    res.status(201).json({
      message: 'Usuario registrado exitosamente',
      token,
      user: {
        id: user._id,
        nombre: user.nombre,
        correo: user.correo,
        rol: user.rol
      }
    });
  } catch (error) {
    res.status(500).json({ error: 'Error en el registro' });
  }
};

// Login de usuario
const login = async (req, res) => {
  try {
    const { correo, contrasena } = req.body;

    // Buscar usuario
    const user = await User.findOne({ correo });
    if (!user) {
      return res.status(400).json({ error: 'Credenciales inválidas' });
    }

    // Verificar si está bloqueado
    if (user.isLocked()) {
      return res.status(423).json({
        error: 'Cuenta bloqueada temporalmente. Inténtalo de nuevo más tarde.'
      });
    }

    // Verificar contraseña
    const isValidPassword = await user.comparePassword(contrasena);
    if (!isValidPassword) {
      await user.incLoginAttempts();
      return res.status(400).json({ error: 'Credenciales inválidas' });
    }

    // Resetear intentos de login en caso de éxito
    await user.resetLoginAttempts();

    // Generar token
    const token = generateToken(user._id, user.rol);

    res.json({
      message: 'Login exitoso',
      token,
      user: {
        id: user._id,
        nombre: user.nombre,
        correo: user.correo,
        rol: user.rol
      }
    });
  } catch (error) {
    res.status(500).json({ error: 'Error en el login' });
  }
};

module.exports = {
  register,
  login,
  authenticateToken,
  authorizeRole,
  generateToken
};
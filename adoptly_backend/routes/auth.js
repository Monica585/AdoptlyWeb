const express = require('express');
const { register, login, authenticateToken, authorizeRole } = require('../controllers/authController');

const router = express.Router();

// Rutas públicas
router.post('/register', register);
router.post('/login', login);

// Rutas protegidas (ejemplo)
router.get('/profile', authenticateToken, (req, res) => {
  res.json({ message: 'Perfil de usuario', userId: req.user.userId });
});

// Ruta solo para administradores
router.get('/admin', authenticateToken, authorizeRole(['administrador']), (req, res) => {
  res.json({ message: 'Área administrativa' });
});

module.exports = router;
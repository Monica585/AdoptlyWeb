const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');

const userSchema = new mongoose.Schema({
  nombre: {
    type: String,
    required: true,
    trim: true
  },
  correo: {
    type: String,
    required: true,
    unique: true,
    lowercase: true,
    trim: true
  },
  contrasena: {
    type: String,
    required: true
  },
  rol: {
    type: String,
    enum: ['usuario', 'administrador'],
    default: 'usuario'
  },
  intentosLogin: {
    type: Number,
    default: 0
  },
  bloqueadoHasta: {
    type: Date,
    default: null
  },
  createdAt: {
    type: Date,
    default: Date.now
  }
});

// Hash de contraseña antes de guardar
userSchema.pre('save', async function(next) {
  if (!this.isModified('contrasena')) return next();

  try {
    const salt = await bcrypt.genSalt(10);
    this.contrasena = await bcrypt.hash(this.contrasena, salt);
    next();
  } catch (error) {
    next(error);
  }
});

// Método para comparar contraseñas
userSchema.methods.comparePassword = async function(candidatePassword) {
  return await bcrypt.compare(candidatePassword, this.contrasena);
};

// Método para incrementar intentos de login
userSchema.methods.incLoginAttempts = function() {
  this.intentosLogin += 1;
  // Bloquear por 15 minutos después de 5 intentos fallidos
  if (this.intentosLogin >= 5) {
    this.bloqueadoHasta = new Date(Date.now() + 15 * 60 * 1000); // 15 minutos
  }
  return this.save();
};

// Método para resetear intentos de login
userSchema.methods.resetLoginAttempts = function() {
  this.intentosLogin = 0;
  this.bloqueadoHasta = null;
  return this.save();
};

// Método para verificar si está bloqueado
userSchema.methods.isLocked = function() {
  return this.bloqueadoHasta && this.bloqueadoHasta > new Date();
};

module.exports = mongoose.model('User', userSchema);
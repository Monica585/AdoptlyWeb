const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const rateLimit = require('express-rate-limit');
require('dotenv').config();

const app = express();
app.use(cors());
app.use(express.json());

// Rate limiting para protección contra ataques de fuerza bruta
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutos
  max: 5, // límite de 5 requests por windowMs
  message: {
    error: 'Demasiados intentos de login. Inténtalo de nuevo en 15 minutos.'
  },
  standardHeaders: true,
  legacyHeaders: false,
});

// Aplicar rate limiting solo a rutas de autenticación
app.use('/api/auth/login', limiter);
app.use('/api/auth/register', limiter);

// Conexión a MongoDB
mongoose.connect(process.env.MONGO_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true
}).then(() => console.log('Conectado a MongoDB'))
  .catch(err => console.error('Error de conexión:', err));

// Rutas
const authRoutes = require('./routes/auth');
app.use('/api/auth', authRoutes);

app.get('/', (req, res) => {
  res.send('API Adoptly funcionando');
});

// Iniciar servidor
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`🚀 Servidor corriendo en puerto ${PORT}`);
});

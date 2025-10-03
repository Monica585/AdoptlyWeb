import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/usuarios_provider.dart';
import '../../providers/usuario_provider.dart';

class PantallaInicioSesion extends StatefulWidget {
  const PantallaInicioSesion({super.key});

  @override
  State<PantallaInicioSesion> createState() => _PantallaInicioSesionState();
}

class _PantallaInicioSesionState extends State<PantallaInicioSesion> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isFormValid = false;

  final emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  void _validateForm() {
    setState(() {
      _isFormValid = _formKey.currentState?.validate() ?? false;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void iniciarSesion() {
    final correo = emailController.text.trim();
    final contrasena = passwordController.text.trim();

    final usuariosProvider = Provider.of<UsuariosProvider>(context, listen: false);
    final usuarioProvider = Provider.of<UsuarioProvider>(context, listen: false);

    // Verificar credenciales de administrador primero
    if (usuariosProvider.esAdmin(correo, contrasena)) {
      Navigator.pushReplacementNamed(context, '/adminPanel');
      return;
    }

    // Para usuarios normales, validar el formulario
    if (!_formKey.currentState!.validate()) return;

    // Validar usuario registrado
    final usuario = usuariosProvider.validarLogin(correo, contrasena);
    if (usuario != null) {
      usuarioProvider.usuario = usuario;
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      mostrarMensaje('Correo o contraseña incorrectos.');
    }
  }

  void mostrarMensaje(String mensaje) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Información'),
        content: Text(mensaje),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Image.asset(
                    'assets/images/logo_adoptly.png',
                    height: 100,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Bienvenido de Nuevo",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Correo electrónico"),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (_) => _validateForm(),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return 'El correo es obligatorio';
                    if (!emailRegExp.hasMatch(value)) return 'Correo inválido';
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'ejemplo@correo.com',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),

                const SizedBox(height: 20),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Contraseña"),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: passwordController,
                  obscureText: _obscurePassword,
                  onChanged: (_) => _validateForm(),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return 'La contraseña es obligatoria';
                    final email = emailController.text.trim();
                    if (email == 'admin@adoptly.com') return null; // Admin bypasses requirements
                    if (value.length < 8) return 'Debe tener al menos 8 caracteres';
                    if (!RegExp(r'[A-Z]').hasMatch(value)) return 'Debe contener al menos una mayúscula';
                    if (!RegExp(r'\d').hasMatch(value)) return 'Debe contener al menos un número';
                    if (!RegExp(r'[@$!%*?&]').hasMatch(value)) return 'Debe contener al menos un carácter especial';
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: '••••••••',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/forgotPassword'),
                    child: const Text("¿Olvidaste tu contraseña?"),
                  ),
                ),

                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: _isFormValid ? iniciarSesion : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isFormValid ? const Color.fromARGB(255, 76, 172, 175) : Colors.grey,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text(
                    "Iniciar sesión",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

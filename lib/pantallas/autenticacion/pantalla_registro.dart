import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/usuarios_provider.dart';
import '../../providers/usuario_provider.dart';

class PantallaRegistro extends StatefulWidget {
  const PantallaRegistro({super.key});

  @override
  State<PantallaRegistro> createState() => _PantallaRegistroState();
}

class _PantallaRegistroState extends State<PantallaRegistro> {
  final _formKey = GlobalKey<FormState>();
  final nombreController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  final emailRegExp = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

  void registrarUsuario() {
    if (!_formKey.currentState!.validate()) return;

    final nombre = nombreController.text.trim();
    final correo = emailController.text.trim();
    final contrasena = passwordController.text.trim();

    final usuariosProvider = Provider.of<UsuariosProvider>(context, listen: false);
    final usuarioProvider = Provider.of<UsuarioProvider>(context, listen: false);

    // Registrar usuario
    final exito = usuariosProvider.registrarUsuario(nombre, correo, contrasena);
    if (exito) {
      // Establecer usuario actual
      final nuevoUsuario = usuariosProvider.validarLogin(correo, contrasena);
      if (nuevoUsuario != null) {
        usuarioProvider.usuario = nuevoUsuario;
      }
      mostrarMensaje(context, 'Registro exitoso. ¡Bienvenido, $nombre!');
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      mostrarMensaje(context, 'El correo ya está registrado.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Center(child: Image.asset('assets/images/logo_adoptly.png', height: 100)),
                const SizedBox(height: 20),
                const Text("Crear una cuenta", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 30),
                const Align(alignment: Alignment.centerLeft, child: Text("Nombre y Apellido")),
                TextFormField(
                  controller: nombreController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return 'El nombre es obligatorio';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const Align(alignment: Alignment.centerLeft, child: Text("Correo Electrónico")),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return 'El correo es obligatorio';
                    if (!emailRegExp.hasMatch(value)) return 'Correo inválido';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const Align(alignment: Alignment.centerLeft, child: Text("Contraseña")),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.length < 6) return 'La contraseña debe tener al menos 6 caracteres';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const Align(alignment: Alignment.centerLeft, child: Text("Confirmar contraseña")),
                TextFormField(
                  controller: confirmController,
                  obscureText: true,
                  validator: (value) {
                    if (value != passwordController.text) return 'Las contraseñas no coinciden';
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: registrarUsuario,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 76, 172, 175),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text("Registrarse", style: TextStyle(fontSize: 16, color: Colors.black)),
                ),
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/login'),
                    child: const Text("¿Ya tienes cuenta? Iniciar sesión"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void mostrarMensaje(BuildContext context, String mensaje) {
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
}

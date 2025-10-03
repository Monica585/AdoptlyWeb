import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/usuarios_provider.dart';
import '../../providers/usuario_provider.dart';

class PantallaRegistro extends StatelessWidget {
  const PantallaRegistro({super.key});

  @override
  Widget build(BuildContext context) {
    final nombreController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmController = TextEditingController();

    void registrarUsuario() {
      final nombre = nombreController.text.trim();
      final correo = emailController.text.trim();
      final contrasena = passwordController.text.trim();
      final confirmar = confirmController.text.trim();

      if (nombre.isEmpty || correo.isEmpty || contrasena.isEmpty || confirmar.isEmpty) {
        mostrarMensaje(context, 'Por favor completa todos los campos.');
        return;
      }

      if (contrasena != confirmar) {
        mostrarMensaje(context, 'Las contraseñas no coinciden.');
        return;
      }

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

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Center(child: Image.asset('assets/images/logo_adoptly.png', height: 100)),
              const SizedBox(height: 20),
              const Text("Crear una cuenta", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              const Align(alignment: Alignment.centerLeft, child: Text("Nombre y Apellido")),
              TextField(controller: nombreController),
              const SizedBox(height: 20),
              const Align(alignment: Alignment.centerLeft, child: Text("Correo Electrónico")),
              TextField(controller: emailController),
              const SizedBox(height: 20),
              const Align(alignment: Alignment.centerLeft, child: Text("Contraseña")),
              TextField(controller: passwordController, obscureText: true),
              const SizedBox(height: 20),
              const Align(alignment: Alignment.centerLeft, child: Text("Confirmar contraseña")),
              TextField(controller: confirmController, obscureText: true),
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

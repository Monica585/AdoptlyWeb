import 'package:flutter/material.dart';

class PantallaRecuperarContrasena extends StatelessWidget {
  const PantallaRecuperarContrasena({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();

    void enviarRecuperacion() {
      final correo = emailController.text.trim();

      if (correo.isEmpty) {
        mostrarMensaje(context, 'Por favor ingresa tu correo electrónico.');
        return;
      }

      // Simulación de envío
      mostrarMensaje(context, 'Se ha enviado un enlace de recuperación a tu correo.');
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
              const Text("Restablecer tu contraseña", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              const Align(alignment: Alignment.centerLeft, child: Text("Correo electrónico")),
              TextField(controller: emailController),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: enviarRecuperacion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 76, 172, 175),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text("Enviar enlace de restablecimiento", style: TextStyle(color: Colors.black)),
              ),
              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/login'),
                  child: const Text("Volver a iniciar sesión"),
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

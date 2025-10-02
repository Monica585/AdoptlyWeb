import 'package:flutter/material.dart';

class PantallaCambiarContrasena extends StatefulWidget {
  const PantallaCambiarContrasena({super.key});

  @override
  State<PantallaCambiarContrasena> createState() => _PantallaCambiarContrasenaState();
}

class _PantallaCambiarContrasenaState extends State<PantallaCambiarContrasena> {
  final _formKey = GlobalKey<FormState>();
  final actualController = TextEditingController();
  final nuevaController = TextEditingController();
  final confirmarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cambiar contraseña'),
        backgroundColor: const Color.fromARGB(255, 76, 172, 175),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              campoTexto('Contraseña actual', actualController, obscure: true),
              campoTexto('Nueva contraseña', nuevaController, obscure: true),
              campoTexto('Confirmar nueva contraseña', confirmarController, obscure: true),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (nuevaController.text != confirmarController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Las contraseñas no coinciden')),
                      );
                      return;
                    }
                    Navigator.pop(context); // Simula cambio
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Cambiar contraseña', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget campoTexto(String label, TextEditingController controller, {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        ),
        validator: (value) => value == null || value.trim().isEmpty ? 'Campo obligatorio' : null,
      ),
    );
  }
}

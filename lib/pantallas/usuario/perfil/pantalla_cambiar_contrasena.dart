import 'package:flutter/material.dart';

class PantallaCambiarContrasena extends StatefulWidget {
  const PantallaCambiarContrasena({super.key});

  @override
  State<PantallaCambiarContrasena> createState() => _PantallaCambiarContrasenaState();
}

class _PantallaCambiarContrasenaState extends State<PantallaCambiarContrasena> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _actualController = TextEditingController();
  final TextEditingController _nuevaController = TextEditingController();
  final TextEditingController _confirmarController = TextEditingController();

  void cambiarContrasena() {
    if (_formKey.currentState!.validate()) {
      // Aquí iría la lógica para actualizar la contraseña
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Contraseña actualizada correctamente')),
      );
      Navigator.pop(context);
    }
  }

  String? validarSeguridad(String? value) {
    if (value == null || value.isEmpty) return 'Ingresa una contraseña';
    if (value.length < 6) return 'Debe tener al menos 6 caracteres';
    if (!RegExp(r'[A-Z]').hasMatch(value)) return 'Debe tener al menos una mayúscula';
    if (!RegExp(r'[0-9]').hasMatch(value)) return 'Debe tener al menos un número';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cambiar contraseña'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color.fromARGB(255, 76, 172, 175),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _actualController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Contraseña actual'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingresa tu contraseña actual' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nuevaController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Nueva contraseña'),
                validator: validarSeguridad,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _confirmarController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Confirmar nueva contraseña'),
                validator: (value) {
                  if (value != _nuevaController.text) {
                    return 'Las contraseñas no coinciden';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: cambiarContrasena,
                icon: const Icon(Icons.lock_reset),
                label: const Text('Actualizar contraseña'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 76, 172, 175),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class PantallaRegistroAdmin extends StatefulWidget {
  const PantallaRegistroAdmin({super.key});

  @override
  State<PantallaRegistroAdmin> createState() => _PantallaRegistroAdminState();
}

class _PantallaRegistroAdminState extends State<PantallaRegistroAdmin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _claveController = TextEditingController();

  void registrarAdmin() {
    if (_formKey.currentState!.validate()) {
      // Aquí iría la lógica para guardar el nuevo administrador
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Administrador registrado correctamente')),
      );
      _nombreController.clear();
      _correoController.clear();
      _claveController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar administrador'),
        backgroundColor: const Color.fromARGB(255, 76, 172, 175),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Nuevo perfil administrativo',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre completo',
                  errorStyle: TextStyle(color: Colors.red),
                ),
                validator: (value) =>
                    value == null || value.trim().isEmpty ? 'Este campo es obligatorio' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _correoController,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  errorStyle: TextStyle(color: Colors.red),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Correo inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _claveController,
                decoration: const InputDecoration(
                  labelText: 'Clave de acceso',
                  errorStyle: TextStyle(color: Colors.red),
                ),
                obscureText: true,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Este campo es obligatorio' : (value.length < 6 ? 'Mínimo 6 caracteres' : null),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: registrarAdmin,
                icon: const Icon(Icons.person_add),
                label: const Text('Registrar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 76, 172, 175),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

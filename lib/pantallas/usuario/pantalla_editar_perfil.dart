import 'package:flutter/material.dart';

class PantallaEditarPerfil extends StatefulWidget {
  const PantallaEditarPerfil({super.key});

  @override
  State<PantallaEditarPerfil> createState() => _PantallaEditarPerfilState();
}

class _PantallaEditarPerfilState extends State<PantallaEditarPerfil> {
  final _formKey = GlobalKey<FormState>();
  final nombreController = TextEditingController(text: 'Sofía');
  final correoController = TextEditingController(text: 'sofia.perez@gmail.com');
  final telefonoController = TextEditingController(text: '3001234567');
  final ubicacionController = TextEditingController(text: 'Bogotá');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar perfil'),
        backgroundColor: const Color.fromARGB(255, 76, 172, 175),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/images/sofia.png'),
              ),
              const SizedBox(height: 10),
              const Text('@sofiag', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 20),
              campoTexto('Nombre', nombreController),
              campoTexto('Correo electrónico', correoController),
              campoTexto('Teléfono', telefonoController),
              campoTexto('Ubicación', ubicacionController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context); // Simula guardar
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Guardar cambios', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget campoTexto(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
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

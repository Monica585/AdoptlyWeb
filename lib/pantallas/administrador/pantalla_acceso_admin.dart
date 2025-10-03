import 'package:flutter/material.dart';

class PantallaAccesoAdmin extends StatefulWidget {
  const PantallaAccesoAdmin({super.key});

  @override
  State<PantallaAccesoAdmin> createState() => _PantallaAccesoAdminState();
}

class _PantallaAccesoAdminState extends State<PantallaAccesoAdmin> {
  final TextEditingController _claveController = TextEditingController();
  final String claveMaestra = 'admin2025'; // Puedes mover esto a un archivo seguro

  void validarAcceso() {
    if (_claveController.text.trim() == claveMaestra) {
      Navigator.pushReplacementNamed(context, '/adminPanel');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Clave incorrecta')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acceso administrador'),
        backgroundColor: const Color.fromARGB(255, 76, 172, 175),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const Text(
              'Ingresa la clave de administrador',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _claveController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Clave',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: validarAcceso,
              icon: const Icon(Icons.lock_open),
              label: const Text('Entrar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 76, 172, 175),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

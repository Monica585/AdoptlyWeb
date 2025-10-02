import 'package:flutter/material.dart';

class PantallaNotificaciones extends StatelessWidget {
  const PantallaNotificaciones({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones'),
        backgroundColor: const Color.fromARGB(255, 76, 172, 175),
      ),
      body: const Center(
        child: Text(
          'Aquí recibirás actualizaciones importantes sobre tus mascotas y solicitudes',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class PantallaMisSolicitudes extends StatelessWidget {
  const PantallaMisSolicitudes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Solicitudes'),
        backgroundColor: const Color.fromARGB(255, 76, 172, 175),
      ),
      body: const Center(
        child: Text(
          'Aquí verás el estado de tus solicitudes de adopción',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

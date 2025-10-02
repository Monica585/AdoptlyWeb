import 'package:flutter/material.dart';

class PantallaSolicitudesAdmin extends StatelessWidget {
  const PantallaSolicitudesAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Solicitudes Admin")),
      body: const Center(
        child: Text("Pantalla Solicitudes Admin"),
      ),
    );
  }
}

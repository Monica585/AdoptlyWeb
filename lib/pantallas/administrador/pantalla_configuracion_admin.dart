import 'package:flutter/material.dart';

class PantallaConfiguracionAdmin extends StatelessWidget {
  const PantallaConfiguracionAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Configuración Admin")),
      body: const Center(
        child: Text("Pantalla Configuración Admin"),
      ),
    );
  }
}

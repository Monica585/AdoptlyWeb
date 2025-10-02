import 'package:flutter/material.dart';

class PantallaRegistroAdmin extends StatelessWidget {
  const PantallaRegistroAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro Admin")),
      body: const Center(
        child: Text("Pantalla Registro Admin"),
      ),
    );
  }
}

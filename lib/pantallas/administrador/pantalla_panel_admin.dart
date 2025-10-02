import 'package:flutter/material.dart';

class PantallaPanelAdmin extends StatelessWidget {
  const PantallaPanelAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Panel Admin")),
      body: const Center(
        child: Text("Pantalla Panel Admin"),
      ),
    );
  }
}

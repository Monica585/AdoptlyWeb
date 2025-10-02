import 'package:flutter/material.dart';

class PantallaPublicacionesPendientes extends StatelessWidget {
  const PantallaPublicacionesPendientes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Publicaciones Pendientes")),
      body: const Center(
        child: Text("Pantalla Publicaciones Pendientes"),
      ),
    );
  }
}

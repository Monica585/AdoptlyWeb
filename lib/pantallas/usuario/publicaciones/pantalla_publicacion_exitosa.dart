import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class PantallaPublicacionExitosa extends StatelessWidget {
  final String imagen;

  const PantallaPublicacionExitosa({super.key, required this.imagen});

  @override
  Widget build(BuildContext context) {
    Widget mostrarImagen;

    if (!kIsWeb && File(imagen).existsSync()) {
      mostrarImagen = Image.file(File(imagen), height: 150);
    } else {
      mostrarImagen = Image.asset(imagen, height: 150);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Publicar'),
        backgroundColor: const Color.fromARGB(255, 76, 172, 175),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            mostrarImagen,
            const SizedBox(height: 20),
            const Text(
              'Tu mascota ha sido publicada exitosamente',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/catalogo'),
              child: const Text('Ver en el catálogo'),
            ),
          ],
        ),
      ),
    );
  }
}

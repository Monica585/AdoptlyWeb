import 'dart:typed_data'; // Para mostrar imágenes en Web
import 'package:flutter/foundation.dart'; // Para detectar si es Web
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // Para mostrar imágenes en Android

class PantallaPublicacionPendiente extends StatelessWidget {
  final XFile imagen;

  const PantallaPublicacionPendiente({super.key, required this.imagen});

  @override
  Widget build(BuildContext context) {
    // Mostrar imagen según plataforma
    Widget mostrarImagen;

    if (kIsWeb) {
      // En Web usamos FutureBuilder para leer los bytes
      mostrarImagen = FutureBuilder<Uint8List>(
        future: imagen.readAsBytes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return Image.memory(snapshot.data!, height: 200);
          } else {
            return const CircularProgressIndicator();
          }
        },
      );
    } else {
      // En Android usamos File directamente
      mostrarImagen = Image.file(File(imagen.path), height: 200);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Publicar una mascota"),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            mostrarImagen,
            const SizedBox(height: 30),
            const Text(
              "Tu publicación ha sido recibida",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              "Tu publicación está pendiente de aprobación por el administrador. "
              "Una vez aprobada, aparecerá en el catálogo.",
              style: TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 76, 172, 175),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // Navega directamente a la pantalla principal del usuario (casita)
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/home', // Ruta definida en main.dart
                    (route) => false, // Elimina todas las rutas anteriores
                  );
                },
                child: const Text(
                  "Volver a la página de inicio",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

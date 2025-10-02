import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // Para Android
import 'dart:typed_data'; // Para Web
import 'package:flutter/foundation.dart'; // Para detectar si es Web

import 'pantalla_confirmar_publicacion.dart';
import 'pantalla_publicacion_pendiente.dart';

class PantallaPublicarMascota extends StatefulWidget {
  const PantallaPublicarMascota({super.key});

  @override
  State<PantallaPublicarMascota> createState() => _PantallaPublicarMascotaState();
}

class _PantallaPublicarMascotaState extends State<PantallaPublicarMascota> {
  final _formKey = GlobalKey<FormState>();

  final nombreController = TextEditingController();
  final razaController = TextEditingController();
  final edadController = TextEditingController();
  final descripcionController = TextEditingController();

  final nombreContactoController = TextEditingController();
  final telefonoController = TextEditingController();
  final correoController = TextEditingController();
  final ubicacionController = TextEditingController();

  XFile? imagenSeleccionada;
  Uint8List? imagenWeb;
  final ImagePicker _picker = ImagePicker();

  Future<void> seleccionarImagen() async {
    final XFile? imagen = await _picker.pickImage(source: ImageSource.gallery);
    if (imagen != null) {
      setState(() {
        imagenSeleccionada = imagen;
      });
      if (kIsWeb) {
        imagenWeb = await imagen.readAsBytes(); // Para mostrar en Web
      }
    }
  }

  void enviar() {
    if (!_formKey.currentState!.validate() || imagenSeleccionada == null) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Faltan datos'),
          content: const Text('Completa todos los campos y selecciona una imagen.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Aceptar'),
            ),
          ],
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PantallaConfirmarPublicacion(
          nombre: nombreController.text,
          raza: razaController.text,
          edad: edadController.text,
          descripcion: descripcionController.text,
          imagen: imagenSeleccionada!,
          onConfirmar: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => PantallaPublicacionPendiente(imagen: imagenSeleccionada!),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget campoTexto(String label, TextEditingController controller, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: label,
          filled: true,
          fillColor: Colors.grey[100],
          hintStyle: const TextStyle(color: Colors.black54),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        validator: (value) => value == null || value.trim().isEmpty ? 'Este campo es obligatorio' : null,
      ),
    );
  }

  Widget widgetSubirFoto() {
    return GestureDetector(
      onTap: seleccionarImagen,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Column(
          children: [
            imagenSeleccionada != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: kIsWeb
                        ? Image.memory(
                            imagenWeb!,
                            height: 150,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(imagenSeleccionada!.path),
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                  )
                : const Column(
                    children: [
                      Icon(Icons.cloud_upload, size: 40, color: Colors.grey),
                      SizedBox(height: 8),
                      Text("Subir foto", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text("Selecciona la foto para mostrar el animal", textAlign: TextAlign.center, style: TextStyle(color: Colors.black54)),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Dar en adopción'),
        backgroundColor: const Color.fromARGB(255, 76, 172, 175),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Información del animal', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              campoTexto('Nombre del animal', nombreController),
              campoTexto('Raza', razaController),
              campoTexto('Edad', edadController),
              campoTexto('Descripción', descripcionController, maxLines: 3),

              const SizedBox(height: 20),
              widgetSubirFoto(),

              const SizedBox(height: 30),
              const Text('Información del contacto', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              campoTexto('Nombre', nombreContactoController),
              campoTexto('Teléfono', telefonoController),
              campoTexto('Correo electrónico', correoController),
              campoTexto('Ubicación', ubicacionController),

              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: enviar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 76, 172, 175),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Dar en adopción...', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

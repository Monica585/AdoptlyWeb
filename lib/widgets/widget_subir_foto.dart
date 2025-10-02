import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class WidgetSubirFoto extends StatefulWidget {
  final void Function(XFile imagen) onImagenSeleccionada;

  const WidgetSubirFoto({super.key, required this.onImagenSeleccionada});

  @override
  State<WidgetSubirFoto> createState() => _WidgetSubirFotoState();
}

class _WidgetSubirFotoState extends State<WidgetSubirFoto> {
  File? imagenMovil;
  Uint8List? imagenWeb;
  final ImagePicker _picker = ImagePicker();

  Future<void> _seleccionarImagen() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      widget.onImagenSeleccionada(file); // ✅ comunica al padre

      if (kIsWeb) {
        final bytes = await file.readAsBytes();
        setState(() {
          imagenWeb = bytes;
          imagenMovil = null;
        });
      } else {
        setState(() {
          imagenMovil = File(file.path);
          imagenWeb = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget preview;

    if (imagenMovil != null) {
      preview = ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.file(imagenMovil!, height: 150, fit: BoxFit.cover),
      );
    } else if (imagenWeb != null) {
      preview = ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.memory(imagenWeb!, height: 150, fit: BoxFit.cover),
      );
    } else {
      preview = const Text(
        "Ninguna imagen seleccionada",
        style: TextStyle(color: Colors.black54),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Subir foto",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "Seleccione la foto para mostrar el animal.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 12),
          preview,
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: _seleccionarImagen,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 76, 172, 175),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text("Seleccionar imagen"),
          ),
        ],
      ),
    );
  }
}

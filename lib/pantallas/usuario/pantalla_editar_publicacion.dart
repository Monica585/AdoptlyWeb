import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../modelos/mascota.dart';

class PantallaEditarPublicacion extends StatefulWidget {
  final Mascota mascota;

  const PantallaEditarPublicacion({super.key, required this.mascota});

  @override
  State<PantallaEditarPublicacion> createState() => _PantallaEditarPublicacionState();
}

class _PantallaEditarPublicacionState extends State<PantallaEditarPublicacion> {
  late TextEditingController nombreController;
  late TextEditingController razaController;
  late TextEditingController edadController;
  late TextEditingController descripcionController;
  String estadoSeleccionado = 'Disponible';

  XFile? nuevaImagen;
  Uint8List? imagenWeb;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController(text: widget.mascota.nombre);
    razaController = TextEditingController(text: widget.mascota.raza);
    edadController = TextEditingController(text: widget.mascota.edad);
    descripcionController = TextEditingController(text: widget.mascota.descripcion);
    estadoSeleccionado = widget.mascota.estado;
  }

  Future<void> seleccionarImagen() async {
    final XFile? imagen = await _picker.pickImage(source: ImageSource.gallery);
    if (imagen != null) {
      setState(() {
        nuevaImagen = imagen;
      });
      if (kIsWeb) {
        imagenWeb = await imagen.readAsBytes();
      }
    }
  }

  Widget mostrarImagenActual() {
    if (nuevaImagen != null) {
      return kIsWeb
          ? Image.memory(imagenWeb!, height: 150)
          : Image.file(File(nuevaImagen!.path), height: 150);
    } else {
      return Image.asset(widget.mascota.imagen, height: 150, fit: BoxFit.cover);
    }
  }

  void guardarCambios() {
    // Aquí podrías actualizar la mascota en tu base de datos o provider
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cambios guardados')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar publicación'),
        backgroundColor: const Color.fromARGB(255, 76, 172, 175),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            mostrarImagenActual(),
            const SizedBox(height: 10),
            TextButton.icon(
              onPressed: seleccionarImagen,
              icon: const Icon(Icons.photo),
              label: const Text('Cambiar imagen'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: razaController,
              decoration: const InputDecoration(labelText: 'Raza'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: edadController,
              decoration: const InputDecoration(labelText: 'Edad'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descripcionController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: estadoSeleccionado,
              items: const [
                DropdownMenuItem(value: 'Disponible', child: Text('Disponible')),
                DropdownMenuItem(value: 'En proceso', child: Text('En proceso')),
                DropdownMenuItem(value: 'Adoptado', child: Text('Adoptado')),
              ],
              onChanged: (value) {
                if (value != null) setState(() => estadoSeleccionado = value);
              },
              decoration: const InputDecoration(labelText: 'Estado'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: guardarCambios,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 76, 172, 175),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Guardar cambios', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}

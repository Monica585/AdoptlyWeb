import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../modelos/mascota.dart';
import '../../providers/publicaciones_provider.dart';

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
  String tipoSeleccionado = 'Perro';

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
    tipoSeleccionado = widget.mascota.tipo;
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
    // Crear una nueva mascota con los datos actualizados
    final mascotaActualizada = Mascota(
      id: widget.mascota.id,
      nombre: nombreController.text,
      tipo: tipoSeleccionado,
      raza: razaController.text,
      edad: edadController.text,
      imagen: nuevaImagen != null ? nuevaImagen!.path : widget.mascota.imagen,
      descripcion: descripcionController.text,
      estado: estadoSeleccionado,
    );

    // Actualizar la mascota en el provider
    Provider.of<PublicacionesProvider>(context, listen: false).actualizarMascota(mascotaActualizada);

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
              value: tipoSeleccionado,
              items: const [
                DropdownMenuItem(value: 'Perro', child: Text('Perro')),
                DropdownMenuItem(value: 'Gato', child: Text('Gato')),
                DropdownMenuItem(value: 'Otro', child: Text('Otro')),
              ],
              onChanged: (value) {
                if (value != null) setState(() => tipoSeleccionado = value);
              },
              decoration: const InputDecoration(labelText: 'Tipo'),
            ),
            const SizedBox(height: 10),
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

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:typed_data';
import 'dart:io';
import '../../../modelos/mascota.dart';
import '../../../modelos/usuario.dart';
import '../../../providers/publicaciones_provider.dart';
import '../../../providers/usuario_provider.dart';
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
  String tipoSeleccionado = 'Perro';

  final nombreContactoController = TextEditingController();
  final telefonoController = TextEditingController();
  final correoController = TextEditingController();
  final ubicacionController = TextEditingController();

  // Expresión regular mejorada para correos válidos
  final emailRegExp = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$"
  );

  // 🔹 Eliminado el validador de solo números, ya no usamos esto:
  // final edadRegExp = RegExp(r'^\d+$');

  XFile? imagenSeleccionada;
  final ImagePicker _picker = ImagePicker();

  Future<void> seleccionarImagen() async {
    final XFile? imagen = await _picker.pickImage(source: ImageSource.gallery);
    if (imagen != null) {
      setState(() {
        imagenSeleccionada = imagen;
      });
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
          tipo: tipoSeleccionado,
          raza: razaController.text,
          edad: edadController.text,
          descripcion: descripcionController.text,
          imagen: imagenSeleccionada!,
          onConfirmar: () async {
            Uint8List? bytes;
            if (kIsWeb) {
              bytes = await imagenSeleccionada!.readAsBytes();
            } else {
              bytes = await File(imagenSeleccionada!.path).readAsBytes();
            }

            final nuevaMascota = Mascota(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              nombre: nombreController.text,
              tipo: tipoSeleccionado,
              raza: razaController.text,
              edad: edadController.text,
              imagen: imagenSeleccionada!.path,
              imagenBytes: bytes,
              descripcion: descripcionController.text,
              estado: 'Disponible',
              estadoAprobacion: 'pendiente',
            );

            Provider.of<PublicacionesProvider>(context, listen: false)
                .agregarPublicacion(nuevaMascota);

            // Actualizar información de contacto del usuario
            final usuarioProvider = Provider.of<UsuarioProvider>(context, listen: false);
            if (usuarioProvider.usuario != null) {
              usuarioProvider.usuario = Usuario(
                nombre: usuarioProvider.usuario!.nombre,
                correo: usuarioProvider.usuario!.correo,
                contrasena: usuarioProvider.usuario!.contrasena,
                fotoUrl: usuarioProvider.usuario!.fotoUrl,
                telefono: telefonoController.text.trim(),
                ubicacion: ubicacionController.text.trim(),
              );
            }

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

  Widget campoTexto(String label, TextEditingController controller,
      {int maxLines = 1, String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: label,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        validator: validator ??
            ((value) => value == null || value.trim().isEmpty
                ? 'Este campo es obligatorio'
                : null),
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
          border: Border.all(color: Colors.grey, width: 1.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            imagenSeleccionada != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: kIsWeb
                        ? Image.network(
                            imagenSeleccionada!.path,
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
                      Text("Seleccione la foto para mostrar al animal",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black54)),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget campoTipoAnimal() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: DropdownButtonFormField<String>(
        value: tipoSeleccionado,
        items: const [
          DropdownMenuItem(value: 'Perro', child: Text('Perro')),
          DropdownMenuItem(value: 'Gato', child: Text('Gato')),
          DropdownMenuItem(value: 'Otro', child: Text('Otro')),
        ],
        onChanged: (value) {
          if (value != null) setState(() => tipoSeleccionado = value);
        },
        decoration: InputDecoration(
          labelText: 'Tipo de animal',
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              campoTexto('Nombre del animal', nombreController),
              campoTipoAnimal(),
              campoTexto('Raza', razaController),

              // 🔹 CAMPO EDAD MODIFICADO: Ahora permite texto y número, solo valida que no esté vacío
              campoTexto(
                'Edad',
                edadController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'La edad es obligatoria';
                  }
                  return null; // Permite número y texto
                },
              ),

              campoTexto('Descripción', descripcionController, maxLines: 3),
              const SizedBox(height: 15),
              widgetSubirFoto(),
              const SizedBox(height: 20),
              const Text("Información de contacto",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              campoTexto('Nombre', nombreContactoController),
              campoTexto('Teléfono', telefonoController),
              campoTexto('Correo Electrónico', correoController, validator: (value) {
                if (value == null || value.trim().isEmpty) return 'El correo es obligatorio';
                if (!emailRegExp.hasMatch(value.trim())) return 'Correo inválido';
                return null;
              }),
              campoTexto('Ubicación', ubicacionController),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: enviar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 76, 172, 175),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Dar en adopción...',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

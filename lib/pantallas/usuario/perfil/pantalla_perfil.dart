import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import '../../../providers/usuario_provider.dart';

class PantallaPerfil extends StatefulWidget {
  const PantallaPerfil({super.key});

  @override
  State<PantallaPerfil> createState() => _PantallaPerfilState();
}

class _PantallaPerfilState extends State<PantallaPerfil> {
  XFile? imagenSeleccionada;

  Future<void> seleccionarImagen() async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? imagen = await picker.pickImage(source: ImageSource.gallery);
      if (imagen != null) {
        setState(() {
          imagenSeleccionada = imagen;
        });

        // Guardar la imagen en el provider para persistencia
        final usuarioProvider = Provider.of<UsuarioProvider>(context, listen: false);
        usuarioProvider.actualizarFoto(imagen.path);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al seleccionar la imagen')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<UsuarioProvider>(context).usuario;
    ImageProvider avatar;

    if (imagenSeleccionada != null) {
      avatar = kIsWeb
          ? NetworkImage(imagenSeleccionada!.path)
          : FileImage(File(imagenSeleccionada!.path)) as ImageProvider;
    } else if (usuario.fotoUrl != null && usuario.fotoUrl!.isNotEmpty) {
      // Verificar si es una URL o una ruta local
      if (usuario.fotoUrl!.startsWith('http')) {
        avatar = NetworkImage(usuario.fotoUrl!);
      } else {
        avatar = kIsWeb
            ? NetworkImage(usuario.fotoUrl!)
            : FileImage(File(usuario.fotoUrl!)) as ImageProvider;
      }
    } else {
      avatar = const AssetImage('assets/images/sofia.png');
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
          },
        ),
        title: const Text('Perfil'),
        backgroundColor: const Color.fromARGB(255, 76, 172, 175),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: seleccionarImagen,
              child: Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: avatar,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(4),
                      child: const Icon(Icons.camera_alt, size: 18, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(usuario.nombre, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Center(
              child: Text(usuario.correo, style: const TextStyle(color: Colors.grey)),
            ),
            const SizedBox(height: 30),
            const Text('Configuración de la cuenta', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Editar perfil'),
              onTap: () => Navigator.pushNamed(context, '/editarPerfil'),
            ),
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Cambiar contraseña'),
              onTap: () => Navigator.pushNamed(context, '/cambiarContrasena'),
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notificaciones'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Notificaciones'),
                    content: const Text('Aquí puedes configurar tus preferencias.'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cerrar')),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Eliminar cuenta'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('¿Eliminar cuenta?'),
                    content: const Text('Esta acción no se puede deshacer. ¿Estás segura?'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
                      TextButton(
                        onPressed: () {
                          // Aquí iría la lógica para eliminar la cuenta
                          Navigator.pop(context);
                        },
                        child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

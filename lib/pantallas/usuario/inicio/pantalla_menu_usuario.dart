import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/usuario_provider.dart';

class PantallaMenuUsuario extends StatelessWidget {
  const PantallaMenuUsuario({super.key});

  @override
  Widget build(BuildContext context) {
    final usuario = context.watch<UsuarioProvider>().usuario;
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color.fromARGB(255, 76, 172, 175)),
            child: Text(usuario?.nombre ?? 'Usuario', style: const TextStyle(fontSize: 24, color: Colors.white)),
          ),
          const SizedBox(height: 10),
          _itemMenu(context, 'Inicio', Icons.home, '/home'),
          _itemMenu(context, 'Dar en adopción', Icons.add, '/publicarMascota'),
          _itemMenu(context, 'Mis publicaciones', Icons.article, '/misPublicaciones'),
          _itemMenu(context, 'Mis solicitudes', Icons.assignment, '/misSolicitudes'),
          _itemMenu(context, 'Favoritos', Icons.favorite, '/favoritos'),
          _itemMenu(context, 'Perfil', Icons.person, '/perfil'),
          const Divider(),
          _itemMenu(context, 'Cerrar sesión', Icons.logout, '/login', cerrarSesion: true),
        ],
      ),
    );
  }

  Widget _itemMenu(BuildContext context, String titulo, IconData icono, String ruta, {bool cerrarSesion = false}) {
    return ListTile(
      leading: Icon(icono),
      title: Text(titulo),
      onTap: () {
        Navigator.pop(context); // Cierra el menú
        if (cerrarSesion) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Cerrar sesión'),
                content: const Text('¿Estás seguro de que quieres salir de tu cuenta?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Cierra el diálogo
                    },
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Cierra el diálogo
                      Navigator.pushReplacementNamed(context, ruta);
                    },
                    child: const Text('Salir'),
                  ),
                ],
              );
            },
          );
        } else {
          Navigator.pushNamed(context, ruta);
        }
      },
    );
  }
}

import 'package:flutter/material.dart';

class PantallaMenuUsuario extends StatelessWidget {
  const PantallaMenuUsuario({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color.fromARGB(255, 76, 172, 175)),
            child: Text('Sofía', style: TextStyle(fontSize: 24, color: Colors.white)),
          ),
          _itemMenu(context, 'Inicio', Icons.home, '/home'),
          _itemMenu(context, 'Dar en adopción', Icons.add, '/publicarMascota'),
          _itemMenu(context, 'Mis publicaciones', Icons.article, '/misPublicaciones'),
          _itemMenu(context, 'Favoritos', Icons.favorite, '/favoritos'),
          _itemMenu(context, 'Perfil', Icons.person, '/perfil'),
          _itemMenu(context, 'Centro de ayuda', Icons.help_outline, '/ayuda'),
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
          Navigator.pushReplacementNamed(context, ruta);
        } else {
          Navigator.pushNamed(context, ruta);
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'pantalla_catalogo_mascotas.dart';           // 🏠 Todas las mascotas
import 'pantalla_mascotas_disponibles.dart';       // 🐾 Solo disponibles
import 'pantalla_favoritos.dart';                  // ❤️ Favoritos sin AppBar
import 'pantalla_perfil.dart';                     // 👤 Perfil
import 'pantalla_publicar_mascota.dart';           // 📤 Publicar mascota
import 'pantalla_menu_usuario.dart';               // ☰ Drawer lateral

class PantallaInicio extends StatefulWidget {
  const PantallaInicio({super.key});

  @override
  State<PantallaInicio> createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {
  int indiceActual = 0;

  final List<Widget> pantallas = const [
    PantallaCatalogoMascotas(),         // Todas las mascotas
    PantallaMascotasDisponibles(),      //  Solo disponibles
    PantallaFavoritos(),                // Favoritos sin AppBar
    PantallaPerfil(),                   //  Perfil
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const PantallaMenuUsuario(),

      appBar: (indiceActual == 0 || indiceActual == 1)
          ? AppBar(
              title: Text(
                indiceActual == 0 ? 'Adopta' : 'Mascotas disponibles',
              ),
              backgroundColor: const Color.fromARGB(255, 76, 172, 175),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/publicarMascota');
                  },
                  child: const Text(
                    'Dar en adopción',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          : null,

      body: IndexedStack(index: indiceActual, children: pantallas),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indiceActual,
        onTap: (index) => setState(() => indiceActual = index),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: 'Disponibles'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favoritos'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Perfil'),
        ],
      ),
    );
  }
}

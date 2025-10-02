import 'package:flutter/material.dart';

class PantallaPerfil extends StatelessWidget {
  const PantallaPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: const Color.fromARGB(255, 76, 172, 175),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/sofia.png'),
            ),
            const SizedBox(height: 10),
            const Text('Sofía', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text('sofia.perez@gmail.com', style: TextStyle(color: Colors.grey)),
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
              onTap: () {}, // Puedes agregar lógica luego
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Eliminar cuenta'),
              onTap: () {}, // Confirmación y lógica
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        selectedItemColor: const Color.fromARGB(255, 76, 172, 175),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0: Navigator.pushNamed(context, '/home'); break;
            case 1: Navigator.pushNamed(context, '/buscar'); break;
            case 2: Navigator.pushNamed(context, '/favoritos'); break;
            case 3: break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favoritos'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}

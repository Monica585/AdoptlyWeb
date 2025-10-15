import 'package:flutter/material.dart';

class PantallaPanelAdmin extends StatelessWidget {
  const PantallaPanelAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel de administración'),
        backgroundColor: const Color.fromARGB(255, 76, 172, 175),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Bienvenida, administradora 👩‍💼',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          ListTile(
            leading: const Icon(Icons.assignment),
            title: const Text('Solicitudes de adopción'),
            onTap: () => Navigator.pushNamed(context, '/adminSolicitudes'),
          ),
          ListTile(
            leading: const Icon(Icons.pets),
            title: const Text('Publicaciones pendientes'),
            onTap: () => Navigator.pushNamed(context, '/adminPendientes'),
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text('Estadísticas'),
            onTap: () => Navigator.pushNamed(context, '/adminEstadisticas'),
          ),
          ListTile(
            leading: const Icon(Icons.person_add),
            title: const Text('Registrar administrador'),
            onTap: () => Navigator.pushNamed(context, '/adminRegistro'),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
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
                          Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                        },
                        child: const Text('Salir'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.logout),
            label: const Text('Cerrar sesión'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
        ],
      ),
    );
  }
}

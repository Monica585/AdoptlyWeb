import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import '../../modelos/mascota.dart';
import '../../providers/publicaciones_provider.dart';
import '../../providers/solicitudes_provider.dart';

// Pantallas
import 'pantalla_editar_publicacion.dart';

class PantallaMisPublicaciones extends StatelessWidget {
  const PantallaMisPublicaciones({super.key});

  @override
  Widget build(BuildContext context) {
    final publicaciones = context.watch<PublicacionesProvider>().publicaciones;
    final solicitudesProvider = context.watch<SolicitudesProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis publicaciones'),
        backgroundColor: const Color.fromARGB(255, 76, 172, 175),
      ),
      body: publicaciones.isEmpty
          ? const Center(child: Text('No has publicado ninguna mascota aún.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: publicaciones.length,
              itemBuilder: (context, index) {
                final mascota = publicaciones[index];
                final solicitudes = solicitudesProvider.solicitudesPorMascota(mascota.id);

                String resumenSolicitudes;
                if (solicitudes.isEmpty) {
                  resumenSolicitudes = 'Sin solicitudes';
                } else {
                  final pendientes = solicitudes.where((s) => s.estado.toLowerCase() == 'pendiente').length;
                  final aprobadas = solicitudes.where((s) => s.estado.toLowerCase() == 'aprobada').length;
                  final rechazadas = solicitudes.where((s) => s.estado.toLowerCase() == 'rechazada').length;
                  resumenSolicitudes =
                      'Solicitudes: $pendientes pendientes, $aprobadas aprobadas, $rechazadas rechazadas';
                }

                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: Image.asset(
                      mascota.imagen,
                      width: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.pets),
                    ),
                    title: Text(mascota.nombre),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${mascota.tipo} • ${mascota.raza} • ${mascota.edad} • ${mascota.estado}'),
                        Text(
                          resumenSolicitudes,
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PantallaEditarPublicacion(mascota: mascota),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
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
            case 3: Navigator.pushNamed(context, '/perfil'); break;
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

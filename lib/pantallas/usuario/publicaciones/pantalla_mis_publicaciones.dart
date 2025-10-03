import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import '../../../modelos/mascota.dart';
import '../../../modelos/solicitudAdopcion.dart';
import '../../../providers/publicaciones_provider.dart';
import '../../../providers/solicitudes_provider.dart';

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
                  final pendientes = solicitudes.where((s) => s.estado == EstadoSolicitud.pendiente).length;
                  final aprobadas = solicitudes.where((s) => s.estado == EstadoSolicitud.aprobada).length;
                  final rechazadas = solicitudes.where((s) => s.estado == EstadoSolicitud.rechazada).length;
                  resumenSolicitudes =
                      'Solicitudes: $pendientes pendientes, $aprobadas aprobadas, $rechazadas rechazadas';
                }

                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: mascota.imagenBytes != null
                        ? Image.memory(
                            mascota.imagenBytes!,
                            width: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.pets),
                          )
                        : mascota.imagen.startsWith('assets')
                            ? Image.asset(
                                mascota.imagen,
                                width: 60,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.pets),
                              )
                            : const Icon(Icons.pets),
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
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        switch (value) {
                          case 'edit':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PantallaEditarPublicacion(mascota: mascota),
                              ),
                            );
                            break;
                          case 'adopted':
                            _marcarComoAdoptado(context, mascota);
                            break;
                          case 'inProcess':
                            _marcarEnProceso(context, mascota);
                            break;
                          case 'delete':
                            _eliminarPublicacion(context, mascota);
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Text('Editar'),
                        ),
                        const PopupMenuItem(
                          value: 'adopted',
                          child: Text('Marcar como adoptado'),
                        ),
                        const PopupMenuItem(
                          value: 'inProcess',
                          child: Text('Marcar en proceso de adopción'),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text('Eliminar publicación'),
                        ),
                      ],
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
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/buscar');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/favoritos');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/perfil');
              break;
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

  void _marcarComoAdoptado(BuildContext context, Mascota mascota) {
    final mascotaActualizada = Mascota(
      id: mascota.id,
      nombre: mascota.nombre,
      tipo: mascota.tipo,
      raza: mascota.raza,
      edad: mascota.edad,
      imagen: mascota.imagen,
      imagenBytes: mascota.imagenBytes,
      descripcion: mascota.descripcion,
      estado: 'Adoptado',
      estadoAprobacion: mascota.estadoAprobacion,
    );
    Provider.of<PublicacionesProvider>(context, listen: false).actualizarMascota(mascotaActualizada);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${mascota.nombre} marcado como adoptado')),
    );
  }

  void _marcarEnProceso(BuildContext context, Mascota mascota) {
    final mascotaActualizada = Mascota(
      id: mascota.id,
      nombre: mascota.nombre,
      tipo: mascota.tipo,
      raza: mascota.raza,
      edad: mascota.edad,
      imagen: mascota.imagen,
      imagenBytes: mascota.imagenBytes,
      descripcion: mascota.descripcion,
      estado: 'En proceso',
      estadoAprobacion: mascota.estadoAprobacion,
    );
    Provider.of<PublicacionesProvider>(context, listen: false).actualizarMascota(mascotaActualizada);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${mascota.nombre} marcado en proceso de adopción')),
    );
  }

  void _eliminarPublicacion(BuildContext context, Mascota mascota) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text('¿Estás seguro de eliminar la publicación de ${mascota.nombre}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmar == true) {
      Provider.of<PublicacionesProvider>(context, listen: false).eliminarPublicacion(mascota.id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Publicación de ${mascota.nombre} eliminada')),
      );
    }
  }
}

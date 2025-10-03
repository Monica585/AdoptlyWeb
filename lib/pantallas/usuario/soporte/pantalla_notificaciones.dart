import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/solicitudes_provider.dart';
import '../../../providers/publicaciones_provider.dart';
import '../../../modelos/solicitudAdopcion.dart';

class PantallaNotificaciones extends StatelessWidget {
  const PantallaNotificaciones({super.key});

  @override
  Widget build(BuildContext context) {
    final solicitudesProvider = Provider.of<SolicitudesProvider>(context);
    final publicacionesProvider = Provider.of<PublicacionesProvider>(context);

    // Obtener todas las solicitudes para las publicaciones del usuario
    final misPublicaciones = publicacionesProvider.publicaciones;
    final misSolicitudes = <SolicitudAdopcion>[];
    for (final pub in misPublicaciones) {
      misSolicitudes.addAll(solicitudesProvider.solicitudesPorMascota(pub.id));
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
          },
        ),
        backgroundColor: const Color.fromARGB(255, 76, 172, 175),
      ),
      body: misSolicitudes.isEmpty
          ? const Center(
              child: Text(
                'No tienes notificaciones nuevas',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: misSolicitudes.length,
              itemBuilder: (context, index) {
                final solicitud = misSolicitudes[index];
                final mascota = solicitud.mascota;

                return ListTile(
                  leading: const Icon(Icons.notifications, color: Colors.blue),
                  title: Text('Solicitud de adopción para ${mascota.nombre}'),
                  subtitle: Text('Estado: ${solicitud.estado}'),
                  trailing: Text(solicitud.fecha.toString().split(' ')[0]),
                );
              },
            ),
    );
  }
}

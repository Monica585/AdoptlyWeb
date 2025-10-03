import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/publicaciones_provider.dart';

class PantallaPublicacionesPendientes extends StatelessWidget {
  const PantallaPublicacionesPendientes({super.key});

  @override
  Widget build(BuildContext context) {
    final publicacionesProvider = Provider.of<PublicacionesProvider>(context);
    final publicacionesPendientes = publicacionesProvider.publicacionesPendientes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Publicaciones pendientes'),
        backgroundColor: const Color.fromARGB(255, 76, 172, 175),
      ),
      body: publicacionesPendientes.isEmpty
          ? const Center(child: Text('No hay publicaciones pendientes'))
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: publicacionesPendientes.length,
              itemBuilder: (context, index) {
                final pub = publicacionesPendientes[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 20),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Mascota: ${pub.nombre} (${pub.tipo})',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('Edad: ${pub.edad}'),
                  Text('Estado: ${pub.estado}'),
                  Text('Estado de aprobación: ${pub.estadoAprobacion}'),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          publicacionesProvider.aprobarPublicacion(pub.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Mascota aprobada: ${pub.nombre}')),
                          );
                        },
                        icon: const Icon(Icons.check_circle),
                        label: const Text('Aprobar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          publicacionesProvider.rechazarPublicacion(pub.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Mascota rechazada: ${pub.nombre}')),
                          );
                        },
                        icon: const Icon(Icons.cancel),
                        label: const Text('Rechazar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

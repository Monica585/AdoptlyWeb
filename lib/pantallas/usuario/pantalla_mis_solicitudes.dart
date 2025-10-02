import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/solicitudes_provider.dart';
import '../../modelos/solicitudAdopcion.dart';

class PantallaMisSolicitudes extends StatelessWidget {
  const PantallaMisSolicitudes({super.key});

  @override
  Widget build(BuildContext context) {
    final solicitudes = Provider.of<SolicitudesProvider>(context).solicitudes;

    final pendientes = solicitudes
        .where((s) => s.estado == EstadoSolicitud.pendiente)
        .length;

    final aprobadas = solicitudes
        .where((s) => s.estado == EstadoSolicitud.aprobada)
        .length;

    final rechazadas = solicitudes
        .where((s) => s.estado == EstadoSolicitud.rechazada)
        .length;

    return Scaffold(
      appBar: AppBar(title: const Text("Solicitudes de Adopción")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("📌 Resumen:", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            Text("Pendientes: $pendientes"),
            Text("Aprobadas: $aprobadas"),
            Text("Rechazadas: $rechazadas"),
            const SizedBox(height: 30),
            Text("📋 Lista de Solicitudes:",
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: solicitudes.length,
                itemBuilder: (ctx, i) {
                  final solicitud = solicitudes[i];
                  return Card(
                    child: ListTile(
                      leading: Image.asset(
                        solicitud.mascota.imagen,
                        width: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.pets),
                      ),
                      title: Text(solicitud.mascota.nombre),
                      subtitle: Text(
                        "Estado: ${solicitud.estado.name} • Fecha: ${solicitud.fecha.toLocal().toString().split(' ')[0]}",
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

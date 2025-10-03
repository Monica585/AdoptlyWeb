import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/solicitudes_provider.dart';

class PantallaMisSolicitudes extends StatelessWidget {
  const PantallaMisSolicitudes({super.key});

  @override
  Widget build(BuildContext context) {
    final solicitudes = Provider.of<SolicitudesProvider>(context).solicitudes;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
          },
        ),
        title: const Text("Mis solicitudes"),
        backgroundColor: const Color.fromARGB(255, 76, 172, 175),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: solicitudes.isEmpty
            ? const Center(child: Text("Aún no has solicitado ninguna adopción"))
            : ListView.builder(
                itemCount: solicitudes.length,
                itemBuilder: (ctx, i) {
                  final solicitud = solicitudes[i];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
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
    );
  }
}

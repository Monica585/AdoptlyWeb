import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../../modelos/mascota.dart';
import '../../providers/publicaciones_provider.dart';
import 'pantalla_detalle_mascota.dart';
import 'pantalla_menu_usuario.dart';

class PantallaMascotasDisponibles extends StatefulWidget {
  const PantallaMascotasDisponibles({super.key});

  @override
  State<PantallaMascotasDisponibles> createState() =>
      _PantallaMascotasDisponiblesState();
}

class _PantallaMascotasDisponiblesState
    extends State<PantallaMascotasDisponibles> {
  String textoBusqueda = '';

  List<Mascota> getMascotasDisponibles(List<Mascota> publicaciones) {
    return publicaciones.where((m) {
      final esDisponible = m.estado.toLowerCase() == 'disponible';
      final esAprobada = m.estadoAprobacion == 'aprobada';
      final coincideBusqueda = m.nombre.toLowerCase().contains(textoBusqueda.toLowerCase()) ||
          m.raza.toLowerCase().contains(textoBusqueda.toLowerCase());
      return esDisponible && esAprobada && coincideBusqueda;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final publicacionesProvider = Provider.of<PublicacionesProvider>(context);
    final mascotasDisponibles = getMascotasDisponibles(publicacionesProvider.publicacionesAprobadas);

    return Scaffold(
      drawer: const PantallaMenuUsuario(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => setState(() => textoBusqueda = value),
              decoration: InputDecoration(
                hintText: 'Buscar mascotas disponibles',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: mascotasDisponibles.isEmpty
                  ? const Center(child: Text('No hay mascotas disponibles'))
                  : ListView.builder(
                      itemCount: mascotasDisponibles.length,
                      itemBuilder: (context, index) {
                        final mascota = mascotasDisponibles[index];
                        return Card(
                          elevation: 4,
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
                            subtitle: Text('${mascota.raza} • ${mascota.estado}'),
                            trailing: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        PantallaDetalleMascota(mascota: mascota),
                                  ),
                                );
                              },
                              child: const Text('Ver más'),
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

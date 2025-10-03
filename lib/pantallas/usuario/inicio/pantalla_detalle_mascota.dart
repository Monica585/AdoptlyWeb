import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../modelos/mascota.dart';
import '../../../modelos/solicitudAdopcion.dart';
import '../../../providers/favoritos_provider.dart';
import '../../../providers/solicitudes_provider.dart';
import 'pantalla_informacion_contacto.dart'; // importar la pantalla de contacto

class PantallaDetalleMascota extends StatelessWidget {
  final Mascota mascota;

  const PantallaDetalleMascota({super.key, required this.mascota});

  @override
  Widget build(BuildContext context) {
    final favoritosProvider = context.watch<FavoritosProvider>();
    final esFavorito = favoritosProvider.estaEnFavoritos(mascota.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(mascota.nombre),
        backgroundColor: const Color.fromARGB(255, 76, 172, 175),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen de la mascota
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: mascota.imagenBytes != null
                  ? Image.memory(
                      mascota.imagenBytes!,
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 220,
                        color: Colors.grey[300],
                        child: const Icon(Icons.pets, size: 60),
                      ),
                    )
                  : Container(
                      height: 220,
                      color: Colors.grey[300],
                      child: const Icon(Icons.pets, size: 60),
                    ),
            ),
            const SizedBox(height: 20),

            // Raza y estado
            Text(
              '${mascota.raza} • ${mascota.estado}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),

            // Descripción
            Text(mascota.descripcion, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 30),

            // Botones de acción
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      if (esFavorito) {
                        favoritosProvider.eliminar(mascota.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${mascota.nombre} eliminado de favoritos'),
                          ),
                        );
                      } else {
                        favoritosProvider.agregar(mascota);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${mascota.nombre} añadido a favoritos'),
                          ),
                        );
                      }
                    },
                    icon: Icon(
                      esFavorito ? Icons.favorite : Icons.favorite_border,
                      color: esFavorito ? Colors.red : Colors.black,
                    ),
                    label: Text(esFavorito ? 'Quitar de favoritos' : 'Favorito'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: mascota.estado == 'Disponible'
                        ? () {
                            final solicitudesProvider = Provider.of<SolicitudesProvider>(context, listen: false);
                            final solicitud = SolicitudAdopcion(
                              id: 's${DateTime.now().millisecondsSinceEpoch}',
                              mascota: mascota,
                              estado: EstadoSolicitud.pendiente,
                              fecha: DateTime.now(),
                            );
                            solicitudesProvider.agregarSolicitud(solicitud);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Solicitud enviada para ${mascota.nombre}')),
                            );
                            Navigator.pushNamed(context, '/misSolicitudes');
                          }
                        : null,
                    icon: const Icon(Icons.pets),
                    label: Text(
                      mascota.estado == 'Disponible'
                          ? 'Solicitar adopción'
                          : mascota.estado == 'Adoptado'
                              ? 'Ya adoptado'
                              : 'En proceso',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 76, 172, 175),
                      foregroundColor: Colors.black,
                      disabledBackgroundColor: Colors.grey[300],
                      disabledForegroundColor: Colors.black45,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Botón para ver información del contacto
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PantallaInformacionContacto(),
                  ),
                );
              },
              icon: const Icon(Icons.info_outline),
              label: const Text('Información del contacto'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[100],
                foregroundColor: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

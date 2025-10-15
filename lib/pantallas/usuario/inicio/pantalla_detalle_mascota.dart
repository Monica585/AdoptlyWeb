import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../modelos/mascota.dart';
import '../../../providers/favoritos_provider.dart';
import 'pantalla_informacion_contacto.dart'; // importar la pantalla de contacto
import 'pantalla_solicitar_adopcion.dart'; // importar la pantalla de solicitud

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
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 300,
                        color: Colors.grey[300],
                        child: const Icon(Icons.pets, size: 80),
                      ),
                    )
                  : mascota.imagen.startsWith('assets/')
                      ? Image.asset(
                          mascota.imagen,
                          height: 300,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            height: 300,
                            color: Colors.grey[300],
                            child: const Icon(Icons.pets, size: 80),
                          ),
                        )
                      : Container(
                          height: 300,
                          color: Colors.grey[300],
                          child: const Icon(Icons.pets, size: 80),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PantallaSolicitarAdopcion(mascota: mascota),
                              ),
                            );
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

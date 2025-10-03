import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../modelos/mascota.dart';
import '../../../providers/favoritos_provider.dart';
import '../../../providers/publicaciones_provider.dart';
import 'pantalla_detalle_mascota.dart';
import 'pantalla_menu_usuario.dart';

class PantallaCatalogoMascotas extends StatefulWidget {
  const PantallaCatalogoMascotas({super.key});

  @override
  State<PantallaCatalogoMascotas> createState() => _PantallaCatalogoMascotasState();
}

class _PantallaCatalogoMascotasState extends State<PantallaCatalogoMascotas> {
  final List<Mascota> mascotasEjemplo = [
    Mascota(
      id: 'max',
      nombre: 'Max',
      tipo: 'Perro',
      raza: 'Golden Retriever',
      edad: '4 años',
      imagen: 'assets/images/max.png',
      descripcion: 'Max es un perro cariñoso y juguetón.',
      estado: 'Disponible',
      estadoAprobacion: 'aprobada',
    ),
    Mascota(
      id: 'luna',
      nombre: 'Luna',
      tipo: 'Perro',
      raza: 'Samoyedo',
      edad: '3 años',
      imagen: 'assets/images/luna.png',
      descripcion: 'Luna es dulce y tranquila.',
      estado: 'En proceso de adopción',
      estadoAprobacion: 'aprobada',
    ),
    Mascota(
      id: 'rocky',
      nombre: 'Rocky',
      tipo: 'Perro',
      raza: 'Labrador',
      edad: '5 años',
      imagen: 'assets/images/rocky.png',
      descripcion: 'Rocky es muy activo.',
      estado: 'Adoptado',
      estadoAprobacion: 'aprobada',
    ),
    Mascota(
      id: 'milo',
      nombre: 'Milo',
      tipo: 'Gato',
      raza: 'Gato doméstico',
      edad: '2 años',
      imagen: 'assets/images/milo.png',
      descripcion: 'Milo es curioso y sociable.',
      estado: 'En proceso',
      estadoAprobacion: 'aprobada',
    ),
    Mascota(
      id: 'nube',
      nombre: 'Nube',
      tipo: 'Otro',
      raza: 'Conejo',
      edad: '1 año',
      imagen: 'assets/images/nube.png',
      descripcion: 'Nube es suave y silencioso.',
      estado: 'Disponible',
      estadoAprobacion: 'aprobada',
    ),
  ];

  String filtroTipo = 'Todos';
  String textoBusqueda = '';

  List<Mascota> getMascotasFiltradas(List<Mascota> todasLasMascotas) {
    return todasLasMascotas.where((m) {
      final esAprobada = m.estadoAprobacion == 'aprobada';
      final coincideBusqueda = m.nombre.toLowerCase().contains(textoBusqueda.toLowerCase()) ||
          m.raza.toLowerCase().contains(textoBusqueda.toLowerCase());

      final coincideTipo = filtroTipo == 'Todos' ||
          (filtroTipo == 'Perros' && m.tipo == 'Perro') ||
          (filtroTipo == 'Gatos' && m.tipo == 'Gato') ||
          (filtroTipo == 'Otros' && m.tipo == 'Otro');

      return esAprobada && coincideBusqueda && coincideTipo;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final favoritosProvider = Provider.of<FavoritosProvider>(context);
    final publicacionesProvider = Provider.of<PublicacionesProvider>(context);

    // ✅ Se combinan mascotas de ejemplo con las aprobadas del provider
    final todasLasMascotas = [...mascotasEjemplo, ...publicacionesProvider.publicacionesAprobadas];
    final mascotasFiltradas = getMascotasFiltradas(todasLasMascotas);

    return Scaffold(
      drawer: const PantallaMenuUsuario(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 🔍 Buscador
            TextField(
              onChanged: (value) => setState(() => textoBusqueda = value),
              decoration: InputDecoration(
                hintText: 'Buscar por nombre o raza',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 🐾 Filtros por tipo
            Wrap(
              spacing: 10,
              children: [
                ChoiceChip(
                  label: const Text('Todos'),
                  selected: filtroTipo == 'Todos',
                  onSelected: (_) => setState(() => filtroTipo = 'Todos'),
                ),
                ChoiceChip(
                  label: const Text('Perros'),
                  selected: filtroTipo == 'Perros',
                  onSelected: (_) => setState(() => filtroTipo = 'Perros'),
                ),
                ChoiceChip(
                  label: const Text('Gatos'),
                  selected: filtroTipo == 'Gatos',
                  onSelected: (_) => setState(() => filtroTipo = 'Gatos'),
                ),
                ChoiceChip(
                  label: const Text('Otros'),
                  selected: filtroTipo == 'Otros',
                  onSelected: (_) => setState(() => filtroTipo = 'Otros'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 📋 Lista de mascotas
            Expanded(
              child: mascotasFiltradas.isEmpty
                  ? const Center(child: Text('No se encontraron mascotas'))
                  : ListView.builder(
                      itemCount: mascotasFiltradas.length,
                      itemBuilder: (context, index) {
                        final mascota = mascotasFiltradas[index];
                        final enFavoritos = favoritosProvider.estaEnFavoritos(mascota.id);

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
                            subtitle: Text('${mascota.raza} • ${mascota.edad} • ${mascota.estado}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    enFavoritos ? Icons.favorite : Icons.favorite_border,
                                    color: enFavoritos ? Colors.red : Colors.grey,
                                  ),
                                  onPressed: () {
                                    if (enFavoritos) {
                                      favoritosProvider.eliminar(mascota.id);
                                    } else {
                                      favoritosProvider.agregar(mascota);
                                    }
                                  },
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => PantallaDetalleMascota(mascota: mascota),
                                      ),
                                    );
                                  },
                                  child: const Text('Ver más'),
                                ),
                              ],
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

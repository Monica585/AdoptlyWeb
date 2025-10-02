import 'package:flutter/material.dart';
import '../../modelos/mascota.dart';
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
  final List<Mascota> todasLasMascotas = [
    Mascota(
        id: '1',
        nombre: 'Max',
        tipo: 'Perro',
        raza: 'Golden Retriever',
        edad: '4 años',
        imagen: 'assets/images/max.png',
        descripcion: 'Max es un perro cariñoso y juguetón.',
        estado: 'Disponible'),
    Mascota(
        id: '2',
        nombre: 'Luna',
        tipo: 'Perro',
        raza: 'Samoyedo',
        edad: '3 años',
        imagen: 'assets/images/luna.png',
        descripcion: 'Luna es dulce y tranquila.',
        estado: 'En proceso de adopción'),
    Mascota(
        id: '3',
        nombre: 'Rocky',
        tipo: 'Perro',
        raza: 'Labrador',
        edad: '5 años',
        imagen: 'assets/images/rocky.png',
        descripcion: 'Rocky es muy activo.',
        estado: 'Adoptado'),
    Mascota(
        id: '4',
        nombre: 'Milo',
        tipo: 'Gato',
        raza: 'Gato doméstico',
        edad: '2 años',
        imagen: 'assets/images/milo.png',
        descripcion: 'Milo es curioso y sociable.',
        estado: 'En proceso'),
    Mascota(
        id: '5',
        nombre: 'Nube',
        tipo: 'Otro',
        raza: 'Conejo',
        edad: '1 año',
        imagen: 'assets/images/nube.png',
        descripcion: 'Nube es suave y silencioso.',
        estado: 'Disponible'),
  ];

  String textoBusqueda = '';

  List<Mascota> get mascotasDisponibles {
    return todasLasMascotas.where((m) {
      final esDisponible = m.estado.toLowerCase() == 'disponible';
      final coincideBusqueda = m.nombre.toLowerCase().contains(textoBusqueda.toLowerCase()) ||
          m.raza.toLowerCase().contains(textoBusqueda.toLowerCase());
      return esDisponible && coincideBusqueda;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
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
                            leading: Image.asset(
                              mascota.imagen,
                              width: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.pets),
                            ),
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

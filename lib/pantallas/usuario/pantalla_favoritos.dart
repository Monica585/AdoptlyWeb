import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/favoritos_provider.dart';

class PantallaFavoritos extends StatelessWidget {
  const PantallaFavoritos({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritos = context.watch<FavoritosProvider>().favoritos;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
          },
        ),
        title: const Text('Favoritos'),
        backgroundColor: const Color.fromARGB(255, 76, 172, 175),
      ),
      body: favoritos.isEmpty
          ? const Center(child: Text('No tienes mascotas favoritas aún.'))
          : ListView.builder(
              itemCount: favoritos.length,
              itemBuilder: (context, index) {
                final mascota = favoritos[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(mascota.imagen),
                  ),
                  title: Text(mascota.nombre),
                  subtitle: Text(mascota.raza),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      final confirmar = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Confirmar eliminación"),
                          content: Text(
                            "¿Estás seguro de eliminar a ${mascota.nombre} de tus favoritos?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.of(context).pop(false),
                              child: const Text("Cancelar"),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.of(context).pop(true),
                              child: const Text(
                                "Eliminar",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );

                      if (confirmar == true) {
                        context.read<FavoritosProvider>().eliminar(mascota.id);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                "${mascota.nombre} fue eliminado de tus favoritos"),
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            ),
    );
  }
}

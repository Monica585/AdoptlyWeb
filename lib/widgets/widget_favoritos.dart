import 'package:flutter/material.dart';

class WidgetFavoritos extends StatelessWidget {
  final List<Map<String, String>> favoritos;
  final void Function(int index) onEliminar;

  const WidgetFavoritos({super.key, required this.favoritos, required this.onEliminar});

  @override
  Widget build(BuildContext context) {
    if (favoritos.isEmpty) {
      return const Center(child: Text('No tienes mascotas favoritas aún.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: favoritos.length,
      itemBuilder: (context, index) {
        final mascota = favoritos[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    mascota['imagen']!,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(mascota['nombre']!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(mascota['especie']!, style: const TextStyle(color: Colors.black54)),
                      const SizedBox(height: 8),
                      TextButton.icon(
                        onPressed: () => onEliminar(index),
                        icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                        label: const Text('Eliminar de Favoritos', style: TextStyle(color: Colors.redAccent)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PantallaConfirmarPublicacion extends StatelessWidget {
  final String nombre;
  final String raza;
  final String edad;
  final String descripcion;
  final XFile imagen;
  final VoidCallback onConfirmar;

  const PantallaConfirmarPublicacion({
    super.key,
    required this.nombre,
    required this.raza,
    required this.edad,
    required this.descripcion,
    required this.imagen,
    required this.onConfirmar,
  });

  @override
  Widget build(BuildContext context) {
    Widget mostrarImagen;

    if (kIsWeb) {
      mostrarImagen = FutureBuilder<Uint8List>(
        future: imagen.readAsBytes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            return Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[100],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.memory(
                  snapshot.data!,
                  fit: BoxFit.contain, // Cambiado de cover a contain para mostrar imagen completa
                  width: double.infinity,
                ),
              ),
            );
          } else {
            return Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200],
              ),
              child: const Center(child: CircularProgressIndicator()),
            );
          }
        },
      );
    } else {
      mostrarImagen = Container(
        width: double.infinity,
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[100],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(
            File(imagen.path),
            fit: BoxFit.contain, // Cambiado de cover a contain para mostrar imagen completa
            width: double.infinity,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[50], // Fondo ligeramente gris como en la referencia
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CACA7),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Confirmar publicación',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Información de la mascota',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  Column(
                    children: [
                      _buildInfoRow('Nombre', nombre),
                      const SizedBox(height: 12),
                      _buildInfoRow('Raza', raza),
                      const SizedBox(height: 12),
                      _buildInfoRow('Edad', edad),
                      const SizedBox(height: 12),
                      _buildInfoRow('Descripción', descripcion),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  mostrarImagen,
                  
                  const SizedBox(height: 24),
                  
                  const Text(
                    '¿Estás seguro de que quieres publicar esta mascota con la información proporcionada?',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2, // Botón cancelar más pequeño
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[400],
                      foregroundColor: Colors.white,
                      elevation: 0,
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 3, // Botón confirmar más grande para que el texto quepa en una línea
                  child: ElevatedButton(
                    onPressed: onConfirmar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CACA7),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text(
                      'Confirmar publicación',
                      style: TextStyle(
                        fontSize: 14, // Reducido el tamaño de fuente para que quepa mejor
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            '$label:',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/publicaciones_provider.dart';
import '../../providers/usuarios_provider.dart';

class PantallaEstadisticas extends StatelessWidget {
  const PantallaEstadisticas({super.key});

  @override
  Widget build(BuildContext context) {
    final publicacionesProvider = Provider.of<PublicacionesProvider>(context);
    final usuariosProvider = Provider.of<UsuariosProvider>(context);

    final adopciones = publicacionesProvider.publicaciones.where((m) => m.estado == 'Adoptado').length;
    final publicaciones = publicacionesProvider.publicacionesAprobadas.length;
    final usuariosActivos = usuariosProvider.usuarios.length;
    final mascotasPendientes = publicacionesProvider.publicacionesPendientes.length;

    final estadisticas = {
      'adopciones': adopciones,
      'publicaciones': publicaciones,
      'usuariosActivos': usuariosActivos,
      'mascotasPendientes': mascotasPendientes,
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Estadísticas del sistema'),
        backgroundColor: const Color.fromARGB(255, 76, 172, 175),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Resumen general',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Tarjetas de estadísticas
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                _tarjetaEstadistica('Adopciones completadas', estadisticas['adopciones']!, Icons.favorite, Colors.pink),
                _tarjetaEstadistica('Mascotas publicadas', estadisticas['publicaciones']!, Icons.pets, Colors.blue),
                _tarjetaEstadistica('Usuarios activos', estadisticas['usuariosActivos']!, Icons.people, Colors.green),
                _tarjetaEstadistica('Pendientes por aprobar', estadisticas['mascotasPendientes']!, Icons.hourglass_top, Colors.orange),
              ],
            ),

            const SizedBox(height: 40),
            const Text(
              'Gráficos y tendencias (próximamente)',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 10),
            const Text(
              'Aquí podrás ver visualizaciones de adopciones por mes, tipos de mascotas más adoptadas, y más.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tarjetaEstadistica(String titulo, int valor, IconData icono, Color color) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icono, size: 30, color: color),
          const SizedBox(height: 10),
          Text('$valor', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
          Text(titulo, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

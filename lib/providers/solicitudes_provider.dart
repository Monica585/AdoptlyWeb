import 'package:flutter/material.dart';
import '../modelos/solicitudAdopcion.dart';
import '../modelos/mascota.dart';

class SolicitudesProvider with ChangeNotifier {
  final List<SolicitudAdopcion> _solicitudes = [
    SolicitudAdopcion(
      id: 's1',
      mascota: Mascota(
        id: '1',
        nombre: 'Max',
        tipo: 'Perro',
        raza: 'Golden Retriever',
        edad: '4 años',
        imagen: 'assets/images/max.png',
        descripcion: 'Max es un perro cariñoso y juguetón.',
        estado: 'Disponible',
      ),
      estado: EstadoSolicitud.pendiente,
      fecha: DateTime.now().subtract(const Duration(days: 2)),
    ),
    SolicitudAdopcion(
      id: 's2',
      mascota: Mascota(
        id: '4',
        nombre: 'Luna',
        tipo: 'Gato',
        raza: 'Siamés',
        edad: '3 años',
        imagen: 'assets/images/luna.png',
        descripcion: 'Luna es dulce y curiosa.',
        estado: 'Disponible',
      ),
      estado: EstadoSolicitud.aprobada,
      fecha: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];

  List<SolicitudAdopcion> get solicitudes => List.unmodifiable(_solicitudes);

  List<SolicitudAdopcion> solicitudesPorMascota(String mascotaId) {
    return _solicitudes.where((s) => s.mascota.id == mascotaId).toList();
  }
}

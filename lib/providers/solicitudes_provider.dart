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
      idSolicitante: 'usuario1',
      idPublicador: 'usuario2',
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
      idSolicitante: 'usuario3',
      idPublicador: 'usuario2',
    ),
  ];

  List<SolicitudAdopcion> get solicitudes => List.unmodifiable(_solicitudes);

  List<SolicitudAdopcion> solicitudesPorMascota(String mascotaId) {
    return _solicitudes.where((s) => s.mascota.id == mascotaId).toList();
  }

  void aprobarSolicitud(String solicitudId) {
    final index = _solicitudes.indexWhere((s) => s.id == solicitudId && s.estado == EstadoSolicitud.pendiente);
    if (index != -1) {
      _solicitudes[index] = SolicitudAdopcion(
        id: _solicitudes[index].id,
        mascota: _solicitudes[index].mascota,
        estado: EstadoSolicitud.aprobada,
        fecha: _solicitudes[index].fecha,
        idSolicitante: _solicitudes[index].idSolicitante,
        idPublicador: _solicitudes[index].idPublicador,
      );
      notifyListeners();
    }
  }

  void rechazarSolicitud(String solicitudId) {
    final index = _solicitudes.indexWhere((s) => s.id == solicitudId && s.estado == EstadoSolicitud.pendiente);
    if (index != -1) {
      _solicitudes[index] = SolicitudAdopcion(
        id: _solicitudes[index].id,
        mascota: _solicitudes[index].mascota,
        estado: EstadoSolicitud.rechazada,
        fecha: _solicitudes[index].fecha,
        idSolicitante: _solicitudes[index].idSolicitante,
        idPublicador: _solicitudes[index].idPublicador,
      );
      notifyListeners();
    }
  }

  List<SolicitudAdopcion> solicitudesPorPublicador(String publicadorId) {
    return _solicitudes.where((s) => s.idPublicador == publicadorId).toList();
  }

  List<SolicitudAdopcion> solicitudesPorSolicitante(String solicitanteId) {
    return _solicitudes.where((s) => s.idSolicitante == solicitanteId).toList();
  }

  void agregarSolicitud(SolicitudAdopcion solicitud) {
    // Verificar si ya existe una solicitud pendiente para esta mascota por el mismo usuario
    final existeSolicitud = _solicitudes.any((s) =>
        s.mascota.id == solicitud.mascota.id &&
        s.estado == EstadoSolicitud.pendiente);

    if (existeSolicitud) {
      throw Exception('Ya tienes una solicitud pendiente para esta mascota');
    }

    _solicitudes.add(solicitud);
    notifyListeners();
  }
}

import 'mascota.dart';

/// Enum para controlar los estados de la solicitud
enum EstadoSolicitud { pendiente, aprobada, rechazada }

class SolicitudAdopcion {
  final String id;
  final Mascota mascota;
  final EstadoSolicitud estado;
  final DateTime fecha;

  SolicitudAdopcion({
    required this.id,
    required this.mascota,
    required this.estado,
    required this.fecha,
  });
}

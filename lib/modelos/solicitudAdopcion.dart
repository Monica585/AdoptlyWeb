import 'mascota.dart';

class SolicitudAdopcion {
  final String id;
  final Mascota mascota;
  final String estado; // Pendiente, Aprobada, Rechazada
  final DateTime fecha;

  SolicitudAdopcion({
    required this.id,
    required this.mascota,
    required this.estado,
    required this.fecha,
  });
}

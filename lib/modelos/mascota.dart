import 'dart:typed_data';
import 'dart:convert';

class Mascota {
  final String id;
  final String nombre;
  final String tipo; // 🐾 Perro, Gato, Otro
  final String raza;
  final String edad;
  final String imagen;
  final Uint8List? imagenBytes;
  final String descripcion;
  final String estado;
  final String estadoAprobacion; // pendiente, aprobada, rechazada

  Mascota({
    required this.id,
    required this.nombre,
    required this.tipo,
    required this.raza,
    required this.edad,
    required this.imagen,
    this.imagenBytes,
    required this.descripcion,
    required this.estado,
    this.estadoAprobacion = 'pendiente',
  });

  // 🔄 Para Firebase o APIs
  Map<String, dynamic> toJson() => {
    'id': id,
    'nombre': nombre,
    'tipo': tipo,
    'raza': raza,
    'edad': edad,
    'imagen': imagen,
    'imagenBytes': imagenBytes != null ? base64Encode(imagenBytes!) : null,
    'descripcion': descripcion,
    'estado': estado,
    'estadoAprobacion': estadoAprobacion,
  };

  factory Mascota.fromJson(Map<String, dynamic> json) => Mascota(
    id: json['id'],
    nombre: json['nombre'],
    tipo: json['tipo'],
    raza: json['raza'],
    edad: json['edad'],
    imagen: json['imagen'],
    imagenBytes: json['imagenBytes'] != null ? base64Decode(json['imagenBytes']) : null,
    descripcion: json['descripcion'],
    estado: json['estado'],
    estadoAprobacion: json['estadoAprobacion'] ?? 'pendiente',
  );
}

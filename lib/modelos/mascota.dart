class Mascota {
  final String id;
  final String nombre;
  final String tipo; // 🐾 Perro, Gato, Otro
  final String raza;
  final String edad;
  final String imagen;
  final String descripcion;
  final String estado;

  Mascota({
    required this.id,
    required this.nombre,
    required this.tipo,
    required this.raza,
    required this.edad,
    required this.imagen,
    required this.descripcion,
    required this.estado,
  });

  // 🔄 Para Firebase o APIs
  Map<String, dynamic> toJson() => {
    'id': id,
    'nombre': nombre,
    'tipo': tipo,
    'raza': raza,
    'edad': edad,
    'imagen': imagen,
    'descripcion': descripcion,
    'estado': estado,
  };

  factory Mascota.fromJson(Map<String, dynamic> json) => Mascota(
    id: json['id'],
    nombre: json['nombre'],
    tipo: json['tipo'],
    raza: json['raza'],
    edad: json['edad'],
    imagen: json['imagen'],
    descripcion: json['descripcion'],
    estado: json['estado'],
  );
}

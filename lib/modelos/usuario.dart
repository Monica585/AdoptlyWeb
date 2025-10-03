class Usuario {
  String nombre;
  String correo;
  String contrasena;
  String? fotoUrl;
  String? telefono;
  String? ubicacion;

  Usuario({
    required this.nombre,
    required this.correo,
    required this.contrasena,
    this.fotoUrl,
    this.telefono,
    this.ubicacion,
  });
}

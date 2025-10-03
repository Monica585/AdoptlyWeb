class Usuario {
  String nombre;
  String correo;
  String contrasena;
  String? fotoUrl;

  Usuario({
    required this.nombre,
    required this.correo,
    required this.contrasena,
    this.fotoUrl,
  });
}

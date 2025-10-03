import 'package:flutter/material.dart';
import '../modelos/usuario.dart';

class UsuariosProvider with ChangeNotifier {
  final List<Usuario> _usuarios = [];

  List<Usuario> get usuarios => List.unmodifiable(_usuarios);

  // Registrar un nuevo usuario
  bool registrarUsuario(String nombre, String correo, String contrasena) {
    // Verificar si el correo ya existe
    if (_usuarios.any((u) => u.correo == correo)) {
      return false; // Correo ya registrado
    }

    final nuevoUsuario = Usuario(
      nombre: nombre,
      correo: correo,
      contrasena: contrasena,
    );

    _usuarios.add(nuevoUsuario);
    notifyListeners();
    return true;
  }

  // Validar login
  Usuario? validarLogin(String correo, String contrasena) {
    try {
      return _usuarios.firstWhere(
        (u) => u.correo == correo && u.contrasena == contrasena,
      );
    } catch (e) {
      return null; // No encontrado
    }
  }

  // Verificar si es admin
  bool esAdmin(String correo, String contrasena) {
    return correo == 'admin@adoptly.com' && contrasena == 'admin2015';
  }
}
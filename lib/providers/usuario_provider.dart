import 'package:flutter/material.dart';
import '../modelos/usuario.dart';

class UsuarioProvider with ChangeNotifier {
  Usuario _usuario = Usuario(
    id: 'usuario_actual',
    nombre: 'Sofía',
    correo: 'sofia.perez@gmail.com',
    contrasena: 'password',
    fotoUrl: null,
  );

  Usuario get usuario => _usuario;

  set usuario(Usuario nuevoUsuario) {
    _usuario = nuevoUsuario;
    notifyListeners();
  }

  void actualizarPerfil({required String nombre, required String correo}) {
    _usuario.nombre = nombre;
    _usuario.correo = correo;
    notifyListeners();
  }

  void actualizarFoto(String url) {
    _usuario.fotoUrl = url;
    notifyListeners();
  }
}

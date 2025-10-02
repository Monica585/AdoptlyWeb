import 'package:flutter/material.dart';
import '../modelos/mascota.dart';

class FavoritosProvider with ChangeNotifier {
  final List<Mascota> _favoritos = [];

  List<Mascota> get favoritos => _favoritos;

  void agregar(Mascota mascota) {
    if (!_favoritos.any((m) => m.id == mascota.id)) {
      _favoritos.add(mascota);
      notifyListeners();
    }
  }

  void eliminar(String id) {
    _favoritos.removeWhere((m) => m.id == id);
    notifyListeners();
  }

  bool estaEnFavoritos(String id) {
    return _favoritos.any((m) => m.id == id);
  }
}

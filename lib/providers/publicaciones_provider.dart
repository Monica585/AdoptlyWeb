import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../modelos/mascota.dart';

class PublicacionesProvider with ChangeNotifier {
  final List<Mascota> _publicaciones = [];

  PublicacionesProvider() {
    _loadPublicaciones();
    _initializeDefaultPublicaciones();
  }

  Future<void> _initializeDefaultPublicaciones() async {
    final prefs = await SharedPreferences.getInstance();
    final hasInitialized = prefs.getBool('initialized') ?? false;
    if (!hasInitialized) {
      final defaultPublicaciones = [
        Mascota(
          id: '1',
          nombre: 'Max',
          tipo: 'Perro',
          raza: 'Golden Retriever',
          edad: '4 años',
          imagen: 'assets/images/max.png',
          descripcion: 'Max es un perro cariñoso y juguetón.',
          estado: 'Disponible',
          estadoAprobacion: 'aprobada',
        ),
        Mascota(
          id: '2',
          nombre: 'Bella',
          tipo: 'Gato',
          raza: 'Gato Persa',
          edad: '2 años',
          imagen: 'assets/images/bella.png',
          descripcion: 'Bella es tranquila y elegante.',
          estado: 'En proceso',
          estadoAprobacion: 'aprobada',
        ),
        Mascota(
          id: '3',
          nombre: 'Rocky',
          tipo: 'Perro',
          raza: 'Labrador',
          edad: '5 años',
          imagen: 'assets/images/rocky.png',
          descripcion: 'Rocky es muy activo.',
          estado: 'Adoptado',
          estadoAprobacion: 'aprobada',
        ),
        Mascota(
          id: '4',
          nombre: 'Luna',
          tipo: 'Gato',
          raza: 'Gato Siamés',
          edad: '3 años',
          imagen: 'assets/images/luna.png',
          descripcion: 'Luna es dulce y curiosa.',
          estado: 'Disponible',
          estadoAprobacion: 'aprobada',
        ),
      ];
      _publicaciones.addAll(defaultPublicaciones);
      await _savePublicaciones();
      await prefs.setBool('initialized', true);
      notifyListeners();
    }
  }

  Future<void> _loadPublicaciones() async {
    final prefs = await SharedPreferences.getInstance();
    final publicacionesJson = prefs.getStringList('publicaciones') ?? [];
    _publicaciones.clear();
    for (final json in publicacionesJson) {
      final mascota = Mascota.fromJson(jsonDecode(json));
      _publicaciones.add(mascota);
    }
    notifyListeners();
  }

  Future<void> _savePublicaciones() async {
    final prefs = await SharedPreferences.getInstance();
    final publicacionesJson = _publicaciones.map((m) => jsonEncode(m.toJson())).toList();
    await prefs.setStringList('publicaciones', publicacionesJson);
  }

  //  Getter para acceder a las publicaciones desde otras pantallas
  List<Mascota> get publicaciones => List.unmodifiable(_publicaciones);

  // Método para actualizar una mascota usando su ID único
  void actualizarMascota(Mascota mascotaEditada) {
    final index = _publicaciones.indexWhere((m) => m.id == mascotaEditada.id); //  Cambio: buscar por ID
    if (index != -1) {
      _publicaciones[index] = mascotaEditada; //  Reemplaza la mascota en la lista
      _savePublicaciones();
      notifyListeners(); // Notifica a la UI para que se actualice
    }
  }

  // Método para agregar una nueva publicación (pendiente de aprobación)
  void agregarPublicacion(Mascota nuevaMascota) {
    _publicaciones.add(nuevaMascota);
    _savePublicaciones();
    notifyListeners();
  }

  // Método para aprobar una publicación
  void aprobarPublicacion(String id) {
    final index = _publicaciones.indexWhere((m) => m.id == id);
    if (index != -1) {
      final mascotaAprobada = Mascota(
        id: _publicaciones[index].id,
        nombre: _publicaciones[index].nombre,
        tipo: _publicaciones[index].tipo,
        raza: _publicaciones[index].raza,
        edad: _publicaciones[index].edad,
        imagen: _publicaciones[index].imagen,
        imagenBytes: _publicaciones[index].imagenBytes,
        descripcion: _publicaciones[index].descripcion,
        estado: _publicaciones[index].estado,
        estadoAprobacion: 'aprobada',
      );
      _publicaciones[index] = mascotaAprobada;
      _savePublicaciones();
      notifyListeners();
    }
  }

  // Método para rechazar una publicación
  void rechazarPublicacion(String id) {
    final index = _publicaciones.indexWhere((m) => m.id == id);
    if (index != -1) {
      final mascotaRechazada = Mascota(
        id: _publicaciones[index].id,
        nombre: _publicaciones[index].nombre,
        tipo: _publicaciones[index].tipo,
        raza: _publicaciones[index].raza,
        edad: _publicaciones[index].edad,
        imagen: _publicaciones[index].imagen,
        imagenBytes: _publicaciones[index].imagenBytes,
        descripcion: _publicaciones[index].descripcion,
        estado: _publicaciones[index].estado,
        estadoAprobacion: 'rechazada',
      );
      _publicaciones[index] = mascotaRechazada;
      _savePublicaciones();
      notifyListeners();
    }
  }

  // Getter para publicaciones pendientes
  List<Mascota> get publicacionesPendientes => _publicaciones.where((m) => m.estadoAprobacion == 'pendiente').toList();

  // Getter para publicaciones aprobadas
  List<Mascota> get publicacionesAprobadas => _publicaciones.where((m) => m.estadoAprobacion == 'aprobada').toList();
}

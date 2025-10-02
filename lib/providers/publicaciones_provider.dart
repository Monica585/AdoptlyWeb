import 'package:flutter/material.dart';
import '../modelos/mascota.dart';

class PublicacionesProvider with ChangeNotifier {
  //  Lista simulada de publicaciones del usuario
  final List<Mascota> _publicaciones = [
    Mascota(
      id: '1',
      nombre: 'Max',
      tipo: 'Perro',
      raza: 'Golden Retriever',
      edad: '4 años',
      imagen: 'assets/images/max.png',
      descripcion: 'Max es un perro cariñoso y juguetón.',
      estado: 'Disponible',
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
    ),
  ];

  //  Getter para acceder a las publicaciones desde otras pantallas
  List<Mascota> get publicaciones => List.unmodifiable(_publicaciones);

  // Método para actualizar una mascota usando su ID único
  void actualizarMascota(Mascota mascotaEditada) {
    final index = _publicaciones.indexWhere((m) => m.id == mascotaEditada.id); //  Cambio: buscar por ID
    if (index != -1) {
      _publicaciones[index] = mascotaEditada; //  Reemplaza la mascota en la lista
      notifyListeners(); // Notifica a la UI para que se actualice
    }
  }
}

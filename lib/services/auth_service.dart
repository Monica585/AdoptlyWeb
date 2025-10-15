import 'dart:convert';
import 'package:http/http.dart' as http;
import '../modelos/usuario.dart';

class AuthService {
  static const String baseUrl = 'http://localhost:5000/api/auth';

  // Login de usuario
  static Future<Map<String, dynamic>> login(String correo, String contrasena) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'correo': correo,
          'contrasena': contrasena,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['error'] ?? 'Error en el login');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  // Registro de usuario
  static Future<Map<String, dynamic>> register(String nombre, String correo, String contrasena) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nombre': nombre,
          'correo': correo,
          'contrasena': contrasena,
        }),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['error'] ?? 'Error en el registro');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  // Verificar si es admin (método local por ahora)
  static bool esAdmin(String correo, String contrasena) {
    return correo == 'admin@adoptly.com' && contrasena == 'admin2015';
  }
}
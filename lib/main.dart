import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import 'providers/favoritos_provider.dart';
import 'providers/publicaciones_provider.dart';
import 'providers/solicitudes_provider.dart'; // ✅ NUEVO

// Autenticación
import 'pantallas/autenticacion/pantalla_bienvenida.dart';
import 'pantallas/autenticacion/pantalla_presentacion.dart';
import 'pantallas/autenticacion/pantalla_entrada_autenticacion.dart';
import 'pantallas/autenticacion/pantalla_inicio_sesion.dart';
import 'pantallas/autenticacion/pantalla_registro.dart';
import 'pantallas/autenticacion/pantalla_recuperar_contrasena.dart';

// Usuario
import 'pantallas/usuario/pantalla_inicio.dart';
import 'pantallas/usuario/pantalla_favoritos.dart';
import 'pantallas/usuario/pantalla_perfil.dart';
import 'pantallas/usuario/pantalla_mis_solicitudes.dart';
import 'pantallas/usuario/pantalla_notificaciones.dart';
import 'pantallas/usuario/pantalla_publicar_mascota.dart';
import 'pantallas/usuario/pantalla_mis_publicaciones.dart';
import 'pantallas/usuario/pantalla_menu_usuario.dart';
import 'pantallas/usuario/pantalla_informacion_contacto.dart';

// Administrador
import 'pantallas/administrador/pantalla_panel_admin.dart';
import 'pantallas/administrador/pantalla_solicitudes_admin.dart';
import 'pantallas/administrador/pantalla_estadisticas.dart';
import 'pantallas/administrador/pantalla_publicaciones_pendientes.dart';
import 'pantallas/administrador/pantalla_registro_admin.dart';
import 'pantallas/administrador/pantalla_configuracion_admin.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritosProvider()),
        ChangeNotifierProvider(create: (_) => PublicacionesProvider()),
        ChangeNotifierProvider(create: (_) => SolicitudesProvider()), // ✅ REGISTRADO
      ],
      child: const AdoptlyApp(),
    ),
  );
}

class AdoptlyApp extends StatelessWidget {
  const AdoptlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adoptly',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 76, 172, 175),
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        // Autenticación
        '/': (context) => const PantallaBienvenida(),
        '/presentacion': (context) => const PantallaPresentacion(),
        '/auth': (context) => const PantallaEntradaAutenticacion(),
        '/login': (context) => const PantallaInicioSesion(),
        '/register': (context) => const PantallaRegistro(),
        '/forgotPassword': (context) => const PantallaRecuperarContrasena(),

        // Usuario
        '/home': (context) => const PantallaInicio(),
        '/publicarMascota': (context) => const PantallaPublicarMascota(),
        '/misSolicitudes': (context) => const PantallaMisSolicitudes(),
        '/notificaciones': (context) => const PantallaNotificaciones(),
        '/misPublicaciones': (context) => const PantallaMisPublicaciones(),
        '/menu': (context) => const PantallaMenuUsuario(),
        '/infoContacto': (context) => const PantallaInformacionContacto(),
        '/favoritos': (context) => const PantallaFavoritos(),

        // Administrador
        '/adminPanel': (context) => const PantallaPanelAdmin(),
        '/adminSolicitudes': (context) => const PantallaSolicitudesAdmin(),
        '/adminEstadisticas': (context) => const PantallaEstadisticas(),
        '/adminPendientes': (context) => const PantallaPublicacionesPendientes(),
        '/adminRegistro': (context) => const PantallaRegistroAdmin(),
        '/adminConfiguracion': (context) => const PantallaConfiguracionAdmin(),

        // Ayuda
        '/ayuda': (context) => Scaffold(
              appBar: AppBar(title: const Text('Centro de ayuda')),
              body: const Center(child: Text('Aquí irá el contenido de ayuda')),
            ),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import 'providers/favoritos_provider.dart';
import 'providers/publicaciones_provider.dart';
import 'providers/solicitudes_provider.dart';
import 'providers/usuario_provider.dart';
import 'providers/usuarios_provider.dart';

// Autenticación
import 'pantallas/autenticacion/pantalla_bienvenida.dart';
import 'pantallas/autenticacion/pantalla_presentacion.dart';
import 'pantallas/autenticacion/pantalla_entrada_autenticacion.dart';
import 'pantallas/autenticacion/pantalla_inicio_sesion.dart';
import 'pantallas/autenticacion/pantalla_registro.dart';
import 'pantallas/autenticacion/pantalla_recuperar_contrasena.dart';

// Usuario
import 'pantallas/usuario/perfil/pantalla_cambiar_contrasena.dart';
import 'pantallas/usuario/inicio/pantalla_catalogo_mascotas.dart';
import 'pantallas/usuario/perfil/pantalla_editar_perfil.dart';
import 'pantallas/usuario/favoritos/pantalla_favoritos.dart';
import 'pantallas/usuario/inicio/pantalla_informacion_contacto.dart';
import 'pantallas/usuario/inicio/pantalla_inicio.dart';
import 'pantallas/usuario/inicio/pantalla_menu_usuario.dart';
import 'pantallas/usuario/publicaciones/pantalla_mis_publicaciones.dart';
import 'pantallas/usuario/solicitudes/pantalla_mis_solicitudes.dart';
import 'pantallas/usuario/soporte/pantalla_notificaciones.dart';
import 'pantallas/usuario/perfil/pantalla_perfil.dart';
import 'pantallas/usuario/publicaciones/pantalla_publicar_mascota.dart';

// Administrador
import 'pantallas/administrador/pantalla_estadisticas.dart';
import 'pantallas/administrador/pantalla_panel_admin.dart';
import 'pantallas/administrador/pantalla_publicaciones_pendientes.dart';
import 'pantallas/administrador/pantalla_registro_admin.dart';
import 'pantallas/administrador/pantalla_solicitudes_admin.dart';

// 🔧 Clave global para navegación
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritosProvider()),
        ChangeNotifierProvider(create: (_) => PublicacionesProvider()),
        ChangeNotifierProvider(create: (_) => SolicitudesProvider()),
        ChangeNotifierProvider(create: (_) => UsuarioProvider()),
        ChangeNotifierProvider(create: (_) => UsuariosProvider()),
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
      navigatorKey: navigatorKey,
      initialRoute: '/',
      routes: {
        // Autenticación
        '/': (context) => const PantallaBienvenida(),
        '/auth': (context) => const PantallaEntradaAutenticacion(),
        '/forgotPassword': (context) => const PantallaRecuperarContrasena(),
        '/login': (context) => const PantallaInicioSesion(),
        '/presentacion': (context) => const PantallaPresentacion(),
        '/register': (context) => const PantallaRegistro(),

        // Usuario
        '/buscar': (context) => const PantallaCatalogoMascotas(),
        '/cambiarContrasena': (context) => const PantallaCambiarContrasena(),
        '/editarPerfil': (context) => const PantallaEditarPerfil(),
        '/favoritos': (context) => const PantallaFavoritos(),
        '/home': (context) => const PantallaInicio(),
        '/infoContacto': (context) => const PantallaInformacionContacto(),
        '/menu': (context) => const PantallaMenuUsuario(),
        '/misPublicaciones': (context) => const PantallaMisPublicaciones(),
        '/misSolicitudes': (context) => const PantallaMisSolicitudes(),
        '/notificaciones': (context) => const PantallaNotificaciones(),
        '/perfil': (context) => const PantallaPerfil(),
        '/publicarMascota': (context) => const PantallaPublicarMascota(),

        // Administrador
        '/adminEstadisticas': (context) => const PantallaEstadisticas(),
        '/adminPanel': (context) => const PantallaPanelAdmin(),
        '/adminPendientes': (context) => const PantallaPublicacionesPendientes(),
        '/adminRegistro': (context) => const PantallaRegistroAdmin(),
        '/adminSolicitudes': (context) => const PantallaSolicitudesAdmin(),
      },
    );
  }
}

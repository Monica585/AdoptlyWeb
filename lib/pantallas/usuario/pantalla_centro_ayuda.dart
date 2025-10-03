import 'package:flutter/material.dart';

class PantallaCentroAyuda extends StatelessWidget {
  const PantallaCentroAyuda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Centro de ayuda'),
        backgroundColor: const Color.fromARGB(255, 76, 172, 175),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            '¿En qué podemos ayudarte?',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Sección: Preguntas frecuentes
          ListTile(
            leading: const Icon(Icons.question_answer),
            title: const Text('¿Cómo adoptar una mascota?'),
            subtitle: const Text('Guía paso a paso para enviar una solicitud de adopción.'),
            onTap: () {
              Navigator.pushNamed(context, '/ayudaAdopcion');
            },
          ),
          ListTile(
            leading: const Icon(Icons.pets),
            title: const Text('¿Cómo publicar una mascota?'),
            subtitle: const Text('Instrucciones para dar en adopción desde tu perfil.'),
            onTap: () {
              Navigator.pushNamed(context, '/ayudaPublicar');
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('¿Cómo cambiar mi contraseña?'),
            subtitle: const Text('Pasos para actualizar tu clave de acceso.'),
            onTap: () {
              Navigator.pushNamed(context, '/cambiarContrasena');
            },
          ),

          const Divider(height: 40),

          // Sección: Seguridad
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text('Privacidad y protección de datos'),
            subtitle: const Text('Conoce cómo cuidamos tu información personal.'),
            onTap: () {
              Navigator.pushNamed(context, '/ayudaPrivacidad');
            },
          ),

          // Sección: Contacto
          ListTile(
            leading: const Icon(Icons.contact_support),
            title: const Text('¿Necesitas ayuda personalizada?'),
            subtitle: const Text('Contáctanos por correo o WhatsApp.'),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Contacto'),
                  content: const Text(
                    'Puedes escribirnos a:\n\n📧 soporte@adoptly.com\n📱 WhatsApp: +57 300 123 4567',
                  ),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cerrar')),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

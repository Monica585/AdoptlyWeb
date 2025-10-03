import 'package:flutter/material.dart';

class PantallaInformacionContacto extends StatelessWidget {
  const PantallaInformacionContacto({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información del contacto'),
        backgroundColor: const Color.fromARGB(255, 76, 172, 175),
      ),
      body: Container(
        color: Colors.grey[100], // Fondo suave
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🟢 Título principal
            const Text(
              'Datos del contacto',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            //  WhatsApp
            _infoItem(
              icon: Icons.phone,
              title: 'WhatsApp',
              value: '+57 301 433 1792',
              iconColor: Colors.green,
            ),
            const Divider(),

            //  Correo electrónico
            _infoItem(
              icon: Icons.email_outlined,
              title: 'Correo electrónico',
              value: 'monicagarzon@gmail.com',
              iconColor: Colors.grey,
            ),
            const Divider(),

            //  Ubicación
            _infoItem(
              icon: Icons.location_on,
              title: 'Ubicación',
              value: 'Barrio Santa Barbara',
              iconColor: Colors.redAccent,
            ),
            const Divider(),

            const SizedBox(height: 30),

            //  Botón de contacto
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  
                },
                icon: const Icon(Icons.pets),
                label: const Text('Contacto'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 76, 172, 175),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Widget personalizado para cada dato
  Widget _infoItem({
    required IconData icon,
    required String title,
    required String value,
    required Color iconColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ],
    );
  }
}

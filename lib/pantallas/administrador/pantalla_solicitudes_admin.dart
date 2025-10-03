import 'package:flutter/material.dart';

class PantallaSolicitudesAdmin extends StatelessWidget {
  const PantallaSolicitudesAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulación de solicitudes
    final solicitudes = [
      {
        'usuario': 'Laura Gómez',
        'mascota': 'Luna 🐶',
        'fecha': '2 oct 2025',
        'estado': 'Pendiente',
      },
      {
        'usuario': 'Carlos Ruiz',
        'mascota': 'Milo 🐱',
        'fecha': '1 oct 2025',
        'estado': 'Pendiente',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitudes de adopción'),
        backgroundColor: const Color.fromARGB(255, 76, 172, 175),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: solicitudes.length,
        itemBuilder: (context, index) {
          final solicitud = solicitudes[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 20),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Usuario: ${solicitud['usuario']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('Mascota: ${solicitud['mascota']}'),
                  Text('Fecha: ${solicitud['fecha']}'),
                  Text('Estado: ${solicitud['estado']}'),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          // Aquí iría la lógica para aprobar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Solicitud aprobada para ${solicitud['usuario']}')),
                          );
                        },
                        icon: const Icon(Icons.check),
                        label: const Text('Aprobar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Aquí iría la lógica para rechazar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Solicitud rechazada para ${solicitud['usuario']}')),
                          );
                        },
                        icon: const Icon(Icons.close),
                        label: const Text('Rechazar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

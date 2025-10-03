import 'package:flutter/material.dart';

class PantallaAyuda extends StatelessWidget {
  const PantallaAyuda({super.key});

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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: const [
            Text(
              'Centro de Ayuda',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Preguntas Frecuentes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ExpansionTile(
              title: Text('¿Cómo publicar una mascota?'),
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Para publicar una mascota, ve a la pantalla de inicio, toca el botón "Dar en adopción" y completa el formulario con la información de la mascota.',
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('¿Cómo editar mi perfil?'),
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Ve a tu perfil, toca "Editar perfil" y modifica la información deseada.',
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('¿Cómo contactar soporte?'),
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Envía un correo a soporte@adoptly.com o llama al +57 123 456 7890.',
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Si no encuentras la respuesta a tu pregunta, contáctanos.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class PantallaConfiguracionAdmin extends StatefulWidget {
  const PantallaConfiguracionAdmin({super.key});

  @override
  State<PantallaConfiguracionAdmin> createState() => _PantallaConfiguracionAdminState();
}

class _PantallaConfiguracionAdminState extends State<PantallaConfiguracionAdmin> {
  bool permitirPublicaciones = true;
  bool mostrarMascotasAdoptadas = false;
  String categoriaSeleccionada = 'Perro';

  final List<String> categorias = ['Perro', 'Gato', 'Conejo', 'Ave', 'Otro'];

  void guardarConfiguracion() {
    // Aquí iría la lógica para guardar en Firestore o backend
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Configuración guardada correctamente')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración del sistema'),
        backgroundColor: const Color.fromARGB(255, 76, 172, 175),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Opciones generales', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),

            SwitchListTile(
              title: const Text('Permitir nuevas publicaciones'),
              value: permitirPublicaciones,
              onChanged: (value) => setState(() => permitirPublicaciones = value),
            ),
            SwitchListTile(
              title: const Text('Mostrar mascotas ya adoptadas'),
              value: mostrarMascotasAdoptadas,
              onChanged: (value) => setState(() => mostrarMascotasAdoptadas = value),
            ),

            const SizedBox(height: 30),
            const Text('Categoría por defecto', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: categoriaSeleccionada,
              items: categorias.map((cat) {
                return DropdownMenuItem(value: cat, child: Text(cat));
              }).toList(),
              onChanged: (value) => setState(() => categoriaSeleccionada = value!),
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),

            const SizedBox(height: 40),
            Center(
              child: ElevatedButton.icon(
                onPressed: guardarConfiguracion,
                icon: const Icon(Icons.save),
                label: const Text('Guardar cambios'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 76, 172, 175),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

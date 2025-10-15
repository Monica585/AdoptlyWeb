import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../modelos/mascota.dart';
import '../../../modelos/solicitudAdopcion.dart';
import '../../../providers/solicitudes_provider.dart';

class PantallaSolicitarAdopcion extends StatefulWidget {
  final Mascota mascota;

  const PantallaSolicitarAdopcion({super.key, required this.mascota});

  @override
  State<PantallaSolicitarAdopcion> createState() => _PantallaSolicitarAdopcionState();
}

class _PantallaSolicitarAdopcionState extends State<PantallaSolicitarAdopcion> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _motivoController = TextEditingController();

  void _enviarSolicitud() {
    if (_formKey.currentState!.validate()) {
      try {
        final solicitudesProvider = Provider.of<SolicitudesProvider>(context, listen: false);
        final solicitud = SolicitudAdopcion(
          id: 's${DateTime.now().millisecondsSinceEpoch}',
          mascota: widget.mascota,
          estado: EstadoSolicitud.pendiente,
          fecha: DateTime.now(),
        );
        solicitudesProvider.agregarSolicitud(solicitud);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Solicitud enviada para ${widget.mascota.nombre}')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString().replaceFirst('Exception: ', ''))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitar adopción'),
        backgroundColor: const Color.fromARGB(255, 76, 172, 175),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Solicitando adopción de ${widget.mascota.nombre}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text('Motivo de adopción'),
              TextFormField(
                controller: _motivoController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Describe por qué quieres adoptar esta mascota...',
                  border: OutlineInputBorder(),
                  errorStyle: TextStyle(color: Colors.red),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _enviarSolicitud,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 76, 172, 175),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Enviar solicitud', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//  vista de lista con foto de mascota, datos básicos y modal de detalles completos
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/solicitudes_provider.dart';
import '../../providers/usuario_provider.dart';
import '../../modelos/solicitudAdopcion.dart';

class PantallaSolicitudesAdmin extends StatelessWidget {
  const PantallaSolicitudesAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final solicitudesProvider = Provider.of<SolicitudesProvider>(context);
    // final usuariosProvider = Provider.of<UsuariosProvider>(context);
    final usuarioActual = Provider.of<UsuarioProvider>(context).usuario;

    // Filtrar solo solicitudes pendientes
    final solicitudesPendientes = solicitudesProvider.solicitudes
        .where((s) => s.estado == EstadoSolicitud.pendiente)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitudes de adopción'),
        backgroundColor: const Color.fromARGB(255, 76, 172, 175),
      ),
      body: solicitudesPendientes.isEmpty
          ? const Center(child: Text('No hay solicitudes pendientes'))
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: solicitudesPendientes.length,
              itemBuilder: (context, index) {
                final solicitud = solicitudesPendientes[index];

                // foto, datos básicos y botones de acción
                return Card(
                  margin: const EdgeInsets.only(bottom: 20),
                  elevation: 3,
                  child: InkWell(
                    onTap: () => _mostrarDetalleSolicitud(
                      context,
                      solicitud,
                      usuarioActual, // Usar el usuario actual como solicitante 
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Fila superior: foto, nombre, tipo/raza, solicitante, fecha y botón detalles
                          Row(
                            children: [
                              // Foto circular de la mascota solicitada
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: solicitud.mascota.imagen.startsWith('assets/')
                                    ? AssetImage(solicitud.mascota.imagen)
                                    : solicitud.mascota.imagenBytes != null
                                        ? MemoryImage(solicitud.mascota.imagenBytes!)
                                        : const AssetImage('assets/images/perrito_gatito_inicio.png'),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Nombre de la mascota
                                    Text(
                                      solicitud.mascota.nombre,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // Tipo y raza de la mascota
                                    Text(
                                      '${solicitud.mascota.tipo} - ${solicitud.mascota.raza}',
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    // Nombre del solicitante
                                    Text(
                                      'Solicitante: ${usuarioActual.nombre}',
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    // Fecha de la solicitud
                                    Text(
                                      'Fecha: ${_formatearFecha(solicitud.fecha)}',
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ),
                              // Botón para ver detalles completos
                              IconButton(
                                icon: const Icon(Icons.visibility),
                                onPressed: () => _mostrarDetalleSolicitud(
                                  context,
                                  solicitud,
                                  usuarioActual,
                                ),
                                tooltip: 'Ver detalles completos',
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // Botones de aprobar/rechazar la solicitud
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    solicitudesProvider.aprobarSolicitud(solicitud.mascota.id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Solicitud aprobada para ${solicitud.mascota.nombre}')),
                                    );
                                  },
                                  icon: const Icon(Icons.check_circle),
                                  label: const Text('Aprobar'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    solicitudesProvider.rechazarSolicitud(solicitud.mascota.id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Solicitud rechazada para ${solicitud.mascota.nombre}')),
                                    );
                                  },
                                  icon: const Icon(Icons.cancel),
                                  label: const Text('Rechazar'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  // Función helper para formatear fechas en formato dd/mm/yyyy
  String _formatearFecha(DateTime fecha) {
    return '${fecha.day}/${fecha.month}/${fecha.year}';
  }

  // Modal que muestra todos los detalles de la solicitud de adopción
  // Incluye foto grande, información completa de mascota y solicitante
  void _mostrarDetalleSolicitud(BuildContext context, SolicitudAdopcion solicitud, dynamic usuarioSolicitante) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header del modal con título y botón cerrar
                  Row(
                    children: [
                      const Text(
                        'Detalles de la Solicitud',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 16),

                  // Foto grande de la mascota en el centro
                  Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: solicitud.mascota.imagen.startsWith('assets/')
                          ? AssetImage(solicitud.mascota.imagen)
                          : solicitud.mascota.imagenBytes != null
                              ? MemoryImage(solicitud.mascota.imagenBytes!)
                              : const AssetImage('assets/images/perrito_gatito_inicio.png'),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Sección: Información básica de la mascota
                  _buildInfoSection('Información de la Mascota', [
                    _buildInfoRow('Nombre', solicitud.mascota.nombre),
                    _buildInfoRow('Tipo', solicitud.mascota.tipo),
                    _buildInfoRow('Raza', solicitud.mascota.raza),
                    _buildInfoRow('Edad', solicitud.mascota.edad),
                    _buildInfoRow('Estado', solicitud.mascota.estado),
                  ]),

                  const SizedBox(height: 16),

                  // Sección: Descripción completa de la mascota
                  _buildInfoSection('Descripción', [
                    Text(
                      solicitud.mascota.descripcion,
                      style: const TextStyle(fontSize: 14, height: 1.5),
                    ),
                  ]),

                  const SizedBox(height: 16),

                  // Sección: Información del usuario que solicita la adopción
                  if (usuarioSolicitante != null)
                    _buildInfoSection('Información del Solicitante', [
                      _buildInfoRow('Nombre', usuarioSolicitante.nombre),
                      _buildInfoRow('Correo', usuarioSolicitante.correo),
                      if (usuarioSolicitante.telefono != null)
                        _buildInfoRow('Teléfono', usuarioSolicitante.telefono!),
                      if (usuarioSolicitante.ubicacion != null)
                        _buildInfoRow('Ubicación', usuarioSolicitante.ubicacion!),
                    ]),

                  const SizedBox(height: 16),

                  // Sección: Detalles específicos de la solicitud
                  _buildInfoSection('Información de la Solicitud', [
                    _buildInfoRow('Fecha', _formatearFecha(solicitud.fecha)),
                    _buildInfoRow('Estado', _estadoToString(solicitud.estado)),
                  ]),

                  const SizedBox(height: 24),

                  // Botones finales para aprobar o rechazar la solicitud
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Provider.of<SolicitudesProvider>(context, listen: false)
                                .aprobarSolicitud(solicitud.id);
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Solicitud aprobada para ${solicitud.mascota.nombre}')),
                            );
                          },
                          icon: const Icon(Icons.check_circle),
                          label: const Text('Aprobar'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Provider.of<SolicitudesProvider>(context, listen: false)
                                .rechazarSolicitud(solicitud.id);
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Solicitud rechazada para ${solicitud.mascota.nombre}')),
                            );
                          },
                          icon: const Icon(Icons.cancel),
                          label: const Text('Rechazar'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Widget helper para crear secciones de información con título y contenido
  Widget _buildInfoSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título de la sección con color 
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 76, 172, 175),
          ),
        ),
        const SizedBox(height: 8),
        // Contenedor con fondo gris claro para el contenido
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ],
    );
  }

  // Widget helper para crear filas de información (etiqueta: valor)
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Etiqueta con ancho fijo para alineación
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          // Valor que se expande si es necesario
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  // Función helper para convertir enum de estado a string legible
  String _estadoToString(EstadoSolicitud estado) {
    switch (estado) {
      case EstadoSolicitud.pendiente:
        return 'Pendiente';
      case EstadoSolicitud.aprobada:
        return 'Aprobada';
      case EstadoSolicitud.rechazada:
        return 'Rechazada';
    }
  }
}
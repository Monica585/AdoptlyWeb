// Pantalla mejorada para que el administrador revise publicaciones pendientes
// Incluye vista de lista con foto, datos básicos y modal de detalles completos
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/publicaciones_provider.dart';
import '../../providers/usuario_provider.dart';

class PantallaPublicacionesPendientes extends StatelessWidget {
  const PantallaPublicacionesPendientes({super.key});

  @override
  Widget build(BuildContext context) {
    final publicacionesProvider = Provider.of<PublicacionesProvider>(context);
    final publicacionesPendientes = publicacionesProvider.publicacionesPendientes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Publicaciones pendientes'),
        backgroundColor: const Color.fromARGB(255, 76, 172, 175),
      ),
      body: publicacionesPendientes.isEmpty
          ? const Center(child: Text('No hay publicaciones pendientes'))
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: publicacionesPendientes.length,
              itemBuilder: (context, index) {
                final pub = publicacionesPendientes[index];
                // Card mejorada con foto, datos básicos y botones de acción
                return Card(
                  margin: const EdgeInsets.only(bottom: 20),
                  elevation: 3,
                  child: InkWell(
                    onTap: () => _mostrarDetallePublicacion(context, pub), // Modal de detalles
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Fila superior: foto, nombre, tipo/raza, edad y botón de detalles
                          Row(
                            children: [
                              // Foto circular de la mascota
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: pub.imagen.startsWith('assets/')
                                    ? AssetImage(pub.imagen)
                                    : pub.imagenBytes != null
                                        ? MemoryImage(pub.imagenBytes!)
                                        : const AssetImage('assets/images/perrito_gatito_inicio.png'),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Nombre de la mascota
                                    Text(
                                      pub.nombre,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // Tipo y raza
                                    Text(
                                      '${pub.tipo} - ${pub.raza}',
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    // Edad
                                    Text(
                                      'Edad: ${pub.edad}',
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ),
                              // Botón para ver detalles completos
                              IconButton(
                                icon: const Icon(Icons.visibility),
                                onPressed: () => _mostrarDetallePublicacion(context, pub),
                                tooltip: 'Ver detalles completos',
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // Descripción corta (máximo 2 líneas)
                          Text(
                            pub.descripcion,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          const SizedBox(height: 16),
                          // Botones de aprobar/rechazar
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    publicacionesProvider.aprobarPublicacion(pub.id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Mascota aprobada: ${pub.nombre}')),
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
                                    publicacionesProvider.rechazarPublicacion(pub.id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Mascota rechazada: ${pub.nombre}')),
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

  // Modal que muestra todos los detalles de la publicación pendiente
  // Incluye foto grande, información completa de la mascota y datos de contacto
  void _mostrarDetallePublicacion(BuildContext context, dynamic pub) {
    final usuarioProvider = Provider.of<UsuarioProvider>(context, listen: false);

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
                        'Detalles de la Publicación',
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
                      backgroundImage: pub.imagen.startsWith('assets/')
                          ? AssetImage(pub.imagen)
                          : pub.imagenBytes != null
                              ? MemoryImage(pub.imagenBytes!)
                              : const AssetImage('assets/images/perrito_gatito_inicio.png'),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Sección: Información básica de la mascota
                  _buildInfoSection('Información de la Mascota', [
                    _buildInfoRow('Nombre', pub.nombre),
                    _buildInfoRow('Tipo', pub.tipo),
                    _buildInfoRow('Raza', pub.raza),
                    _buildInfoRow('Edad', pub.edad),
                    _buildInfoRow('Estado', pub.estado),
                  ]),

                  const SizedBox(height: 16),

                  // Sección: Descripción completa de la mascota
                  _buildInfoSection('Descripción', [
                    Text(
                      pub.descripcion,
                      style: const TextStyle(fontSize: 14, height: 1.5),
                    ),
                  ]),

                  const SizedBox(height: 16),

                  // Sección: Información de contacto del usuario que publicó
                  _buildInfoSection('Información de Contacto', [
                    _buildInfoRow('Nombre', usuarioProvider.usuario.nombre),
                    _buildInfoRow('Correo', usuarioProvider.usuario.correo),
                    if (usuarioProvider.usuario.telefono != null)
                      _buildInfoRow('Teléfono', usuarioProvider.usuario.telefono!),
                    if (usuarioProvider.usuario.ubicacion != null)
                      _buildInfoRow('Ubicación', usuarioProvider.usuario.ubicacion!),
                  ]),

                  const SizedBox(height: 24),

                  // Botones finales para aprobar o rechazar la publicación
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Provider.of<PublicacionesProvider>(context, listen: false)
                                .aprobarPublicacion(pub.id);
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Mascota aprobada: ${pub.nombre}')),
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
                            Provider.of<PublicacionesProvider>(context, listen: false)
                                .rechazarPublicacion(pub.id);
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Mascota rechazada: ${pub.nombre}')),
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
        // Título de la sección con color temático
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
}

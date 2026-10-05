import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../nucleo/utilidades/dialogos_seguros.dart';
import '../datos/repositorio_equipos.dart';
import '../dominio/equipo_app.dart';

class PaginaListaEquipos extends StatefulWidget {
  final String clienteId;

  const PaginaListaEquipos({
    super.key,
    required this.clienteId,
  });

  @override
  State<PaginaListaEquipos> createState() => _PaginaListaEquiposState();
}

class _PaginaListaEquiposState extends State<PaginaListaEquipos> {
  final _repoEquipos = RepositorioEquipos();
  bool _cargando = false;
  List<EquipoApp> _equipos = [];

  @override
  void initState() {
    super.initState();
    _cargarEquipos();
  }

  Future<void> _cargarEquipos() async {
    setState(() => _cargando = true);
    try {
      final lista = await _repoEquipos.obtenerEquiposPorCliente(widget.clienteId);
      if (mounted) {
        setState(() {
          _equipos = lista;
          _cargando = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _cargando = false);
    }
  }

  IconData _obtenerIconoTipo(String tipo) {
    switch (tipo.toLowerCase()) {
      case 'laptop':
        return Icons.laptop_mac;
      case 'pc de escritorio':
        return Icons.desktop_windows;
      case 'consola de videojuegos':
        return Icons.sports_esports;
      case 'router / redes':
        return Icons.router;
      case 'cámara de seguridad':
        return Icons.videocam;
      default:
        return Icons.devices_other;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Equipos Registrados — MIRASTEC'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/cliente'),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final guardo = await context.push('/cliente/equipos/nuevo');
          if (guardo == true) _cargarEquipos();
        },
        backgroundColor: const Color(0xFF0D47A1),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Registrar Equipo'),
      ),
      body: _cargando
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Mis Dispositivos & Hardware',
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0D47A1)),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Lista de equipos asociados para solicitar mantenimiento o reparación',
                                style: TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                            ],
                          ),
                          const Spacer(),
                          ElevatedButton.icon(
                            onPressed: () async {
                              final guardo = await context.push('/cliente/equipos/nuevo');
                              if (guardo == true) _cargarEquipos();
                            },
                            icon: const Icon(Icons.add),
                            label: const Text('Nuevo Equipo'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      if (_equipos.isEmpty) ...[
                        Card(
                          elevation: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: Center(
                              child: Column(
                                children: [
                                  const Icon(Icons.devices_other_outlined, size: 64, color: Colors.grey),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'Aún no tenés equipos registrados',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Agregá tu laptop, PC o consola para crear solicitudes de soporte de forma rápida.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  const SizedBox(height: 24),
                                  ElevatedButton.icon(
                                    onPressed: () async {
                                      final guardo = await context.push('/cliente/equipos/nuevo');
                                      if (guardo == true) _cargarEquipos();
                                    },
                                    icon: const Icon(Icons.add),
                                    label: const Text('Registrar mi primer equipo'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ] else ...[
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _equipos.length,
                          itemBuilder: (context, index) {
                            final e = _equipos[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 16),
                              elevation: 2,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(16),
                                leading: CircleAvatar(
                                  radius: 28,
                                  backgroundColor: const Color(0xFF0D47A1).withValues(alpha: 0.1),
                                  child: Icon(_obtenerIconoTipo(e.tipoEquipo), color: const Color(0xFF0D47A1), size: 28),
                                ),
                                title: Text(
                                  '${e.marca} ${e.modelo} (${e.tipoEquipo})',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 4),
                                    if (e.numeroSerie != null && e.numeroSerie!.isNotEmpty)
                                      Text('S/N: ${e.numeroSerie}', style: const TextStyle(fontWeight: FontWeight.w500)),
                                    Text(e.descripcion, maxLines: 2, overflow: TextOverflow.ellipsis),
                                    const SizedBox(height: 4),
                                    Chip(
                                      label: Text(
                                        e.id,
                                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.blue),
                                      ),
                                      backgroundColor: Colors.blue.shade50,
                                      visualDensity: VisualDensity.compact,
                                    ),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit_outlined, color: Colors.blue),
                                      tooltip: 'Editar equipo',
                                      onPressed: () async {
                                        final actualizo = await context.push('/cliente/equipos/nuevo', extra: e);
                                        if (actualizo == true) _cargarEquipos();
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.block, color: Colors.red),
                                      tooltip: 'Desactivar',
                                      onPressed: () async {
                                        final confirma = await DialogosSeguros.mostrarConfirmacion(
                                          context: context,
                                          titulo: '¿Desactivar equipo?',
                                          mensaje: 'El equipo ${e.marca} ${e.modelo} quedará inactivo.',
                                          esPeligroso: true,
                                        );
                                        if (confirma) {
                                          await _repoEquipos.cambiarEstadoEquipo(e.id, EstadoEquipo.inactivo);
                                          _cargarEquipos();
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

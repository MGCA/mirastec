import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../nucleo/utilidades/dialogos_seguros.dart';
import '../../servicios/datos/repositorio_servicios.dart';
import '../../servicios/dominio/servicio_app.dart';
import '../../servicios/utilidades/mapeador_iconos.dart';

class PaginaGestionServiciosAdmin extends StatefulWidget {
  const PaginaGestionServiciosAdmin({super.key});

  @override
  State<PaginaGestionServiciosAdmin> createState() => _PaginaGestionServiciosAdminState();
}

class _PaginaGestionServiciosAdminState extends State<PaginaGestionServiciosAdmin> {
  final _repoServicios = RepositorioServicios();
  List<ServicioApp> _servicios = [];
  bool _cargando = true;

  @override
  void initState() {
    super.initState();
    _cargarServicios();
  }

  Future<void> _cargarServicios() async {
    setState(() => _cargando = true);
    try {
      final lista = await _repoServicios.obtenerServiciosActivos();
      if (mounted) {
        setState(() {
          _servicios = lista;
          _cargando = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _cargando = false);
    }
  }

  void _abrirFormularioServicio([ServicioApp? servicioEditar]) {
    final tituloController = TextEditingController(text: servicioEditar?.titulo ?? '');
    final descController = TextEditingController(text: servicioEditar?.descripcion ?? '');
    final precioController = TextEditingController(text: servicioEditar?.precioBase != null ? servicioEditar!.precioBase.toString() : '');
    String iconoSeleccionado = servicioEditar?.iconoNombre ?? 'computer';
    bool destacado = servicioEditar?.destacado ?? false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(servicioEditar != null ? 'Editar Servicio' : 'Nuevo Servicio Comercial'),
              content: SizedBox(
                width: 500,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: tituloController,
                        decoration: const InputDecoration(labelText: 'Título del Servicio', border: OutlineInputBorder()),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: descController,
                        maxLines: 3,
                        decoration: const InputDecoration(labelText: 'Descripción del Servicio', border: OutlineInputBorder()),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: precioController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'Precio Base Estimado (Opcional)', prefixText: '₡ ', border: OutlineInputBorder()),
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        // ignore: deprecated_member_use
                        value: iconoSeleccionado,
                        decoration: const InputDecoration(labelText: 'Icono Representativo', border: OutlineInputBorder()),
                        items: MapeadorIconos.diccionarioIconos.entries.map((e) {
                          return DropdownMenuItem(value: e.key, child: Text(e.value));
                        }).toList(),
                        onChanged: (v) {
                          if (v != null) setDialogState(() => iconoSeleccionado = v);
                        },
                      ),
                      const SizedBox(height: 12),
                      SwitchListTile(
                        title: const Text('Destacar en la Pantalla de Inicio (Home)'),
                        value: destacado,
                        onChanged: (v) => setDialogState(() => destacado = v),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    if (tituloController.text.trim().isEmpty) return;

                    final precio = double.tryParse(precioController.text.trim());
                    final nuevoServicio = ServicioApp(
                      id: servicioEditar?.id ?? '',
                      categoriaId: servicioEditar?.categoriaId ?? 'cat-general',
                      titulo: tituloController.text.trim(),
                      descripcion: descController.text.trim(),
                      iconoNombre: iconoSeleccionado,
                      precioBase: precio,
                      destacado: destacado,
                      activo: true,
                    );

                    await _repoServicios.guardarServicio(nuevoServicio);
                    if (context.mounted) Navigator.pop(dialogContext);
                    _cargarServicios();
                  },
                  icon: const Icon(Icons.save),
                  label: const Text('Guardar Servicio'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión del Catálogo de Servicios — Admin'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/admin'),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _abrirFormularioServicio(),
        backgroundColor: const Color(0xFF0D47A1),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Agregar Nuevo Servicio'),
      ),
      body: _cargando
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 950),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Catálogo Comercial de Servicios',
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0D47A1)),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Los servicios creados aquí se mostrarán de forma dinámica a todos los visitantes y clientes.',
                                style: TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                            ],
                          ),
                          const Spacer(),
                          ElevatedButton.icon(
                            onPressed: () => _abrirFormularioServicio(),
                            icon: const Icon(Icons.add),
                            label: const Text('Nuevo Servicio'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _servicios.length,
                        itemBuilder: (context, index) {
                          final s = _servicios[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                                child: Icon(MapeadorIconos.obtenerIcono(s.iconoNombre), color: Theme.of(context).colorScheme.primary),
                              ),
                              title: Text(s.titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(s.descripcion),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      if (s.destacado)
                                        Chip(
                                          label: const Text('Destacado en Home', style: TextStyle(fontSize: 10, color: Colors.purple)),
                                          backgroundColor: Colors.purple.shade50,
                                          visualDensity: VisualDensity.compact,
                                        ),
                                      if (s.precioBase != null) ...[
                                        const SizedBox(width: 8),
                                        Chip(
                                          label: Text('₡ ${s.precioBase!.toStringAsFixed(0)}', style: const TextStyle(fontSize: 10, color: Colors.green)),
                                          backgroundColor: Colors.green.shade50,
                                          visualDensity: VisualDensity.compact,
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit_outlined, color: Colors.blue),
                                    onPressed: () => _abrirFormularioServicio(s),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                                    onPressed: () async {
                                      final confirma = await DialogosSeguros.mostrarConfirmacion(
                                        context: context,
                                        titulo: '¿Eliminar servicio?',
                                        mensaje: 'El servicio ${s.titulo} se desactivará del catálogo público.',
                                        esPeligroso: true,
                                      );
                                      if (confirma) {
                                        await _repoServicios.cambiarEstadoServicio(s.id, false);
                                        _cargarServicios();
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
                  ),
                ),
              ),
            ),
    );
  }
}

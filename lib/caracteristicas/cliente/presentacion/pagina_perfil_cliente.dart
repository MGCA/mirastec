import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../nucleo/utilidades/dialogos_seguros.dart';
import '../datos/repositorio_clientes.dart';
import '../dominio/cliente_app.dart';

class PaginaPerfilCliente extends StatefulWidget {
  final String clienteId;

  const PaginaPerfilCliente({
    super.key,
    required this.clienteId,
  });

  @override
  State<PaginaPerfilCliente> createState() => _PaginaPerfilClienteState();
}

class _PaginaPerfilClienteState extends State<PaginaPerfilCliente> {
  final _formKey = GlobalKey<FormState>();
  final _telefonoController = TextEditingController();
  final _direccionController = TextEditingController();
  final _repoClientes = RepositorioClientes();

  String _zonaSeleccionada = 'Aguas Claras';
  bool _cargando = false;
  ClienteApp? _clienteActual;

  final List<String> _zonasDisponibles = [
    'Aguas Claras',
    'Upala',
    'Guayabo',
    'Bagaces',
    'Liberia',
    'La Fortuna',
    'Otra zona cercana',
  ];

  @override
  void initState() {
    super.initState();
    _cargarCliente();
  }

  @override
  void dispose() {
    _telefonoController.dispose();
    _direccionController.dispose();
    super.dispose();
  }

  Future<void> _cargarCliente() async {
    setState(() => _cargando = true);
    try {
      final c = await _repoClientes.obtenerClientePorId(widget.clienteId);
      if (mounted) {
        setState(() {
          _clienteActual = c;
          if (c != null) {
            _telefonoController.text = c.telefono;
            _direccionController.text = c.direccionReferencia ?? '';
            _zonaSeleccionada = c.zona;
          }
          _cargando = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _cargando = false);
    }
  }

  Future<void> _guardarCambios() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _cargando = true);

    try {
      await _repoClientes.actualizarDireccionYZona(
        id: widget.clienteId,
        zona: _zonaSeleccionada,
        direccionReferencia: _direccionController.text,
        telefono: _telefonoController.text,
      );

      if (!mounted) return;
      setState(() => _cargando = false);

      DialogosSeguros.mostrarInformacion(
        context: context,
        titulo: 'Perfil actualizado',
        mensaje: 'Tus datos de dirección y contacto se han actualizado correctamente.',
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _cargando = false);
      DialogosSeguros.mostrarInformacion(
        context: context,
        titulo: 'Error',
        mensaje: 'No se pudieron actualizar los datos.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil de Cliente — MIRASTEC'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/cliente'),
        ),
      ),
      body: _cargando
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 550),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  radius: 32,
                                  backgroundColor: Color(0xFF0D47A1),
                                  child: Icon(Icons.person, size: 36, color: Colors.white),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _clienteActual != null
                                            ? '${_clienteActual!.nombre} ${_clienteActual!.apellidos}'
                                            : 'Perfil del Cliente',
                                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        _clienteActual?.correo ?? 'Cliente autenticado',
                                        style: const TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 36),
                            const Text(
                              'Información de Contacto & Ubicación',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0D47A1)),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _telefonoController,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                labelText: 'Teléfono principal',
                                prefixIcon: Icon(Icons.phone),
                                border: OutlineInputBorder(),
                              ),
                              validator: (v) => v == null || v.trim().isEmpty ? 'Ingresá tu teléfono' : null,
                            ),
                            const SizedBox(height: 16),
                            DropdownButtonFormField<String>(
                              // ignore: deprecated_member_use
                              value: _zonaSeleccionada,
                              decoration: const InputDecoration(
                                labelText: 'Zona de Cobertura / Residencia',
                                prefixIcon: Icon(Icons.map_outlined),
                                border: OutlineInputBorder(),
                              ),
                              items: _zonasDisponibles.map((z) {
                                return DropdownMenuItem(value: z, child: Text(z));
                              }).toList(),
                              onChanged: (v) {
                                if (v != null) setState(() => _zonaSeleccionada = v);
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _direccionController,
                              maxLines: 3,
                              decoration: const InputDecoration(
                                labelText: 'Dirección o Señas de Referencia',
                                hintText: 'Ej. Frente a la plaza de deportes, casa color blanco...',
                                prefixIcon: Icon(Icons.home_work_outlined),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 28),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: _guardarCambios,
                                icon: const Icon(Icons.save_outlined),
                                label: const Text('Guardar Cambios'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

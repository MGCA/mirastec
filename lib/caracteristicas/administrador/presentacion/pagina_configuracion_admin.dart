import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../nucleo/configuracion/configuracion_app.dart';
import '../../../nucleo/configuracion/repositorio_configuracion.dart';
import '../../../nucleo/utilidades/dialogos_seguros.dart';

class PaginaConfiguracionAdmin extends StatefulWidget {
  const PaginaConfiguracionAdmin({super.key});

  @override
  State<PaginaConfiguracionAdmin> createState() => _PaginaConfiguracionAdminState();
}

class _PaginaConfiguracionAdminState extends State<PaginaConfiguracionAdmin> {
  final _formKey = GlobalKey<FormState>();
  final _nombreAppController = TextEditingController();
  final _nombreEmpresaController = TextEditingController();
  final _esloganController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _correoController = TextEditingController();
  final _direccionController = TextEditingController();

  final _repoConfig = RepositorioConfiguracion();
  TemaTemporada _temaSeleccionado = TemaTemporada.estandar;
  bool _permitirRegistro = true;
  bool _guardando = false;

  @override
  void initState() {
    super.initState();
    _cargarValoresIniciales();
  }

  void _cargarValoresIniciales() {
    const config = ConfiguracionApp();
    _nombreAppController.text = config.nombreApp;
    _nombreEmpresaController.text = config.nombreCompletoEmpresa;
    _esloganController.text = config.eslogan;
    _telefonoController.text = config.telefonoContacto;
    _correoController.text = config.correoContacto;
    _direccionController.text = config.direccion;
    _temaSeleccionado = config.temaActual;
    _permitirRegistro = config.permitirRegistroClientes;
  }

  @override
  void dispose() {
    _nombreAppController.dispose();
    _nombreEmpresaController.dispose();
    _esloganController.dispose();
    _telefonoController.dispose();
    _correoController.dispose();
    _direccionController.dispose();
    super.dispose();
  }

  Future<void> _guardarConfiguracion() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _guardando = true);

    try {
      final nuevaConfig = ConfiguracionApp(
        nombreApp: _nombreAppController.text.trim(),
        nombreCompletoEmpresa: _nombreEmpresaController.text.trim(),
        eslogan: _esloganController.text.trim(),
        telefonoContacto: _telefonoController.text.trim(),
        correoContacto: _correoController.text.trim(),
        direccion: _direccionController.text.trim(),
        temaActual: _temaSeleccionado,
        permitirRegistroClientes: _permitirRegistro,
      );

      await _repoConfig.guardarConfiguracion(nuevaConfig);

      if (!mounted) return;
      setState(() => _guardando = false);

      DialogosSeguros.mostrarInformacion(
        context: context,
        titulo: 'Configuración Guardada',
        mensaje: 'La información del sistema, pie de página y apariencia temática se han actualizado globalmente en la plataforma.',
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _guardando = false);
      DialogosSeguros.mostrarInformacion(
        context: context,
        titulo: 'Error',
        mensaje: 'No se pudo guardar la configuración.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración General de la Plataforma — Admin'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/admin'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Personalización de Información & Apariencia',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0D47A1)),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Los cambios guardados aquí se reflejarán instantáneamente en el encabezado, pie de página y temas de la web.',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 24),

                  // Tarjeta 1: Información Comercial
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.business_outlined, color: Color(0xFF0D47A1)),
                              SizedBox(width: 8),
                              Text('Información Comercial del Negocio', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const Divider(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _nombreAppController,
                                  decoration: const InputDecoration(
                                    labelText: 'Nombre Comercial (Abreviado)',
                                    hintText: 'Ej. MIRASTEC',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (v) => v == null || v.trim().isEmpty ? 'Requerido' : null,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: TextFormField(
                                  controller: _nombreEmpresaController,
                                  decoration: const InputDecoration(
                                    labelText: 'Nombre Completo / Razón Social',
                                    hintText: 'Ej. Miravalles Asesoramiento Tecnológico',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (v) => v == null || v.trim().isEmpty ? 'Requerido' : null,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _esloganController,
                            decoration: const InputDecoration(
                              labelText: 'Eslogan de la Empresa',
                              hintText: 'Ej. Soluciones tecnológicas profesionales a tu alcance',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _telefonoController,
                                  decoration: const InputDecoration(
                                    labelText: 'Teléfono / WhatsApp de Contacto',
                                    prefixIcon: Icon(Icons.phone),
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (v) => v == null || v.trim().isEmpty ? 'Requerido' : null,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: TextFormField(
                                  controller: _correoController,
                                  decoration: const InputDecoration(
                                    labelText: 'Correo Electrónico Oficial',
                                    prefixIcon: Icon(Icons.email_outlined),
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (v) => v == null || v.trim().isEmpty ? 'Requerido' : null,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _direccionController,
                            decoration: const InputDecoration(
                              labelText: 'Dirección Base / Zonas de Cobertura',
                              prefixIcon: Icon(Icons.location_on_outlined),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Tarjeta 2: Apariencia Temática & Temporadas
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.palette_outlined, color: Colors.purple),
                              SizedBox(width: 8),
                              Text('Modo Temático & Temporadas', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const Divider(height: 24),
                          DropdownButtonFormField<TemaTemporada>(
                            // ignore: deprecated_member_use
                            value: _temaSeleccionado,
                            decoration: const InputDecoration(
                              labelText: 'Tema de Temporada Activo',
                              border: OutlineInputBorder(),
                            ),
                            items: const [
                              DropdownMenuItem(value: TemaTemporada.estandar, child: Text('🎨 Estándar / Corporativo (Azul y Verde)')),
                              DropdownMenuItem(value: TemaTemporada.navidad, child: Text('🎄 Navidad (Rojo, Verde Pino y Dorado)')),
                              DropdownMenuItem(value: TemaTemporada.diaDeLaMadre, child: Text('🌸 Día de la Madre (Pasteles Cálidos)')),
                              DropdownMenuItem(value: TemaTemporada.halloween, child: Text('🎃 Halloween (Naranja Calabaza y Púrpura)')),
                              DropdownMenuItem(value: TemaTemporada.blackFriday, child: Text('🏷️ Black Friday (Oscuro Elegante con Dorado)')),
                            ],
                            onChanged: (v) {
                              if (v != null) setState(() => _temaSeleccionado = v);
                            },
                          ),
                          const SizedBox(height: 16),
                          SwitchListTile(
                            title: const Text('Permitir Registro Público de Nuevos Clientes'),
                            subtitle: const Text('Si se desactiva, solo el administrador podrá registrar clientes'),
                            value: _permitirRegistro,
                            onChanged: (v) => setState(() => _permitirRegistro = v),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: _guardando ? null : _guardarConfiguracion,
                      icon: _guardando
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                          : const Icon(Icons.save_rounded),
                      label: Text(_guardando ? 'Guardando...' : 'Guardar Configuración Global'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

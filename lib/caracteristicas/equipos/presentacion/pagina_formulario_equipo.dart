import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../nucleo/servicios/servicio_almacenamiento.dart';
import '../../../nucleo/utilidades/dialogos_seguros.dart';
import '../datos/repositorio_equipos.dart';
import '../dominio/equipo_app.dart';

class PaginaFormularioEquipo extends StatefulWidget {
  final String clienteId;
  final EquipoApp? equipoEditar;

  const PaginaFormularioEquipo({
    super.key,
    required this.clienteId,
    this.equipoEditar,
  });

  @override
  State<PaginaFormularioEquipo> createState() => _PaginaFormularioEquipoState();
}

class _PaginaFormularioEquipoState extends State<PaginaFormularioEquipo> {
  final _formKey = GlobalKey<FormState>();
  final _marcaController = TextEditingController();
  final _modeloController = TextEditingController();
  final _numeroSerieController = TextEditingController();
  final _descripcionController = TextEditingController();

  final _repoEquipos = RepositorioEquipos();
  final _servicioStorage = ServicioAlmacenamiento();
  final _imagePicker = ImagePicker();

  String _tipoSeleccionado = 'Laptop';
  bool _guardando = false;
  Uint8List? _bytesImagen;
  String? _nombreImagen;
  String? _fotoUrlExistente;

  final List<String> _tiposEquipo = [
    'Laptop',
    'PC de Escritorio',
    'Consola de Videojuegos',
    'Router / Redes',
    'Cámara de Seguridad',
    'Periférico / Accesorio',
    'Otro dispositivo',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.equipoEditar != null) {
      final e = widget.equipoEditar!;
      _tipoSeleccionado = e.tipoEquipo;
      _marcaController.text = e.marca;
      _modeloController.text = e.modelo;
      _numeroSerieController.text = e.numeroSerie ?? '';
      _descripcionController.text = e.descripcion;
      _fotoUrlExistente = e.fotoUrl;
    }
  }

  @override
  void dispose() {
    _marcaController.dispose();
    _modeloController.dispose();
    _numeroSerieController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  Future<void> _seleccionarFoto() async {
    try {
      final archivo = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (archivo != null) {
        final bytes = await archivo.readAsBytes();
        setState(() {
          _bytesImagen = bytes;
          _nombreImagen = archivo.name;
        });
      }
    } catch (_) {
      if (mounted) {
        DialogosSeguros.mostrarInformacion(
          context: context,
          titulo: 'Error',
          mensaje: 'No se pudo seleccionar la fotografía.',
        );
      }
    }
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _guardando = true);

    try {
      String? urlFoto = _fotoUrlExistente;

      if (_bytesImagen != null && _nombreImagen != null) {
        urlFoto = await _servicioStorage.subirBytesImagen(
          bytes: _bytesImagen!,
          carpeta: CarpetaImagenes.equipos,
          nombreArchivo: '${DateTime.now().millisecondsSinceEpoch}_$_nombreImagen',
        );
      }

      final nuevoEquipo = EquipoApp(
        id: widget.equipoEditar?.id ?? '',
        clienteId: widget.clienteId,
        tipoEquipo: _tipoSeleccionado,
        marca: _marcaController.text.trim(),
        modelo: _modeloController.text.trim(),
        numeroSerie: _numeroSerieController.text.trim().isEmpty ? null : _numeroSerieController.text.trim(),
        descripcion: _descripcionController.text.trim(),
        fotoUrl: urlFoto,
        fechaRegistro: widget.equipoEditar?.fechaRegistro ?? DateTime.now().toIso8601String(),
      );

      if (widget.equipoEditar != null) {
        await _repoEquipos.actualizarEquipo(nuevoEquipo);
      } else {
        await _repoEquipos.registrarEquipo(nuevoEquipo);
      }

      if (!mounted) return;
      setState(() => _guardando = false);

      await DialogosSeguros.mostrarInformacion(
        context: context,
        titulo: 'Equipo Guardado',
        mensaje: widget.equipoEditar != null
            ? 'Los datos del equipo han sido actualizados.'
            : 'El dispositivo ha sido registrado en tu cuenta de MIRASTEC.',
      );

      if (!mounted) return;
      context.pop(true);
    } catch (e) {
      if (!mounted) return;
      setState(() => _guardando = false);
      DialogosSeguros.mostrarInformacion(
        context: context,
        titulo: 'Error',
        mensaje: 'No se pudo guardar la información del equipo.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.equipoEditar != null ? 'Editar Equipo — MIRASTEC' : 'Registrar Nuevo Equipo — MIRASTEC'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            final salir = await DialogosSeguros.mostrarConfirmacion(
              context: context,
              titulo: '¿Descartar cambios?',
              mensaje: 'Si salís ahora, los datos del equipo no se guardarán.',
            );
            if (salir && context.mounted) context.pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
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
                      Text(
                        widget.equipoEditar != null ? 'Ficha del Dispositivo' : 'Datos del Equipo',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0D47A1)),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Registrá la información de tu computadora o equipo para darle seguimiento técnico.',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      const SizedBox(height: 24),
                      DropdownButtonFormField<String>(
                        // ignore: deprecated_member_use
                        value: _tipoSeleccionado,
                        decoration: const InputDecoration(
                          labelText: 'Tipo de Dispositivo',
                          prefixIcon: Icon(Icons.devices_other),
                          border: OutlineInputBorder(),
                        ),
                        items: _tiposEquipo.map((t) {
                          return DropdownMenuItem(value: t, child: Text(t));
                        }).toList(),
                        onChanged: (v) {
                          if (v != null) setState(() => _tipoSeleccionado = v);
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _marcaController,
                              decoration: const InputDecoration(
                                labelText: 'Marca (ej. Lenovo, HP, Asus)',
                                border: OutlineInputBorder(),
                              ),
                              validator: (v) => v == null || v.trim().isEmpty ? 'Ingresá la marca' : null,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              controller: _modeloController,
                              decoration: const InputDecoration(
                                labelText: 'Modelo',
                                border: OutlineInputBorder(),
                              ),
                              validator: (v) => v == null || v.trim().isEmpty ? 'Ingresá el modelo' : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _numeroSerieController,
                        decoration: const InputDecoration(
                          labelText: 'Número de Serie / Service Tag (Opcional)',
                          hintText: 'Ej. S/N: 12345678X',
                          prefixIcon: Icon(Icons.qr_code_scanner),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _descripcionController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Descripción / Estado del Equipo',
                          hintText: 'Ej. Color negro, con detalles de uso en la tapa, incluye disco SSD...',
                          prefixIcon: Icon(Icons.description_outlined),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Fotografía del equipo con Firebase Storage
                      const Text(
                        'Fotografía del Equipo (Opcional)',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: _bytesImagen != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.memory(_bytesImagen!, fit: BoxFit.cover),
                                  )
                                : (_fotoUrlExistente != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(_fotoUrlExistente!, fit: BoxFit.cover),
                                      )
                                    : const Icon(Icons.add_a_photo_outlined, size: 36, color: Colors.grey)),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                OutlinedButton.icon(
                                  onPressed: _seleccionarFoto,
                                  icon: const Icon(Icons.image_search),
                                  label: const Text('Adjuntar Foto'),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Formatos soportados: JPG, PNG.\nUtil para comprobar el estado del equipo.',
                                  style: TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _guardando ? null : _guardar,
                          icon: _guardando
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                )
                              : const Icon(Icons.save_rounded),
                          label: Text(_guardando ? 'Guardando...' : 'Guardar Equipo'),
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

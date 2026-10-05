import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import '../../../nucleo/utilidades/dialogos_seguros.dart';
import '../datos/repositorio_autenticacion.dart';

class PaginaRegistro extends StatefulWidget {
  const PaginaRegistro({super.key});

  @override
  State<PaginaRegistro> createState() => _PaginaRegistroState();
}

class _PaginaRegistroState extends State<PaginaRegistro> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _apellidosController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _correoController = TextEditingController();
  final _contrasenaController = TextEditingController();
  final _confirmarContrasenaController = TextEditingController();
  final _repoAuth = RepositorioAutenticacion();
  bool _cargando = false;

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidosController.dispose();
    _telefonoController.dispose();
    _correoController.dispose();
    _contrasenaController.dispose();
    _confirmarContrasenaController.dispose();
    super.dispose();
  }

  Future<void> _hacerRegistro() async {
    if (Firebase.apps.isEmpty) {
      DialogosSeguros.mostrarInformacion(
        context: context,
        titulo: 'Firebase no configurado',
        mensaje: 'Aún no se ha vinculado el proyecto en la consola de Firebase. Se requiere configurar Firebase para crear una cuenta real.',
      );
      return;
    }

    if (!_formKey.currentState!.validate()) return;

    if (_contrasenaController.text != _confirmarContrasenaController.text) {
      DialogosSeguros.mostrarInformacion(
        context: context,
        titulo: 'Contraseñas no coinciden',
        mensaje: 'Asegurate de escribir exactamente la misma contraseña en ambos campos.',
      );
      return;
    }

    setState(() => _cargando = true);

    try {
      await _repoAuth.registrarUsuario(
        correo: _correoController.text,
        contrasena: _contrasenaController.text,
        nombre: _nombreController.text,
        apellidos: _apellidosController.text,
        telefono: _telefonoController.text,
      );

      if (!mounted) return;
      setState(() => _cargando = false);

      await DialogosSeguros.mostrarInformacion(
        context: context,
        titulo: 'Registro exitoso',
        mensaje: 'Tu cuenta ha sido creada. ¡Bienvenido a MIRASTEC!',
      );

      if (!mounted) return;
      context.go('/cliente');
    } catch (e) {
      if (!mounted) return;
      setState(() => _cargando = false);
      DialogosSeguros.mostrarInformacion(
        context: context,
        titulo: 'Error en el registro',
        mensaje: 'No se pudo crear la cuenta. Es posible que el correo ya esté en uso.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool firebaseActivo = Firebase.apps.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Cuenta — MIRASTEC'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Ir a la página principal',
          onPressed: () => context.go('/'),
        ),
        actions: [
          TextButton.icon(
            onPressed: () => context.go('/'),
            icon: const Icon(Icons.home_outlined),
            label: const Text('Inicio'),
          ),
          const SizedBox(width: 8),
          TextButton.icon(
            onPressed: () => context.go('/servicios'),
            icon: const Icon(Icons.build_outlined),
            label: const Text('Servicios'),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () => context.go('/'),
                    icon: const Icon(Icons.home, size: 18),
                    label: const Text('Seguir navegando en MIRASTEC'),
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (!firebaseActivo) ...[
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.amber.shade100,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.amber.shade700),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.warning_amber_rounded, color: Colors.amber),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Modo de demostración visual.\nFirebase aún no ha sido configurado.',
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.brown),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                          const Icon(Icons.person_add_outlined, size: 56, color: Color(0xFF00E676)),
                          const SizedBox(height: 16),
                          const Text(
                            'Registro de Cliente',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Completá tus datos para solicitar y dar seguimiento a tus servicios',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _nombreController,
                                  decoration: const InputDecoration(labelText: 'Nombre', border: OutlineInputBorder()),
                                  validator: (v) => v == null || v.trim().isEmpty ? 'Requerido' : null,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextFormField(
                                  controller: _apellidosController,
                                  decoration: const InputDecoration(labelText: 'Apellidos', border: OutlineInputBorder()),
                                  validator: (v) => v == null || v.trim().isEmpty ? 'Requerido' : null,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _telefonoController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              labelText: 'Teléfono de contacto',
                              prefixIcon: Icon(Icons.phone),
                              border: OutlineInputBorder(),
                            ),
                            validator: (v) => v == null || v.trim().isEmpty ? 'Ingresá tu teléfono' : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _correoController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Correo electrónico',
                              prefixIcon: Icon(Icons.email_outlined),
                              border: OutlineInputBorder(),
                            ),
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) return 'Ingresá tu correo';
                              if (!v.contains('@')) return 'Correo no válido';
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _contrasenaController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Contraseña',
                              prefixIcon: Icon(Icons.lock_outline),
                              border: OutlineInputBorder(),
                            ),
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) return 'Ingresá una contraseña';
                              if (v.length < 6) return 'Mínimo 6 caracteres';
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _confirmarContrasenaController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Confirmar contraseña',
                              prefixIcon: Icon(Icons.lock_clock_outlined),
                              border: OutlineInputBorder(),
                            ),
                            validator: (v) => v == null || v.trim().isEmpty ? 'Confirmá tu contraseña' : null,
                          ),
                          const SizedBox(height: 28),
                          ElevatedButton(
                            onPressed: _cargando ? null : _hacerRegistro,
                            child: _cargando
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                  )
                                : const Text('Crear Cuenta'),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('¿Ya tenés una cuenta?'),
                              TextButton(
                                onPressed: () => context.go('/login'),
                                child: const Text('Iniciá Sesión', style: TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

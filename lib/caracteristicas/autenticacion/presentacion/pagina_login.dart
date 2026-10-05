import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import '../../../nucleo/utilidades/dialogos_seguros.dart';
import '../datos/repositorio_autenticacion.dart';
import '../dominio/usuario_app.dart';

class PaginaLogin extends StatefulWidget {
  const PaginaLogin({super.key});

  @override
  State<PaginaLogin> createState() => _PaginaLoginState();
}

class _PaginaLoginState extends State<PaginaLogin> {
  final _formKey = GlobalKey<FormState>();
  final _correoController = TextEditingController();
  final _contrasenaController = TextEditingController();
  final _repoAuth = RepositorioAutenticacion();
  bool _cargando = false;

  @override
  void dispose() {
    _correoController.dispose();
    _contrasenaController.dispose();
    super.dispose();
  }

  Future<void> _hacerLogin() async {
    if (Firebase.apps.isEmpty) {
      DialogosSeguros.mostrarInformacion(
        context: context,
        titulo: 'Firebase no configurado',
        mensaje: 'Aún no se ha vinculado el proyecto en la consola de Firebase. Se requiere configurar Firebase para iniciar sesión.',
      );
      return;
    }

    if (!_formKey.currentState!.validate()) return;

    setState(() => _cargando = true);

    try {
      final credencial = await _repoAuth.iniciarSesion(
        correo: _correoController.text,
        contrasena: _contrasenaController.text,
      );

      final perfil = await _repoAuth.obtenerPerfilUsuario(credencial.user!.uid);

      if (!mounted) return;
      setState(() => _cargando = false);

      if (perfil != null) {
        switch (perfil.rol) {
          case RolUsuario.administrador:
            context.go('/admin');
            break;
          case RolUsuario.tecnico:
            context.go('/tecnico');
            break;
          case RolUsuario.cliente:
            context.go('/cliente');
            break;
        }
      } else {
        context.go('/cliente');
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _cargando = false);
      DialogosSeguros.mostrarInformacion(
        context: context,
        titulo: 'Error al iniciar sesión',
        mensaje: 'Las credenciales ingresadas son incorrectas o la cuenta no existe.',
      );
    }
  }

  Future<void> _solicitarRecuperacion() async {
    if (Firebase.apps.isEmpty) {
      DialogosSeguros.mostrarInformacion(
        context: context,
        titulo: 'Firebase no configurado',
        mensaje: 'Se requiere configurar el proyecto de Firebase para enviar correos de recuperación.',
      );
      return;
    }

    final correo = _correoController.text.trim();
    if (correo.isEmpty) {
      DialogosSeguros.mostrarInformacion(
        context: context,
        titulo: 'Recuperación de contraseña',
        mensaje: 'Por favor, ingresá tu correo electrónico en el campo correspondiente.',
      );
      return;
    }

    try {
      await _repoAuth.recuperarContrasena(correo);
      if (!mounted) return;
      DialogosSeguros.mostrarInformacion(
        context: context,
        titulo: 'Correo enviado',
        mensaje: 'Te hemos enviado un enlace de recuperación a $correo.',
      );
    } catch (e) {
      if (!mounted) return;
      DialogosSeguros.mostrarInformacion(
        context: context,
        titulo: 'Error',
        mensaje: 'No se pudo enviar el correo de recuperación. Verificá que la dirección sea correcta.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool firebaseActivo = Firebase.apps.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar Sesión — MIRASTEC'),
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
            constraints: const BoxConstraints(maxWidth: 440),
            child: Column(
              children: [
                // Enlace rápido a inicio arriba de la tarjeta
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
                          const Icon(Icons.lock_outline_rounded, size: 56, color: Color(0xFF0D47A1)),
                          const SizedBox(height: 16),
                          const Text(
                            'Bienvenido a MIRASTEC',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Ingresá tu correo y contraseña para acceder',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 32),
                          TextFormField(
                            controller: _correoController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Correo electrónico',
                              prefixIcon: Icon(Icons.email_outlined),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) return 'Ingresá tu correo';
                              if (!value.contains('@')) return 'Ingresá un correo válido';
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _contrasenaController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Contraseña',
                              prefixIcon: Icon(Icons.lock_clock_outlined),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) return 'Ingresá tu contraseña';
                              if (value.length < 6) return 'Mínimo 6 caracteres';
                              return null;
                            },
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: _solicitarRecuperacion,
                              child: const Text('¿Olvidaste tu contraseña?'),
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: _cargando ? null : _hacerLogin,
                            child: _cargando
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                  )
                                : const Text('Iniciar Sesión'),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('¿No tenés una cuenta?'),
                              TextButton(
                                onPressed: () => context.go('/registro'),
                                child: const Text('Registrate', style: TextStyle(fontWeight: FontWeight.bold)),
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

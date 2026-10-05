import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'plantilla_estructura_base.dart';

class PaginaAsesoriaGuiadaPublica extends StatefulWidget {
  const PaginaAsesoriaGuiadaPublica({super.key});

  @override
  State<PaginaAsesoriaGuiadaPublica> createState() => _PaginaAsesoriaGuiadaPublicaState();
}

class _PaginaAsesoriaGuiadaPublicaState extends State<PaginaAsesoriaGuiadaPublica> {
  int _pasoActual = 0;
  String? _necesidadSeleccionada;
  String? _modalidadSeleccionada;
  String? _urgenciaSeleccionada;
  final TextEditingController _descripcionController = TextEditingController();

  final List<String> _opcionesNecesidad = [
    'Tengo un problema con un equipo (laptop, PC, consola, router)',
    'Necesito mantenimiento o limpieza preventiva',
    'Tengo problemas con el Internet o cobertura Wi-Fi',
    'Necesito instalar o reparar cámaras de seguridad',
    'Necesito asesoría para comprar equipos o componentes',
    'Necesito una tutoría o capacitación personalizada',
    'No sé exactamente qué necesito, requiero evaluación',
  ];

  final List<String> _opcionesModalidades = [
    'Remoto (asistencia a distancia)',
    'Domicilio (visita a mis instalaciones)',
    'Entrega de equipo (entrega física para reparación)',
    'Asesoría / Tutoría virtual o presencial',
  ];

  final List<String> _opcionesUrgencia = [
    'Baja (puedo esperar unos días)',
    'Media (requiero atención esta semana)',
    'Alta (requiero atención urgente hoy o mañana)',
  ];

  @override
  void dispose() {
    _descripcionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlantillaEstructuraBase(
      mostrarPieDePagina: true,
      cuerpo: Container(
        color: const Color(0xFFF8FAFC),
        padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 850),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Migas de pan / Botón Volver
                Row(
                  children: [
                    TextButton.icon(
                      onPressed: () => context.go('/'),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Volver a Inicio', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: () => context.go('/servicios'),
                      icon: const Icon(Icons.grid_view_rounded),
                      label: const Text('Ver Catálogo'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Solicitud y Asesoría Guiada',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF0D47A1)),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Completá estas sencillas preguntas para orientarte y canalizar tu necesidad.',
                  style: TextStyle(fontSize: 15, color: Color(0xFF64748B)),
                ),
                const SizedBox(height: 24),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Stepper(
                      currentStep: _pasoActual,
                      physics: const NeverScrollableScrollPhysics(),
                      onStepContinue: () {
                        if (_pasoActual < 3) {
                          setState(() => _pasoActual += 1);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Por favor, iniciá sesión o registrate para enviar tu solicitud.'),
                              backgroundColor: Colors.blue,
                            ),
                          );
                        }
                      },
                      onStepCancel: () {
                        if (_pasoActual > 0) {
                          setState(() => _pasoActual -= 1);
                        }
                      },
                      steps: [
                        Step(
                          title: const Text('¿Qué necesitás?', style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: const Text('Seleccioná la opción que mejor describa tu situación'),
                          isActive: _pasoActual >= 0,
                          content: Column(
                            children: _opcionesNecesidad.map((opcion) {
                              return RadioListTile<String>(
                                title: Text(opcion),
                                value: opcion,
                                // ignore: deprecated_member_use
                                groupValue: _necesidadSeleccionada,
                                // ignore: deprecated_member_use
                                onChanged: (val) {
                                  setState(() => _necesidadSeleccionada = val);
                                },
                              );
                            }).toList(),
                          ),
                        ),
                        Step(
                          title: const Text('Contanos qué está pasando', style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: const Text('Detallá brevemente el problema o lo que querés lograr'),
                          isActive: _pasoActual >= 1,
                          content: TextField(
                            controller: _descripcionController,
                            maxLines: 4,
                            decoration: const InputDecoration(
                              hintText: 'Ej. Mi laptop enciende pero la pantalla se queda negra...',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Step(
                          title: const Text('¿Cómo querés recibir la atención?', style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: const Text('Seleccioná la modalidad de atención preferida'),
                          isActive: _pasoActual >= 2,
                          content: Column(
                            children: _opcionesModalidades.map((mod) {
                              return RadioListTile<String>(
                                title: Text(mod),
                                value: mod,
                                // ignore: deprecated_member_use
                                groupValue: _modalidadSeleccionada,
                                // ignore: deprecated_member_use
                                onChanged: (val) {
                                  setState(() => _modalidadSeleccionada = val);
                                },
                              );
                            }).toList(),
                          ),
                        ),
                        Step(
                          title: const Text('¿Qué tan urgente es?', style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: const Text('Nivel de urgencia estimado'),
                          isActive: _pasoActual >= 3,
                          content: Column(
                            children: _opcionesUrgencia.map((urg) {
                              return RadioListTile<String>(
                                title: Text(urg),
                                value: urg,
                                // ignore: deprecated_member_use
                                groupValue: _urgenciaSeleccionada,
                                // ignore: deprecated_member_use
                                onChanged: (val) {
                                  setState(() => _urgenciaSeleccionada = val);
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ],
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

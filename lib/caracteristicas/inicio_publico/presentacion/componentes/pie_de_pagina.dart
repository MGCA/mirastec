import 'package:flutter/material.dart';
import '../../../../nucleo/configuracion/configuracion_app.dart';

class PieDePagina extends StatelessWidget {
  final ConfiguracionApp configuracion;

  const PieDePagina({
    super.key,
    this.configuracion = const ConfiguracionApp(),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF0F172A), // Slate 900
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 32),
            child: Column(
              children: [
                Wrap(
                  spacing: 40,
                  runSpacing: 32,
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    // Columna 1: Marca e Identidad
                    SizedBox(
                      width: 320,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(Icons.handyman_rounded, color: Colors.white, size: 24),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                configuracion.nombreApp,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            '${configuracion.nombreCompletoEmpresa}.\n${configuracion.eslogan}',
                            style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14, height: 1.6),
                          ),
                        ],
                      ),
                    ),

                    // Columna 2: Cobertura Principal
                    SizedBox(
                      width: 240,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Zonas de Cobertura',
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 12),
                          Text(
                            '• Aguas Claras\n• Upala\n• Guayabo\n• Bagaces\n• Liberia\n• La Fortuna',
                            style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 14, height: 1.6),
                          ),
                        ],
                      ),
                    ),

                    // Columna 3: Contacto Directo Dinámico
                    SizedBox(
                      width: 320,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Contacto & Atención',
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.phone_android_rounded, color: Color(0xFF00E676), size: 18),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text('WhatsApp: ${configuracion.telefonoContacto}', style: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 14)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.email_outlined, color: Color(0xFF29B6F6), size: 18),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(configuracion.correoContacto, style: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 14)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.location_on_outlined, color: Colors.orange, size: 18),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  configuracion.direccion,
                                  style: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 13, height: 1.4),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                const Divider(color: Color(0xFF334155)),
                const SizedBox(height: 20),
                Text(
                  '© 2026 ${configuracion.nombreApp} — ${configuracion.nombreCompletoEmpresa}. Todos los derechos reservados.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Color(0xFF64748B), fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

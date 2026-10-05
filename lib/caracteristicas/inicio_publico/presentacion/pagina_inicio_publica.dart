import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'componentes/barra_navegacion_superior.dart';
import 'componentes/menu_lateral_movil.dart';
import 'componentes/pie_de_pagina.dart';
import 'componentes/tarjeta_servicio_publico.dart';
import '../../../nucleo/utilidades/diseno_responsive.dart';

class PaginaInicioPublica extends StatelessWidget {
  const PaginaInicioPublica({super.key});

  @override
  Widget build(BuildContext context) {
    final esMovil = PuntosCorteResponsive.esMovil(context);

    return Scaffold(
      appBar: const BarraNavegacionSuperior(),
      drawer: esMovil ? const MenuLateralMovil() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner Principal / Hero Section
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0D47A1), Color(0xFF1565C0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: EdgeInsets.symmetric(
                vertical: esMovil ? 40 : 80,
                horizontal: esMovil ? 20 : 40,
              ),
              child: Column(
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 900),
                    child: Column(
                      children: [
                        const Text(
                          'Soluciones Tecnológicas Profesionales a tu Alcance',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          '¿Tu computadora está lenta? ¿Necesitás instalar cámaras, configurar Wi-Fi o asesoría tecnológica?\nTe ayudamos de forma rápida, transparente y confiable.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFE2E8F0),
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          alignment: WrapAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF00E676),
                                foregroundColor: Colors.black87,
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                              ),
                              onPressed: () => context.go('/solicitar-servicio'),
                              icon: const Icon(Icons.add_task),
                              label: const Text('Solicitar Servicio Ahora', style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                side: const BorderSide(color: Colors.white, width: 2),
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                              ),
                              onPressed: () => context.go('/solicitar-servicio'),
                              icon: const Icon(Icons.help_outline),
                              label: const Text('No sé qué servicio necesito'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Sección de Servicios Destacados
            Container(
              padding: EdgeInsets.symmetric(
                vertical: esMovil ? 36 : 60,
                horizontal: esMovil ? 20 : 40,
              ),
              child: Column(
                children: [
                  const Text(
                    'Servicios Destacados',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Categorías principales de atención técnica',
                    style: TextStyle(fontSize: 15, color: Color(0xFF64748B)),
                  ),
                  const SizedBox(height: 36),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: esMovil ? 1 : (PuntosCorteResponsive.esTablet(context) ? 2 : 4),
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: esMovil ? 1.4 : 1.1,
                    children: [
                      TarjetaServicioPublico(
                        icono: Icons.computer_rounded,
                        titulo: 'Mantenimiento & Reparación',
                        descripcion: 'Diagnóstico, optimización, limpieza física y cambio de componentes para laptops y PCs.',
                        onTap: () => context.go('/servicios'),
                      ),
                      TarjetaServicioPublico(
                        icono: Icons.wifi_rounded,
                        titulo: 'Redes & Cobertura Wi-Fi',
                        descripcion: 'Configuración de routers, ampliación de señal, puntos de acceso y ponchado de cableado.',
                        onTap: () => context.go('/servicios'),
                      ),
                      TarjetaServicioPublico(
                        icono: Icons.videocam_rounded,
                        titulo: 'Videovigilancia (Cámaras)',
                        descripcion: 'Instalación, mantenimiento y configuración de sistemas de cámaras de seguridad.',
                        onTap: () => context.go('/servicios'),
                      ),
                      TarjetaServicioPublico(
                        icono: Icons.school_rounded,
                        titulo: 'Asesoría & Tutorías',
                        descripcion: 'Capacitación personalizada sobre herramientas tecnológicas y orientación en compras.',
                        onTap: () => context.go('/servicios'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Pie de página
            const PieDePagina(),
          ],
        ),
      ),
    );
  }
}

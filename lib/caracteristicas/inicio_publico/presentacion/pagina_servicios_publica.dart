import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'componentes/barra_navegacion_superior.dart';
import 'componentes/menu_lateral_movil.dart';
import 'componentes/pie_de_pagina.dart';
import 'componentes/tarjeta_servicio_publico.dart';
import '../../../nucleo/utilidades/diseno_responsive.dart';

class PaginaServiciosPublica extends StatelessWidget {
  const PaginaServiciosPublica({super.key});

  @override
  Widget build(BuildContext context) {
    final esMovil = PuntosCorteResponsive.esMovil(context);

    final listaServicios = [
      {'icono': Icons.build, 'titulo': 'Soporte Técnico', 'desc': 'Diagnóstico, mantenimiento preventivo, correctivo y optimización de equipos.'},
      {'icono': Icons.laptop_chromebook, 'titulo': 'Computadoras & Laptops', 'desc': 'Atención de hardware, reemplazo de pantallas, teclados, baterías y mantenimiento.'},
      {'icono': Icons.sports_esports, 'titulo': 'Consolas de Videojuegos', 'desc': 'Mantenimiento preventivo, limpieza interna y pasta térmica.'},
      {'icono': Icons.memory, 'titulo': 'Upgrade de Hardware', 'desc': 'Instalación de memorias RAM, SSDs ultra rápidos y tarjetas de video.'},
      {'icono': Icons.system_update_alt, 'titulo': 'Instalación de Software', 'desc': 'Formateo, instalación de Windows, Office, drivers y programas de trabajo.'},
      {'icono': Icons.cloud_upload_outlined, 'titulo': 'Respaldos de Datos', 'desc': 'Copias de seguridad preventivas y migración de archivos importantes.'},
      {'icono': Icons.router, 'titulo': 'Redes & Conectividad', 'desc': 'Configuración de routers, puntos de acceso mesh y cableado estructurado.'},
      {'icono': Icons.videocam, 'titulo': 'Videovigilancia', 'desc': 'Instalación y configuración de cámaras de seguridad con acceso móvil.'},
      {'icono': Icons.school, 'titulo': 'Tutorías Tecnológicas', 'desc': 'Capacitación personalizada en uso de programas y herramientas digitales.'},
      {'icono': Icons.support_agent, 'titulo': 'Asesoría en Compras', 'desc': 'Orientación para la compra ideal de computadoras y equipos tecnológicos.'},
    ];

    return Scaffold(
      appBar: const BarraNavegacionSuperior(),
      drawer: esMovil ? const MenuLateralMovil() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: const Color(0xFF0D47A1),
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              child: const Column(
                children: [
                  Text(
                    'Catálogo Completo de Servicios',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Explorá nuestras soluciones tecnológicas organizadas por categoría',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 15),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: esMovil ? 24 : 40,
                horizontal: esMovil ? 16 : 40,
              ),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: esMovil ? 1 : (PuntosCorteResponsive.esTablet(context) ? 2 : 3),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: esMovil ? 1.5 : 1.2,
                ),
                itemCount: listaServicios.length,
                itemBuilder: (context, index) {
                  final s = listaServicios[index];
                  return TarjetaServicioPublico(
                    icono: s['icono'] as IconData,
                    titulo: s['titulo'] as String,
                    descripcion: s['desc'] as String,
                    onTap: () => context.go('/solicitar-servicio'),
                  );
                },
              ),
            ),
            const PieDePagina(),
          ],
        ),
      ),
    );
  }
}

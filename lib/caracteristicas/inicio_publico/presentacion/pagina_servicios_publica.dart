import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'componentes/barra_navegacion_superior.dart';
import 'componentes/menu_lateral_movil.dart';
import 'componentes/pie_de_pagina.dart';
import 'componentes/tarjeta_servicio_publico.dart';
import '../../../nucleo/utilidades/diseno_responsive.dart';
import '../../servicios/datos/repositorio_servicios.dart';
import '../../servicios/dominio/servicio_app.dart';
import '../../servicios/utilidades/mapeador_iconos.dart';

class PaginaServiciosPublica extends StatefulWidget {
  const PaginaServiciosPublica({super.key});

  @override
  State<PaginaServiciosPublica> createState() => _PaginaServiciosPublicaState();
}

class _PaginaServiciosPublicaState extends State<PaginaServiciosPublica> {
  final _repoServicios = RepositorioServicios();
  List<ServicioApp> _servicios = [];
  bool _cargando = true;

  @override
  void initState() {
    super.initState();
    _cargarServicios();
  }

  Future<void> _cargarServicios() async {
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

  @override
  Widget build(BuildContext context) {
    final esMovil = PuntosCorteResponsive.esMovil(context);

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
              child: _cargando
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: esMovil ? 1 : (PuntosCorteResponsive.esTablet(context) ? 2 : 3),
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: esMovil ? 1.5 : 1.2,
                      ),
                      itemCount: _servicios.length,
                      itemBuilder: (context, index) {
                        final s = _servicios[index];
                        return TarjetaServicioPublico(
                          icono: MapeadorIconos.obtenerIcono(s.iconoNombre),
                          titulo: s.titulo,
                          descripcion: s.descripcion,
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

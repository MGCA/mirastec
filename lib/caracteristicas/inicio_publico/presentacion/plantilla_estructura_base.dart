import 'package:flutter/material.dart';
import 'componentes/barra_navegacion_superior.dart';
import 'componentes/menu_lateral_movil.dart';
import 'componentes/pie_de_pagina.dart';
import '../../../nucleo/utilidades/diseno_responsive.dart';

class PlantillaEstructuraBase extends StatelessWidget {
  final Widget cuerpo;
  final bool mostrarPieDePagina;

  const PlantillaEstructuraBase({
    super.key,
    required this.cuerpo,
    this.mostrarPieDePagina = true,
  });

  @override
  Widget build(BuildContext context) {
    final esMovil = PuntosCorteResponsive.esMovil(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: const BarraNavegacionSuperior(),
          drawer: esMovil ? const MenuLateralMovil() : null,
          body: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight - 70, // Resta los 70px del AppBar
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  cuerpo,
                  if (mostrarPieDePagina) const PieDePagina(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

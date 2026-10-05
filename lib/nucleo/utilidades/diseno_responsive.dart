import 'package:flutter/material.dart';

class PuntosCorteResponsive {
  static const double maximoMovil = 600;
  static const double maximoTablet = 1024;

  static bool esMovil(BuildContext context) =>
      MediaQuery.of(context).size.width < maximoMovil;

  static bool esTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= maximoMovil &&
      MediaQuery.of(context).size.width <= maximoTablet;

  static bool esEscritorio(BuildContext context) =>
      MediaQuery.of(context).size.width > maximoTablet;
}

class DisenoResponsive extends StatelessWidget {
  final Widget movil;
  final Widget? tablet;
  final Widget escritorio;

  const DisenoResponsive({
    super.key,
    required this.movil,
    this.tablet,
    required this.escritorio,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, restricciones) {
        if (restricciones.maxWidth > PuntosCorteResponsive.maximoTablet) {
          return escritorio;
        } else if (restricciones.maxWidth >= PuntosCorteResponsive.maximoMovil) {
          return tablet ?? escritorio;
        } else {
          return movil;
        }
      },
    );
  }
}

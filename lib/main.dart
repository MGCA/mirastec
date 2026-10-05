import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'nucleo/tema/tema_app.dart';
import 'nucleo/enrutador/enrutador_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: AplicacionMirastec()));
}

class AplicacionMirastec extends StatelessWidget {
  const AplicacionMirastec({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MIRASTEC — Miravalles Asesoramiento Tecnológico',
      theme: TemaApp.temaClaro,
      routerConfig: enrutadorApp,
      debugShowCheckedModeBanner: false,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../nucleo/utilidades/diseno_responsive.dart';

class BarraNavegacionSuperior extends StatelessWidget implements PreferredSizeWidget {
  final String nombreEmpresa;

  const BarraNavegacionSuperior({
    super.key,
    this.nombreEmpresa = 'MIRASTEC',
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    final esEscritorio = PuntosCorteResponsive.esEscritorio(context);

    return AppBar(
      toolbarHeight: 70,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 2,
      shadowColor: Colors.black12,
      title: Row(
        mainAxisSize: MainAxisSize.min,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                nombreEmpresa,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 1.1,
                  color: Color(0xFF0D47A1),
                ),
              ),
              const Text(
                'Asesoramiento Tecnológico',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: !esEscritorio
          ? null
          : [
              TextButton.icon(
                onPressed: () => context.go('/'),
                icon: const Icon(Icons.home_outlined, size: 18),
                label: const Text('Inicio'),
              ),
              TextButton.icon(
                onPressed: () => context.go('/servicios'),
                icon: const Icon(Icons.build_outlined, size: 18),
                label: const Text('Servicios'),
              ),
              TextButton.icon(
                onPressed: () => context.go('/contacto'),
                icon: const Icon(Icons.contact_support_outlined, size: 18),
                label: const Text('Contacto'),
              ),
              const SizedBox(width: 4),
              OutlinedButton.icon(
                onPressed: () => context.go('/login'),
                icon: const Icon(Icons.login, size: 18),
                label: const Text('Iniciar Sesión'),
              ),
              const SizedBox(width: 4),
              ElevatedButton.icon(
                onPressed: () => context.go('/solicitar-servicio'),
                icon: const Icon(Icons.add_task, size: 18),
                label: const Text('Solicitar Servicio'),
              ),
              const SizedBox(width: 12),
            ],
    );
  }
}

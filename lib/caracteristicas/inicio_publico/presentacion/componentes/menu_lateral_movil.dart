import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuLateralMovil extends StatelessWidget {
  const MenuLateralMovil({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 28,
                  child: Icon(Icons.handyman_rounded, color: Color(0xFF0D47A1), size: 32),
                ),
                SizedBox(height: 12),
                Text(
                  'MIRASTEC',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Miravalles Asesoramiento Tecnológico',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Inicio'),
            onTap: () {
              Navigator.pop(context);
              context.go('/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.build_outlined),
            title: const Text('Servicios Tecnológicos'),
            onTap: () {
              Navigator.pop(context);
              context.go('/servicios');
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_support_outlined),
            title: const Text('Contacto y Cobertura'),
            onTap: () {
              Navigator.pop(context);
              context.go('/contacto');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.help_outline, color: Colors.orange),
            title: const Text('No sé qué servicio necesito', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text('Asesoría técnica guiada'),
            onTap: () {
              Navigator.pop(context);
              context.go('/solicitar-servicio');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.login),
            title: const Text('Iniciar Sesión'),
            onTap: () {
              Navigator.pop(context);
              context.go('/login');
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_add_outlined),
            title: const Text('Registrarse'),
            onTap: () {
              Navigator.pop(context);
              context.go('/registro');
            },
          ),
        ],
      ),
    );
  }
}

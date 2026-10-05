import 'package:flutter/material.dart';

class PaginaDashboardAdminPlaceholder extends StatelessWidget {
  const PaginaDashboardAdminPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard de Administración — MIRASTEC')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.dashboard_outlined, size: 64, color: Colors.green),
              SizedBox(height: 16),
              Text(
                'Panel Principal del Administrador',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Gestión de usuarios, asignaciones, agenda y personalización de temas (Fase 7 & 12).',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class PaginaPortalClientePlaceholder extends StatelessWidget {
  const PaginaPortalClientePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Portal del Cliente — MIRASTEC')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person_pin_rounded, size: 64, color: Colors.blue),
              SizedBox(height: 16),
              Text(
                'Bienvenido al Portal del Cliente',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Aquí podrás gestionar tus equipos, crear solicitudes y dar seguimiento a tus servicios (Fase 3 & 4).',
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

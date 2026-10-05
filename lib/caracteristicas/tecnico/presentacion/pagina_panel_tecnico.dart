import 'package:flutter/material.dart';

class PaginaPanelTecnicoPlaceholder extends StatelessWidget {
  const PaginaPanelTecnicoPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Panel del Técnico — MIRASTEC')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.handyman_outlined, size: 64, color: Colors.orange),
              SizedBox(height: 16),
              Text(
                'Bienvenido al Panel del Técnico',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Aquí podrás revisar tus trabajos asignados, registrar diagnósticos y actualizar avances (Fase 8).',
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

import 'package:flutter/material.dart';

class PaginaContactoPublica extends StatelessWidget {
  const PaginaContactoPublica({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacto y Cobertura'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Zonas y Horarios de Atención',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                const Text(
                  'MIRASTEC brinda atención técnica personalizada en Aguas Claras y zonas aledañas.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),
                const Card(
                  child: ListTile(
                    leading: Icon(Icons.location_on, color: Colors.blue, size: 36),
                    title: Text('Zonas de Cobertura Principal', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Aguas Claras, Upala, Guayabo, Bagaces, Liberia, La Fortuna y zonas vecinas.'),
                  ),
                ),
                const SizedBox(height: 16),
                const Card(
                  child: ListTile(
                    leading: Icon(Icons.access_time, color: Colors.green, size: 36),
                    title: Text('Horarios de Atención', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Lunes a Viernes: A partir de las 5:00 p.m.\nFines de Semana: Disponibilidad extendida y desplazamientos.'),
                  ),
                ),
                const SizedBox(height: 16),
                const Card(
                  child: ListTile(
                    leading: Icon(Icons.phone_android, color: Colors.orange, size: 36),
                    title: Text('Canales Directos', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('WhatsApp: +506 8000-0000\nCorreo: contacto@mirastec.com'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

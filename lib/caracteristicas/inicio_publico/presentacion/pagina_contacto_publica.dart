import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'plantilla_estructura_base.dart';

class PaginaContactoPublica extends StatelessWidget {
  const PaginaContactoPublica({super.key});

  @override
  Widget build(BuildContext context) {
    return PlantillaEstructuraBase(
      mostrarPieDePagina: true,
      cuerpo: Container(
        color: const Color(0xFFF8FAFC),
        padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 850),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TextButton.icon(
                      onPressed: () => context.go('/'),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Volver a Inicio', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: () => context.go('/servicios'),
                      icon: const Icon(Icons.grid_view_rounded),
                      label: const Text('Ver Servicios'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Zonas y Horarios de Atención',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF0D47A1)),
                ),
                const SizedBox(height: 6),
                const Text(
                  'MIRASTEC brinda atención técnica personalizada en Aguas Claras y zonas aledañas.',
                  style: TextStyle(fontSize: 15, color: Color(0xFF64748B)),
                ),
                const SizedBox(height: 24),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: const Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color(0xFFE3F2FD),
                            radius: 24,
                            child: Icon(Icons.location_on, color: Color(0xFF0D47A1), size: 28),
                          ),
                          title: Text('Zonas de Cobertura Principal', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                          subtitle: Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: Text(
                              '• Aguas Claras\n• Upala\n• Guayabo\n• Bagaces\n• Liberia\n• La Fortuna y zonas vecinas',
                              style: TextStyle(height: 1.4),
                            ),
                          ),
                        ),
                        Divider(height: 32),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color(0xFFE8F5E9),
                            radius: 24,
                            child: Icon(Icons.access_time_filled, color: Color(0xFF2E7D32), size: 28),
                          ),
                          title: Text('Horarios de Atención', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                          subtitle: Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: Text(
                              '📅 Lunes a Viernes: A partir de las 5:00 p.m.\n📅 Fines de Semana: Disponibilidad extendida y desplazamientos programados.',
                              style: TextStyle(height: 1.4),
                            ),
                          ),
                        ),
                        Divider(height: 32),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color(0xFFFFF3E0),
                            radius: 24,
                            child: Icon(Icons.phone_android, color: Color(0xFFE65100), size: 28),
                          ),
                          title: Text('Canales Directos de Atención', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                          subtitle: Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: Text(
                              '📱 WhatsApp / Teléfono: +506 8000-0000\n✉️ Correo Electrónico: contacto@mirastec.com',
                              style: TextStyle(height: 1.4),
                            ),
                          ),
                        ),
                      ],
                    ),
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

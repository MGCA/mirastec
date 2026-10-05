import 'package:flutter/material.dart';

class PieDePagina extends StatelessWidget {
  const PieDePagina({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0F172A), // Slate 900
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      child: Column(
        children: [
          Wrap(
            spacing: 40,
            runSpacing: 24,
            alignment: WrapAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 280,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'MIRASTEC',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Miravalles Asesoramiento Tecnológico.\nSoluciones integrales de soporte, mantenimiento, redes y videovigilancia.',
                      style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 13, height: 1.5),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 240,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Cobertura Principal',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Aguas Claras\n• Upala\n• Guayabo\n• Bagaces\n• Liberia\n• La Fortuna',
                      style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 13, height: 1.5),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 240,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Contacto',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '📱 WhatsApp / Teléfono: +506 8000-0000\n✉️ Correo: soporte@mirastec.com\n⏰ Horarios: L-V a partir de 5:00 p.m. | S-D Disponibilidad extendida',
                      style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 13, height: 1.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Divider(color: Colors.white24),
          const SizedBox(height: 16),
          const Text(
            '© 2026 MIRASTEC — Miravalles Asesoramiento Tecnológico. Todos los derechos reservados.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

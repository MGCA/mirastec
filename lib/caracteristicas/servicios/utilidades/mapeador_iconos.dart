import 'package:flutter/material.dart';

class MapeadorIconos {
  static IconData obtenerIcono(String iconoNombre) {
    switch (iconoNombre.toLowerCase()) {
      case 'computer':
      case 'laptop':
        return Icons.computer_rounded;
      case 'wifi':
      case 'redes':
        return Icons.wifi_rounded;
      case 'videocam':
      case 'camara':
        return Icons.videocam_rounded;
      case 'school':
      case 'tutoria':
        return Icons.school_rounded;
      case 'build':
      case 'soporte':
        return Icons.build_rounded;
      case 'memory':
      case 'hardware':
        return Icons.memory_rounded;
      case 'cloud':
      case 'respaldo':
        return Icons.cloud_upload_rounded;
      case 'gamepad':
      case 'consola':
        return Icons.sports_esports_rounded;
      default:
        return Icons.handyman_rounded;
    }
  }

  static Map<String, String> get diccionarioIconos => {
        'computer': 'Computadora / Laptop',
        'wifi': 'Redes / Wi-Fi',
        'videocam': 'Videovigilancia / Cámaras',
        'school': 'Tutorías / Asesoría',
        'build': 'Soporte / Herramientas',
        'memory': 'Hardware / SSD RAM',
        'cloud': 'Respaldos / Nube',
        'gamepad': 'Consolas de Videojuegos',
      };
}

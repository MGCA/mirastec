import 'package:flutter/material.dart';

class TemaDinamico {
  static Color _parsearColor(String hexString, Color colorPorDefecto) {
    try {
      final buffer = StringBuffer();
      if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', '').replaceFirst('0x', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (_) {
      return colorPorDefecto;
    }
  }

  static ThemeData generarTema({
    required String hexPrimario,
    required String hexSecundario,
    required String hexAcento,
    bool esTemporadaNavidad = false,
    bool esTemporadaHalloween = false,
  }) {
    Color primario = _parsearColor(hexPrimario, const Color(0xFF0D47A1));
    Color secundario = _parsearColor(hexSecundario, const Color(0xFF00E676));
    Color acento = _parsearColor(hexAcento, const Color(0xFF29B6F6));

    // Preset de Temas de Temporada
    if (esTemporadaNavidad) {
      primario = const Color(0xFFC62828); // Rojo Navideño
      secundario = const Color(0xFF2E7D32); // Verde Pino
      acento = const Color(0xFFFFD54F); // Dorado
    } else if (esTemporadaHalloween) {
      primario = const Color(0xFFE65100); // Naranja Calabaza
      secundario = const Color(0xFF6A1B9A); // Púrpura Bruja
      acento = const Color(0xFFFF6D00);
    }

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primario,
        primary: primario,
        secondary: secundario,
        tertiary: acento,
        surface: Colors.white,
      ),
      scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: primario),
        titleTextStyle: TextStyle(
          color: primario,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primario,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

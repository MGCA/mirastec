import 'package:flutter/material.dart';

class TemaApp {
  // Colores corporativos predeterminados para MIRASTEC
  static const Color primario = Color(0xFF0D47A1); // Azul Tecnológico Profundo
  static const Color secundario = Color(0xFF00E676); // Verde Menta / Éxito
  static const Color acento = Color(0xFF29B6F6); // Cian Tecnológico
  static const Color fondo = Color(0xFFF8FAFC); // Fondo Claro Limpio
  static const Color superficie = Colors.white;
  static const Color textoPrimario = Color(0xFF1E293B);
  static const Color textoSecundario = Color(0xFF64748B);

  static ThemeData get temaClaro {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primario,
        primary: primario,
        secondary: secundario,
        tertiary: acento,
        surface: superficie,
      ),
      scaffoldBackgroundColor: fondo,
      appBarTheme: const AppBarTheme(
        backgroundColor: superficie,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: textoPrimario),
        titleTextStyle: TextStyle(
          color: textoPrimario,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(color: textoPrimario, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(color: textoPrimario, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(color: textoPrimario, fontSize: 16),
        bodyMedium: TextStyle(color: textoSecundario, fontSize: 14),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primario,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

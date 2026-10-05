import 'package:flutter/material.dart';

class DialogosSeguros {
  /// Diálogo de confirmación seguro que no rompe el PopScope de la pantalla previa.
  static Future<bool> mostrarConfirmacion({
    required BuildContext context,
    required String titulo,
    required String mensaje,
    String textoConfirmar = 'Aceptar',
    String textoCancelar = 'Cancelar',
    bool esPeligroso = false,
  }) async {
    final resultado = await showDialog<bool>(
      context: context,
      barrierDismissible: false, // Previene cierre accidental al hacer clic afuera
      builder: (contextoDialogo) {
        return PopScope(
          canPop: false, // Protege el botón atrás físico del navegador / teléfono
          onPopInvokedWithResult: (salio, resultado) {
            if (salio) return;
            Navigator.of(contextoDialogo).pop(false);
          },
          child: AlertDialog(
            title: Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
            content: Text(mensaje),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(contextoDialogo).pop(false),
                child: Text(textoCancelar),
              ),
              ElevatedButton(
                style: esPeligroso
                    ? ElevatedButton.styleFrom(backgroundColor: Colors.red)
                    : null,
                onPressed: () => Navigator.of(contextoDialogo).pop(true),
                child: Text(textoConfirmar),
              ),
            ],
          ),
        );
      },
    );

    return resultado ?? false;
  }

  /// Diálogo informativo seguro.
  static Future<void> mostrarInformacion({
    required BuildContext context,
    required String titulo,
    required String mensaje,
    String textoBoton = 'Entendido',
  }) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (contextoDialogo) {
        return AlertDialog(
          title: Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
          content: Text(mensaje),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(contextoDialogo).pop(),
              child: Text(textoBoton),
            ),
          ],
        );
      },
    );
  }
}

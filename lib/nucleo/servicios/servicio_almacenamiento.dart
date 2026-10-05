import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

enum CarpetaImagenes {
  marca, // Logos de la empresa / banners
  perfilesUsuario, // Fotos de perfil (Clientes, Técnicos, Admin)
  equipos, // Fotos de equipos registrados por clientes
  evidenciasServicio, // Evidencias fotográficas registradas por el técnico
  recepciones, // Fotografías de recepción física de equipos
}

class ServicioAlmacenamiento {
  final FirebaseStorage _storage;

  ServicioAlmacenamiento({FirebaseStorage? storage})
      : _storage = storage ?? FirebaseStorage.instance;

  String _obtenerRutaCarpeta(CarpetaImagenes carpeta) {
    switch (carpeta) {
      case CarpetaImagenes.marca:
        return 'branding';
      case CarpetaImagenes.perfilesUsuario:
        return 'profiles';
      case CarpetaImagenes.equipos:
        return 'equipment';
      case CarpetaImagenes.evidenciasServicio:
        return 'evidences';
      case CarpetaImagenes.recepciones:
        return 'receptions';
    }
  }

  /// Sube una imagen en bytes (compatible con Flutter Web, Android, iOS) y retorna la URL pública.
  Future<String> subirBytesImagen({
    required Uint8List bytes,
    required CarpetaImagenes carpeta,
    required String nombreArchivo,
    String tipoMime = 'image/jpeg',
  }) async {
    final rutaCarpeta = _obtenerRutaCarpeta(carpeta);
    final ref = _storage.ref().child('$rutaCarpeta/$nombreArchivo');

    final metadatos = SettableMetadata(
      contentType: tipoMime,
      customMetadata: {'subidoEn': DateTime.now().toIso8601String()},
    );

    final tareaSubida = await ref.putData(bytes, metadatos);
    final urlDescarga = await tareaSubida.ref.getDownloadURL();
    return urlDescarga;
  }

  /// Elimina una imagen existente en Storage dada su URL.
  Future<void> eliminarImagenPorUrl(String url) async {
    try {
      final ref = _storage.refFromURL(url);
      await ref.delete();
    } catch (_) {
      // Ignorar si el archivo no existía previa eliminación
    }
  }
}

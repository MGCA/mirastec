import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../configuracion/configuracion_app.dart';

class RepositorioConfiguracion {
  FirebaseFirestore? _firestore;

  bool get _estaFirebaseInicializado => Firebase.apps.isNotEmpty;

  FirebaseFirestore get _db {
    if (!_estaFirebaseInicializado) {
      throw FirebaseException(
        plugin: 'core',
        code: 'not-initialized',
        message: 'Firebase no ha sido configurado aún.',
      );
    }
    return _firestore ??= FirebaseFirestore.instance;
  }

  /// Obtener la configuración actual de la plataforma en tiempo real (Stream) o de forma asíncrona.
  Stream<ConfiguracionApp> escucharConfiguracion() {
    if (!_estaFirebaseInicializado) {
      return Stream.value(const ConfiguracionApp());
    }

    return _db.collection('configuracion_plataforma').doc('general').snapshots().map((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        return ConfiguracionApp.fromJson(snapshot.data()!);
      }
      return const ConfiguracionApp();
    });
  }

  /// Guardar / Actualizar la configuración global desde el panel administrativo.
  Future<void> guardarConfiguracion(ConfiguracionApp configuracion) async {
    if (!_estaFirebaseInicializado) return;

    await _db
        .collection('configuracion_plataforma')
        .doc('general')
        .set(configuracion.toJson(), SetOptions(merge: true));
  }
}

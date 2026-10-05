import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../dominio/cliente_app.dart';

class RepositorioClientes {
  FirebaseFirestore? _firestore;

  bool get _estaFirebaseInicializado => Firebase.apps.isNotEmpty;

  FirebaseFirestore get _db {
    if (!_estaFirebaseInicializado) {
      throw FirebaseException(
        plugin: 'core',
        code: 'not-initialized',
        message: 'Firebase no ha sido configurado en la consola aún.',
      );
    }
    return _firestore ??= FirebaseFirestore.instance;
  }

  /// Obtener perfil de cliente por su ID (uid de auth).
  Future<ClienteApp?> obtenerClientePorId(String id) async {
    if (!_estaFirebaseInicializado) return null;
    final doc = await _db.collection('clientes').doc(id).get();
    if (doc.exists && doc.data() != null) {
      return ClienteApp.fromJson(doc.data()!);
    }
    return null;
  }

  /// Crear o actualizar ficha de cliente.
  Future<void> guardarCliente(ClienteApp cliente) async {
    if (!_estaFirebaseInicializado) return;
    await _db.collection('clientes').doc(cliente.id).set(cliente.toJson());
  }

  /// Actualizar datos de contacto y direccion del cliente.
  Future<void> actualizarDireccionYZona({
    required String id,
    required String zona,
    required String direccionReferencia,
    required String telefono,
  }) async {
    if (!_estaFirebaseInicializado) return;
    await _db.collection('clientes').doc(id).update({
      'zona': zona.trim(),
      'direccionReferencia': direccionReferencia.trim(),
      'telefono': telefono.trim(),
    });
  }
}

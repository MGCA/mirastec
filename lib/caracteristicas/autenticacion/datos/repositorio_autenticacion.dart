import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../dominio/usuario_app.dart';

class RepositorioAutenticacion {
  FirebaseAuth? _firebaseAuth;
  FirebaseFirestore? _firestore;

  bool get _estaFirebaseInicializado => Firebase.apps.isNotEmpty;

  FirebaseAuth get _auth {
    if (!_estaFirebaseInicializado) {
      throw FirebaseException(
        plugin: 'core',
        code: 'not-initialized',
        message: 'Firebase no ha sido configurado en la consola de Firebase aún.',
      );
    }
    return _firebaseAuth ??= FirebaseAuth.instance;
  }

  FirebaseFirestore get _db {
    if (!_estaFirebaseInicializado) {
      throw FirebaseException(
        plugin: 'core',
        code: 'not-initialized',
        message: 'Firebase no ha sido configurado en la consola de Firebase aún.',
      );
    }
    return _firestore ??= FirebaseFirestore.instance;
  }

  Stream<User?> get estadoAuth {
    if (!_estaFirebaseInicializado) {
      return Stream.value(null);
    }
    return _auth.authStateChanges();
  }

  User? get usuarioActual {
    if (!_estaFirebaseInicializado) return null;
    return _auth.currentUser;
  }

  /// Registrar nuevo usuario con correo y contraseña, guardando perfil en Firestore.
  Future<UsuarioApp> registrarUsuario({
    required String correo,
    required String contrasena,
    required String nombre,
    required String apellidos,
    required String telefono,
    RolUsuario rol = RolUsuario.cliente,
  }) async {
    final credencial = await _auth.createUserWithEmailAndPassword(
      email: correo.trim(),
      password: contrasena,
    );

    final uid = credencial.user!.uid;
    final nuevoUsuario = UsuarioApp(
      uid: uid,
      correo: correo.trim(),
      nombre: nombre.trim(),
      apellidos: apellidos.trim(),
      telefono: telefono.trim(),
      rol: rol,
      activo: true,
      creadoEn: DateTime.now().toIso8601String(),
    );

    await _db.collection('usuarios').doc(uid).set(nuevoUsuario.toJson());
    return nuevoUsuario;
  }

  /// Iniciar sesión con correo y contraseña.
  Future<UserCredential> iniciarSesion({
    required String correo,
    required String contrasena,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: correo.trim(),
      password: contrasena,
    );
  }

  /// Recuperación de contraseña por correo electrónico.
  Future<void> recuperarContrasena(String correo) async {
    await _auth.sendPasswordResetEmail(email: correo.trim());
  }

  /// Obtener perfil completo del usuario desde Firestore.
  Future<UsuarioApp?> obtenerPerfilUsuario(String uid) async {
    final doc = await _db.collection('usuarios').doc(uid).get();
    if (doc.exists && doc.data() != null) {
      return UsuarioApp.fromJson(doc.data()!);
    }
    return null;
  }

  /// Cerrar sesión actual.
  Future<void> cerrarSesion() async {
    if (_estaFirebaseInicializado) {
      await _auth.signOut();
    }
  }
}

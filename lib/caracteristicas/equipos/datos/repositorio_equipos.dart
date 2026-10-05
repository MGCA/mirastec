import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../dominio/equipo_app.dart';

class RepositorioEquipos {
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

  /// Obtener todos los equipos de un cliente específico.
  Future<List<EquipoApp>> obtenerEquiposPorCliente(String clienteId) async {
    if (!_estaFirebaseInicializado) return [];

    final snapshot = await _db
        .collection('equipos')
        .where('clienteId', isEqualTo: clienteId)
        .get();

    return snapshot.docs.map((doc) => EquipoApp.fromJson(doc.data())).toList();
  }

  /// Registrar un nuevo equipo con ID visible secuencial/formateado.
  Future<EquipoApp> registrarEquipo(EquipoApp equipo) async {
    if (!_estaFirebaseInicializado) return equipo;

    final docRef = _db.collection('equipos').doc();
    final nuevoEquipo = EquipoApp(
      id: 'EQ-${docRef.id.substring(0, 5).toUpperCase()}',
      clienteId: equipo.clienteId,
      tipoEquipo: equipo.tipoEquipo,
      marca: equipo.marca,
      modelo: equipo.modelo,
      numeroSerie: equipo.numeroSerie,
      descripcion: equipo.descripcion,
      fotoUrl: equipo.fotoUrl,
      estado: equipo.estado,
      fechaRegistro: DateTime.now().toIso8601String(),
    );

    await docRef.set(nuevoEquipo.toJson());
    return nuevoEquipo;
  }

  /// Actualizar datos de un equipo existente.
  Future<void> actualizarEquipo(EquipoApp equipo) async {
    if (!_estaFirebaseInicializado) return;

    await _db
        .collection('equipos')
        .doc(equipo.id)
        .update(equipo.toJson());
  }

  /// Cambiar estado de un equipo (ej. inactivo).
  Future<void> cambiarEstadoEquipo(String equipoId, EstadoEquipo nuevoEstado) async {
    if (!_estaFirebaseInicializado) return;

    await _db.collection('equipos').doc(equipoId).update({
      'estado': nuevoEstado.name,
    });
  }
}

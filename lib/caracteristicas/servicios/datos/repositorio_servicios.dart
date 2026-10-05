import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../dominio/servicio_app.dart';

class RepositorioServicios {
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

  // Datos predeterminados de fábrica (Seed inicial) si Firestore está vacío
  static const List<ServicioApp> serviciosSemilla = [
    ServicioApp(
      id: 'srv-01',
      categoriaId: 'cat-01',
      titulo: 'Mantenimiento & Reparación',
      descripcion: 'Diagnóstico, optimización, limpieza física y cambio de componentes para laptops y PCs.',
      iconoNombre: 'computer',
      destacado: true,
      activo: true,
    ),
    ServicioApp(
      id: 'srv-02',
      categoriaId: 'cat-02',
      titulo: 'Redes & Cobertura Wi-Fi',
      descripcion: 'Configuración de routers, ampliación de señal, puntos de acceso y ponchado de cableado.',
      iconoNombre: 'wifi',
      destacado: true,
      activo: true,
    ),
    ServicioApp(
      id: 'srv-03',
      categoriaId: 'cat-03',
      titulo: 'Videovigilancia (Cámaras)',
      descripcion: 'Instalación, mantenimiento y configuración de sistemas de cámaras de seguridad.',
      iconoNombre: 'videocam',
      destacado: true,
      activo: true,
    ),
    ServicioApp(
      id: 'srv-04',
      categoriaId: 'cat-04',
      titulo: 'Asesoría & Tutorías',
      descripcion: 'Capacitación personalizada sobre herramientas tecnológicas y orientación en compras.',
      iconoNombre: 'school',
      destacado: true,
      activo: true,
    ),
  ];

  /// Obtener todos los servicios activos.
  Future<List<ServicioApp>> obtenerServiciosActivos() async {
    if (!_estaFirebaseInicializado) return serviciosSemilla;

    try {
      final snapshot = await _db
          .collection('servicios')
          .where('activo', isEqualTo: true)
          .get();

      if (snapshot.docs.isEmpty) return serviciosSemilla;

      return snapshot.docs.map((doc) => ServicioApp.fromJson(doc.data())).toList();
    } catch (_) {
      return serviciosSemilla;
    }
  }

  /// Obtener servicios destacados para el Banner/Home.
  Future<List<ServicioApp>> obtenerServiciosDestacados() async {
    final todos = await obtenerServiciosActivos();
    final destacados = todos.where((s) => s.destacado).toList();
    return destacados.isNotEmpty ? destacados : todos.take(4).toList();
  }

  /// Guardar o actualizar un servicio desde el panel de administración.
  Future<void> guardarServicio(ServicioApp servicio) async {
    if (!_estaFirebaseInicializado) return;

    final docRef = servicio.id.isEmpty
        ? _db.collection('servicios').doc()
        : _db.collection('servicios').doc(servicio.id);

    final servicioFinal = ServicioApp(
      id: docRef.id,
      categoriaId: servicio.categoriaId,
      titulo: servicio.titulo.trim(),
      descripcion: servicio.descripcion.trim(),
      iconoNombre: servicio.iconoNombre,
      precioBase: servicio.precioBase,
      destacado: servicio.destacado,
      activo: servicio.activo,
      imagenUrl: servicio.imagenUrl,
    );

    await docRef.set(servicioFinal.toJson(), SetOptions(merge: true));
  }

  /// Desactivar / Eliminar servicio.
  Future<void> cambiarEstadoServicio(String servicioId, bool activo) async {
    if (!_estaFirebaseInicializado) return;

    await _db.collection('servicios').doc(servicioId).update({
      'activo': activo,
    });
  }
}

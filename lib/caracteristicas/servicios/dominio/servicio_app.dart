class CategoriaServicioApp {
  final String id;
  final String nombre;
  final String descripcion;
  final String iconoNombre; // Ej. 'computer', 'wifi', 'videocam', 'school'
  final bool activo;
  final int ordenVisual;

  const CategoriaServicioApp({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.iconoNombre,
    this.activo = true,
    this.ordenVisual = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'iconoNombre': iconoNombre,
      'activo': activo,
      'ordenVisual': ordenVisual,
    };
  }

  factory CategoriaServicioApp.fromJson(Map<String, dynamic> json) {
    return CategoriaServicioApp(
      id: json['id'] as String,
      nombre: json['nombre'] as String,
      descripcion: json['descripcion'] as String,
      iconoNombre: json['iconoNombre'] as String? ?? 'build',
      activo: json['activo'] as bool? ?? true,
      ordenVisual: json['ordenVisual'] as int? ?? 0,
    );
  }
}

class ServicioApp {
  final String id;
  final String categoriaId;
  final String titulo;
  final String descripcion;
  final String iconoNombre;
  final double? precioBase;
  final bool destacado; // Se muestra en la pantalla principal (Home)
  final bool activo;
  final String? imagenUrl;

  const ServicioApp({
    required this.id,
    required this.categoriaId,
    required this.titulo,
    required this.descripcion,
    required this.iconoNombre,
    this.precioBase,
    this.destacado = false,
    this.activo = true,
    this.imagenUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoriaId': categoriaId,
      'titulo': titulo,
      'descripcion': descripcion,
      'iconoNombre': iconoNombre,
      'precioBase': precioBase,
      'destacado': destacado,
      'activo': activo,
      'imagenUrl': imagenUrl,
    };
  }

  factory ServicioApp.fromJson(Map<String, dynamic> json) {
    return ServicioApp(
      id: json['id'] as String,
      categoriaId: json['categoriaId'] as String,
      titulo: json['titulo'] as String,
      descripcion: json['descripcion'] as String,
      iconoNombre: json['iconoNombre'] as String? ?? 'build',
      precioBase: (json['precioBase'] as num?)?.toDouble(),
      destacado: json['destacado'] as bool? ?? false,
      activo: json['activo'] as bool? ?? true,
      imagenUrl: json['imagenUrl'] as String?,
    );
  }
}

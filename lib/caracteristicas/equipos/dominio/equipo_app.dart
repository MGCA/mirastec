enum TipoEquipo {
  laptop,
  pcEscritorio,
  consolas,
  routerRed,
  camaras,
  periferico,
  otro,
}

enum EstadoEquipo {
  activo,
  enRevision,
  enReparacion,
  inactivo,
}

class EquipoApp {
  final String id; // EQ-00001
  final String clienteId; // uid del cliente propietario
  final String tipoEquipo; // Laptop, PC, Consola, etc.
  final String marca;
  final String modelo;
  final String? numeroSerie;
  final String descripcion;
  final String? fotoUrl;
  final EstadoEquipo estado;
  final String fechaRegistro;

  const EquipoApp({
    required this.id,
    required this.clienteId,
    required this.tipoEquipo,
    required this.marca,
    required this.modelo,
    this.numeroSerie,
    required this.descripcion,
    this.fotoUrl,
    this.estado = EstadoEquipo.activo,
    required this.fechaRegistro,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clienteId': clienteId,
      'tipoEquipo': tipoEquipo,
      'marca': marca,
      'modelo': modelo,
      'numeroSerie': numeroSerie,
      'descripcion': descripcion,
      'fotoUrl': fotoUrl,
      'estado': estado.name,
      'fechaRegistro': fechaRegistro,
    };
  }

  factory EquipoApp.fromJson(Map<String, dynamic> json) {
    return EquipoApp(
      id: json['id'] as String,
      clienteId: json['clienteId'] as String,
      tipoEquipo: json['tipoEquipo'] as String,
      marca: json['marca'] as String,
      modelo: json['modelo'] as String,
      numeroSerie: json['numeroSerie'] as String?,
      descripcion: json['descripcion'] as String? ?? '',
      fotoUrl: json['fotoUrl'] as String?,
      estado: EstadoEquipo.values.firstWhere(
        (e) => e.name == json['estado'],
        orElse: () => EstadoEquipo.activo,
      ),
      fechaRegistro: json['fechaRegistro'] as String,
    );
  }
}

enum EstadoCliente {
  activo,
  inactivo,
  suspendido,
}

class ClienteApp {
  final String id; // Coincide con el uid de Firebase Auth y usuarios/{uid}
  final String nombre;
  final String apellidos;
  final String telefono;
  final String correo;
  final String zona;
  final String? direccionReferencia;
  final EstadoCliente estado;
  final String fechaRegistro;

  const ClienteApp({
    required this.id,
    required this.nombre,
    required this.apellidos,
    required this.telefono,
    required this.correo,
    required this.zona,
    this.direccionReferencia,
    this.estado = EstadoCliente.activo,
    required this.fechaRegistro,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'apellidos': apellidos,
      'telefono': telefono,
      'correo': correo,
      'zona': zona,
      'direccionReferencia': direccionReferencia,
      'estado': estado.name,
      'fechaRegistro': fechaRegistro,
    };
  }

  factory ClienteApp.fromJson(Map<String, dynamic> json) {
    return ClienteApp(
      id: json['id'] as String,
      nombre: json['nombre'] as String,
      apellidos: json['apellidos'] as String,
      telefono: json['telefono'] as String,
      correo: json['correo'] as String,
      zona: json['zona'] as String? ?? 'Aguas Claras',
      direccionReferencia: json['direccionReferencia'] as String?,
      estado: EstadoCliente.values.firstWhere(
        (e) => e.name == json['estado'],
        orElse: () => EstadoCliente.activo,
      ),
      fechaRegistro: json['fechaRegistro'] as String,
    );
  }
}

enum RolUsuario {
  cliente,
  tecnico,
  administrador,
}

class UsuarioApp {
  final String uid;
  final String correo;
  final String nombre;
  final String apellidos;
  final String telefono;
  final RolUsuario rol;
  final bool activo;
  final String? fotoPerfilUrl;
  final String creadoEn;

  const UsuarioApp({
    required this.uid,
    required this.correo,
    required this.nombre,
    required this.apellidos,
    required this.telefono,
    this.rol = RolUsuario.cliente,
    this.activo = true,
    this.fotoPerfilUrl,
    required this.creadoEn,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'correo': correo,
      'nombre': nombre,
      'apellidos': apellidos,
      'telefono': telefono,
      'rol': rol.name,
      'activo': activo,
      'fotoPerfilUrl': fotoPerfilUrl,
      'creadoEn': creadoEn,
    };
  }

  factory UsuarioApp.fromJson(Map<String, dynamic> json) {
    return UsuarioApp(
      uid: json['uid'] as String,
      correo: json['correo'] as String,
      nombre: json['nombre'] as String,
      apellidos: json['apellidos'] as String,
      telefono: json['telefono'] as String,
      rol: RolUsuario.values.firstWhere(
        (e) => e.name == json['rol'],
        orElse: () => RolUsuario.cliente,
      ),
      activo: json['activo'] as bool? ?? true,
      fotoPerfilUrl: json['fotoPerfilUrl'] as String?,
      creadoEn: json['creadoEn'] as String,
    );
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'configuracion_app.freezed.dart';
part 'configuracion_app.g.dart';

enum TemaTemporada {
  estandar,
  navidad,
  diaDeLaMadre,
  halloween,
  blackFriday,
  personalizado,
}

@freezed
abstract class ConfiguracionApp with _$ConfiguracionApp {
  const factory ConfiguracionApp({
    @Default('MIRASTEC') String nombreApp,
    @Default('Miravalles Asesoramiento Tecnológico') String nombreCompletoEmpresa,
    @Default('Soluciones tecnológicas profesionales a tu alcance') String eslogan,
    @Default('+506 8000-0000') String telefonoContacto,
    @Default('contacto@mirastec.com') String correoContacto,
    @Default('Aguas Claras, Upala, Alajuela, Costa Rica') String direccion,
    @Default('0xFF0D47A1') String colorPrimarioHex,
    @Default('0xFF00E676') String colorSecundarioHex,
    @Default('0xFF29B6F6') String colorAcentoHex,
    @Default(TemaTemporada.estandar) TemaTemporada temaActual,
    @Default(true) bool permitirRegistroClientes,
  }) = _ConfiguracionApp;

  factory ConfiguracionApp.fromJson(Map<String, dynamic> json) => _$ConfiguracionAppFromJson(json);
}

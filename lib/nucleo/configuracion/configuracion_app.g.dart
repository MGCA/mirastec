// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuracion_app.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConfiguracionApp _$ConfiguracionAppFromJson(
  Map<String, dynamic> json,
) => _ConfiguracionApp(
  nombreApp: json['nombreApp'] as String? ?? 'MIRASTEC',
  nombreCompletoEmpresa:
      json['nombreCompletoEmpresa'] as String? ??
      'Miravalles Asesoramiento Tecnológico',
  eslogan:
      json['eslogan'] as String? ??
      'Soluciones tecnológicas profesionales a tu alcance',
  telefonoContacto: json['telefonoContacto'] as String? ?? '+506 8000-0000',
  correoContacto: json['correoContacto'] as String? ?? 'contacto@mirastec.com',
  direccion:
      json['direccion'] as String? ??
      'Aguas Claras, Upala, Alajuela, Costa Rica',
  colorPrimarioHex: json['colorPrimarioHex'] as String? ?? '0xFF0D47A1',
  colorSecundarioHex: json['colorSecundarioHex'] as String? ?? '0xFF00E676',
  colorAcentoHex: json['colorAcentoHex'] as String? ?? '0xFF29B6F6',
  temaActual:
      $enumDecodeNullable(_$TemaTemporadaEnumMap, json['temaActual']) ??
      TemaTemporada.estandar,
  permitirRegistroClientes: json['permitirRegistroClientes'] as bool? ?? true,
);

Map<String, dynamic> _$ConfiguracionAppToJson(_ConfiguracionApp instance) =>
    <String, dynamic>{
      'nombreApp': instance.nombreApp,
      'nombreCompletoEmpresa': instance.nombreCompletoEmpresa,
      'eslogan': instance.eslogan,
      'telefonoContacto': instance.telefonoContacto,
      'correoContacto': instance.correoContacto,
      'direccion': instance.direccion,
      'colorPrimarioHex': instance.colorPrimarioHex,
      'colorSecundarioHex': instance.colorSecundarioHex,
      'colorAcentoHex': instance.colorAcentoHex,
      'temaActual': _$TemaTemporadaEnumMap[instance.temaActual]!,
      'permitirRegistroClientes': instance.permitirRegistroClientes,
    };

const _$TemaTemporadaEnumMap = {
  TemaTemporada.estandar: 'estandar',
  TemaTemporada.navidad: 'navidad',
  TemaTemporada.diaDeLaMadre: 'diaDeLaMadre',
  TemaTemporada.halloween: 'halloween',
  TemaTemporada.blackFriday: 'blackFriday',
  TemaTemporada.personalizado: 'personalizado',
};

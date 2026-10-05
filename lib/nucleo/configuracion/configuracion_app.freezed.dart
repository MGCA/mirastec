// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'configuracion_app.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConfiguracionApp {

 String get nombreApp; String get nombreCompletoEmpresa; String get eslogan; String get telefonoContacto; String get correoContacto; String get direccion; String get colorPrimarioHex; String get colorSecundarioHex; String get colorAcentoHex; TemaTemporada get temaActual; bool get permitirRegistroClientes;
/// Create a copy of ConfiguracionApp
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConfiguracionAppCopyWith<ConfiguracionApp> get copyWith => _$ConfiguracionAppCopyWithImpl<ConfiguracionApp>(this as ConfiguracionApp, _$identity);

  /// Serializes this ConfiguracionApp to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConfiguracionApp&&(identical(other.nombreApp, nombreApp) || other.nombreApp == nombreApp)&&(identical(other.nombreCompletoEmpresa, nombreCompletoEmpresa) || other.nombreCompletoEmpresa == nombreCompletoEmpresa)&&(identical(other.eslogan, eslogan) || other.eslogan == eslogan)&&(identical(other.telefonoContacto, telefonoContacto) || other.telefonoContacto == telefonoContacto)&&(identical(other.correoContacto, correoContacto) || other.correoContacto == correoContacto)&&(identical(other.direccion, direccion) || other.direccion == direccion)&&(identical(other.colorPrimarioHex, colorPrimarioHex) || other.colorPrimarioHex == colorPrimarioHex)&&(identical(other.colorSecundarioHex, colorSecundarioHex) || other.colorSecundarioHex == colorSecundarioHex)&&(identical(other.colorAcentoHex, colorAcentoHex) || other.colorAcentoHex == colorAcentoHex)&&(identical(other.temaActual, temaActual) || other.temaActual == temaActual)&&(identical(other.permitirRegistroClientes, permitirRegistroClientes) || other.permitirRegistroClientes == permitirRegistroClientes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nombreApp,nombreCompletoEmpresa,eslogan,telefonoContacto,correoContacto,direccion,colorPrimarioHex,colorSecundarioHex,colorAcentoHex,temaActual,permitirRegistroClientes);

@override
String toString() {
  return 'ConfiguracionApp(nombreApp: $nombreApp, nombreCompletoEmpresa: $nombreCompletoEmpresa, eslogan: $eslogan, telefonoContacto: $telefonoContacto, correoContacto: $correoContacto, direccion: $direccion, colorPrimarioHex: $colorPrimarioHex, colorSecundarioHex: $colorSecundarioHex, colorAcentoHex: $colorAcentoHex, temaActual: $temaActual, permitirRegistroClientes: $permitirRegistroClientes)';
}


}

/// @nodoc
abstract mixin class $ConfiguracionAppCopyWith<$Res>  {
  factory $ConfiguracionAppCopyWith(ConfiguracionApp value, $Res Function(ConfiguracionApp) _then) = _$ConfiguracionAppCopyWithImpl;
@useResult
$Res call({
 String nombreApp, String nombreCompletoEmpresa, String eslogan, String telefonoContacto, String correoContacto, String direccion, String colorPrimarioHex, String colorSecundarioHex, String colorAcentoHex, TemaTemporada temaActual, bool permitirRegistroClientes
});




}
/// @nodoc
class _$ConfiguracionAppCopyWithImpl<$Res>
    implements $ConfiguracionAppCopyWith<$Res> {
  _$ConfiguracionAppCopyWithImpl(this._self, this._then);

  final ConfiguracionApp _self;
  final $Res Function(ConfiguracionApp) _then;

/// Create a copy of ConfiguracionApp
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nombreApp = null,Object? nombreCompletoEmpresa = null,Object? eslogan = null,Object? telefonoContacto = null,Object? correoContacto = null,Object? direccion = null,Object? colorPrimarioHex = null,Object? colorSecundarioHex = null,Object? colorAcentoHex = null,Object? temaActual = null,Object? permitirRegistroClientes = null,}) {
  return _then(ConfiguracionApp(
nombreApp: null == nombreApp ? _self.nombreApp : nombreApp // ignore: cast_nullable_to_non_nullable
as String,nombreCompletoEmpresa: null == nombreCompletoEmpresa ? _self.nombreCompletoEmpresa : nombreCompletoEmpresa // ignore: cast_nullable_to_non_nullable
as String,eslogan: null == eslogan ? _self.eslogan : eslogan // ignore: cast_nullable_to_non_nullable
as String,telefonoContacto: null == telefonoContacto ? _self.telefonoContacto : telefonoContacto // ignore: cast_nullable_to_non_nullable
as String,correoContacto: null == correoContacto ? _self.correoContacto : correoContacto // ignore: cast_nullable_to_non_nullable
as String,direccion: null == direccion ? _self.direccion : direccion // ignore: cast_nullable_to_non_nullable
as String,colorPrimarioHex: null == colorPrimarioHex ? _self.colorPrimarioHex : colorPrimarioHex // ignore: cast_nullable_to_non_nullable
as String,colorSecundarioHex: null == colorSecundarioHex ? _self.colorSecundarioHex : colorSecundarioHex // ignore: cast_nullable_to_non_nullable
as String,colorAcentoHex: null == colorAcentoHex ? _self.colorAcentoHex : colorAcentoHex // ignore: cast_nullable_to_non_nullable
as String,temaActual: null == temaActual ? _self.temaActual : temaActual // ignore: cast_nullable_to_non_nullable
as TemaTemporada,permitirRegistroClientes: null == permitirRegistroClientes ? _self.permitirRegistroClientes : permitirRegistroClientes // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ConfiguracionApp].
extension ConfiguracionAppPatterns on ConfiguracionApp {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConfiguracionApp value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConfiguracionApp() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConfiguracionApp value)  $default,){
final _that = this;
switch (_that) {
case _ConfiguracionApp():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConfiguracionApp value)?  $default,){
final _that = this;
switch (_that) {
case _ConfiguracionApp() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String nombreApp,  String nombreCompletoEmpresa,  String eslogan,  String telefonoContacto,  String correoContacto,  String direccion,  String colorPrimarioHex,  String colorSecundarioHex,  String colorAcentoHex,  TemaTemporada temaActual,  bool permitirRegistroClientes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConfiguracionApp() when $default != null:
return $default(_that.nombreApp,_that.nombreCompletoEmpresa,_that.eslogan,_that.telefonoContacto,_that.correoContacto,_that.direccion,_that.colorPrimarioHex,_that.colorSecundarioHex,_that.colorAcentoHex,_that.temaActual,_that.permitirRegistroClientes);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String nombreApp,  String nombreCompletoEmpresa,  String eslogan,  String telefonoContacto,  String correoContacto,  String direccion,  String colorPrimarioHex,  String colorSecundarioHex,  String colorAcentoHex,  TemaTemporada temaActual,  bool permitirRegistroClientes)  $default,) {final _that = this;
switch (_that) {
case _ConfiguracionApp():
return $default(_that.nombreApp,_that.nombreCompletoEmpresa,_that.eslogan,_that.telefonoContacto,_that.correoContacto,_that.direccion,_that.colorPrimarioHex,_that.colorSecundarioHex,_that.colorAcentoHex,_that.temaActual,_that.permitirRegistroClientes);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String nombreApp,  String nombreCompletoEmpresa,  String eslogan,  String telefonoContacto,  String correoContacto,  String direccion,  String colorPrimarioHex,  String colorSecundarioHex,  String colorAcentoHex,  TemaTemporada temaActual,  bool permitirRegistroClientes)?  $default,) {final _that = this;
switch (_that) {
case _ConfiguracionApp() when $default != null:
return $default(_that.nombreApp,_that.nombreCompletoEmpresa,_that.eslogan,_that.telefonoContacto,_that.correoContacto,_that.direccion,_that.colorPrimarioHex,_that.colorSecundarioHex,_that.colorAcentoHex,_that.temaActual,_that.permitirRegistroClientes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConfiguracionApp implements ConfiguracionApp {
  const _ConfiguracionApp({this.nombreApp = 'MIRASTEC', this.nombreCompletoEmpresa = 'Miravalles Asesoramiento Tecnológico', this.eslogan = 'Soluciones tecnológicas profesionales a tu alcance', this.telefonoContacto = '+506 8000-0000', this.correoContacto = 'contacto@mirastec.com', this.direccion = 'Aguas Claras, Upala, Alajuela, Costa Rica', this.colorPrimarioHex = '0xFF0D47A1', this.colorSecundarioHex = '0xFF00E676', this.colorAcentoHex = '0xFF29B6F6', this.temaActual = TemaTemporada.estandar, this.permitirRegistroClientes = true});
  factory _ConfiguracionApp.fromJson(Map<String, dynamic> json) => _$ConfiguracionAppFromJson(json);

@override@JsonKey() final  String nombreApp;
@override@JsonKey() final  String nombreCompletoEmpresa;
@override@JsonKey() final  String eslogan;
@override@JsonKey() final  String telefonoContacto;
@override@JsonKey() final  String correoContacto;
@override@JsonKey() final  String direccion;
@override@JsonKey() final  String colorPrimarioHex;
@override@JsonKey() final  String colorSecundarioHex;
@override@JsonKey() final  String colorAcentoHex;
@override@JsonKey() final  TemaTemporada temaActual;
@override@JsonKey() final  bool permitirRegistroClientes;

/// Create a copy of ConfiguracionApp
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConfiguracionAppCopyWith<_ConfiguracionApp> get copyWith => __$ConfiguracionAppCopyWithImpl<_ConfiguracionApp>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConfiguracionAppToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConfiguracionApp&&(identical(other.nombreApp, nombreApp) || other.nombreApp == nombreApp)&&(identical(other.nombreCompletoEmpresa, nombreCompletoEmpresa) || other.nombreCompletoEmpresa == nombreCompletoEmpresa)&&(identical(other.eslogan, eslogan) || other.eslogan == eslogan)&&(identical(other.telefonoContacto, telefonoContacto) || other.telefonoContacto == telefonoContacto)&&(identical(other.correoContacto, correoContacto) || other.correoContacto == correoContacto)&&(identical(other.direccion, direccion) || other.direccion == direccion)&&(identical(other.colorPrimarioHex, colorPrimarioHex) || other.colorPrimarioHex == colorPrimarioHex)&&(identical(other.colorSecundarioHex, colorSecundarioHex) || other.colorSecundarioHex == colorSecundarioHex)&&(identical(other.colorAcentoHex, colorAcentoHex) || other.colorAcentoHex == colorAcentoHex)&&(identical(other.temaActual, temaActual) || other.temaActual == temaActual)&&(identical(other.permitirRegistroClientes, permitirRegistroClientes) || other.permitirRegistroClientes == permitirRegistroClientes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nombreApp,nombreCompletoEmpresa,eslogan,telefonoContacto,correoContacto,direccion,colorPrimarioHex,colorSecundarioHex,colorAcentoHex,temaActual,permitirRegistroClientes);

@override
String toString() {
  return 'ConfiguracionApp(nombreApp: $nombreApp, nombreCompletoEmpresa: $nombreCompletoEmpresa, eslogan: $eslogan, telefonoContacto: $telefonoContacto, correoContacto: $correoContacto, direccion: $direccion, colorPrimarioHex: $colorPrimarioHex, colorSecundarioHex: $colorSecundarioHex, colorAcentoHex: $colorAcentoHex, temaActual: $temaActual, permitirRegistroClientes: $permitirRegistroClientes)';
}


}

/// @nodoc
abstract mixin class _$ConfiguracionAppCopyWith<$Res> implements $ConfiguracionAppCopyWith<$Res> {
  factory _$ConfiguracionAppCopyWith(_ConfiguracionApp value, $Res Function(_ConfiguracionApp) _then) = __$ConfiguracionAppCopyWithImpl;
@override @useResult
$Res call({
 String nombreApp, String nombreCompletoEmpresa, String eslogan, String telefonoContacto, String correoContacto, String direccion, String colorPrimarioHex, String colorSecundarioHex, String colorAcentoHex, TemaTemporada temaActual, bool permitirRegistroClientes
});




}
/// @nodoc
class __$ConfiguracionAppCopyWithImpl<$Res>
    implements _$ConfiguracionAppCopyWith<$Res> {
  __$ConfiguracionAppCopyWithImpl(this._self, this._then);

  final _ConfiguracionApp _self;
  final $Res Function(_ConfiguracionApp) _then;

/// Create a copy of ConfiguracionApp
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nombreApp = null,Object? nombreCompletoEmpresa = null,Object? eslogan = null,Object? telefonoContacto = null,Object? correoContacto = null,Object? direccion = null,Object? colorPrimarioHex = null,Object? colorSecundarioHex = null,Object? colorAcentoHex = null,Object? temaActual = null,Object? permitirRegistroClientes = null,}) {
  return _then(_ConfiguracionApp(
nombreApp: null == nombreApp ? _self.nombreApp : nombreApp // ignore: cast_nullable_to_non_nullable
as String,nombreCompletoEmpresa: null == nombreCompletoEmpresa ? _self.nombreCompletoEmpresa : nombreCompletoEmpresa // ignore: cast_nullable_to_non_nullable
as String,eslogan: null == eslogan ? _self.eslogan : eslogan // ignore: cast_nullable_to_non_nullable
as String,telefonoContacto: null == telefonoContacto ? _self.telefonoContacto : telefonoContacto // ignore: cast_nullable_to_non_nullable
as String,correoContacto: null == correoContacto ? _self.correoContacto : correoContacto // ignore: cast_nullable_to_non_nullable
as String,direccion: null == direccion ? _self.direccion : direccion // ignore: cast_nullable_to_non_nullable
as String,colorPrimarioHex: null == colorPrimarioHex ? _self.colorPrimarioHex : colorPrimarioHex // ignore: cast_nullable_to_non_nullable
as String,colorSecundarioHex: null == colorSecundarioHex ? _self.colorSecundarioHex : colorSecundarioHex // ignore: cast_nullable_to_non_nullable
as String,colorAcentoHex: null == colorAcentoHex ? _self.colorAcentoHex : colorAcentoHex // ignore: cast_nullable_to_non_nullable
as String,temaActual: null == temaActual ? _self.temaActual : temaActual // ignore: cast_nullable_to_non_nullable
as TemaTemporada,permitirRegistroClientes: null == permitirRegistroClientes ? _self.permitirRegistroClientes : permitirRegistroClientes // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

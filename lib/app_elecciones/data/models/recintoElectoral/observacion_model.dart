

part of '../models.dart';

ObservacionModel observacionModelFromJson(String str) =>
    ObservacionModel.fromJson(json.decode(str));

String observacionModelToJson(ObservacionModel data) => json.encode(data.toJson());

String observacionModelToJson2(ObservacionModel data) => data.getJsonString();

class ObservacionModel {
  ObservacionModel({
    this.idDgoNovedadesElect,
    this.cedula,
    this.numBoleta,
    this.numCitacion,
    this.hora,
    this.motivo,
    this.organizacion,
    this.dirigente,
    this.cantidad,
    this.telefono,
    this.nombre,
    this.cargo,
    this.grado,
    this.funcion,
    this.instalacion,
    this.medioComunicacion,
    this.descripcion,
    this.direccion,
    this.unidad,
    this.numerico,
    this.idDgoNovedadesElectPadre,
    this.descNovedadesElect,
    this.descNovedadesElectPadre,
  });

  int? idDgoNovedadesElect;
  int? idDgoNovedadesElectPadre;
  String? descNovedadesElectPadre;
  String? descNovedadesElect;
  String? cedula;
  String? numBoleta;
  String? numCitacion;
  String? hora;
  String? motivo;
  String? organizacion;
  String? dirigente;
  String? cantidad;
  String? telefono;
  String? nombre;
  String? cargo;
  String? grado;
  String? funcion;
  String? instalacion;
  String? medioComunicacion;
  String? descripcion;
  String? direccion;
  String? unidad;
  String? numerico;

  factory ObservacionModel.fromJson(Map<String, dynamic> json) => ObservacionModel(
    idDgoNovedadesElect: ParseModel.parseToInt(json["idDgoNovedadesElect"]),
    cedula: ParseModel.parseToString(json["cedula"]),
    numBoleta: ParseModel.parseToString(json["numBoleta"]),
    numCitacion: ParseModel.parseToString(json["numCitacion"]),
    hora: ParseModel.parseToString(json["hora"]),
    motivo: ParseModel.parseToString(json["motivo"]),
    organizacion: ParseModel.parseToString(json["organizacion"]),
    dirigente: ParseModel.parseToString(json["dirigente"]),
    cantidad: ParseModel.parseToString(json["cantidad"]),
    telefono: ParseModel.parseToString(json["telefono"]),
    nombre: ParseModel.parseToString(json["nombre"]),
    cargo: ParseModel.parseToString(json["cargo"]),
    grado: ParseModel.parseToString(json["grado"]),
    funcion: ParseModel.parseToString(json["funcion"]),
    instalacion: ParseModel.parseToString(json["instalacion"]),
    medioComunicacion: ParseModel.parseToString(json["medioComunicacion"]),
    descripcion: ParseModel.parseToString(json["descripcion"]),
    direccion: ParseModel.parseToString(json["direccion"]),
    unidad: ParseModel.parseToString(json["unidad"]),
    idDgoNovedadesElectPadre: ParseModel.parseToInt(json["idDgoNovedadesElectPadre"]),
    descNovedadesElect: ParseModel.parseToString(json["descNovedadesElect"]),
    descNovedadesElectPadre: ParseModel.parseToString(json["descNovedadesElectPadre"]),
  );

  Map<String, dynamic> toJson() => {
    "idDgoNovedadesElect": idDgoNovedadesElect,
    "cedula": cedula,
    "numBoleta": numBoleta,
    "numCitacion": numCitacion,
    "hora": hora,
    "motivo": motivo,
    "organizacion": organizacion,
    "dirigente": dirigente,
    "cantidad": cantidad,
    "telefono": telefono,
    "nombre": nombre,
    "cargo": cargo,
    "grado": grado,
    "funcion": funcion,
    "instalacion": instalacion,
    "medioComunicacion": medioComunicacion,
    "descripcion": descripcion,
    "direccion": direccion,
    "unidad": unidad,
    "numerico": numerico,
    "idDgoNovedadesElectPadre": idDgoNovedadesElectPadre,
    "descNovedadesElect": descNovedadesElect,
    "descNovedadesElectPadre": descNovedadesElectPadre,
  }..removeWhere((key, value) => value == null);

  String getJsonString() {
    final Map<String, dynamic> datos = toJson();
    return json.encode(datos);
  }

  ObservacionModel copyWith({
    int? idDgoNovedadesElect,
    int? idDgoNovedadesElectPadre,
    String? descNovedadesElectPadre,
    String? descNovedadesElect,
    String? cedula,
    String? numBoleta,
    String? numCitacion,
    String? hora,
    String? motivo,
    String? organizacion,
    String? dirigente,
    String? cantidad,
    String? telefono,
    String? nombre,
    String? cargo,
    String? grado,
    String? funcion,
    String? instalacion,
    String? medioComunicacion,
    String? descripcion,
    String? direccion,
    String? unidad,
    String? numerico,
  }) {
    return ObservacionModel(
      idDgoNovedadesElect: idDgoNovedadesElect ?? this.idDgoNovedadesElect,
      idDgoNovedadesElectPadre: idDgoNovedadesElectPadre ?? this.idDgoNovedadesElectPadre,
      descNovedadesElectPadre: descNovedadesElectPadre ?? this.descNovedadesElectPadre,
      descNovedadesElect: descNovedadesElect ?? this.descNovedadesElect,
      cedula: cedula ?? this.cedula,
      numBoleta: numBoleta ?? this.numBoleta,
      numCitacion: numCitacion ?? this.numCitacion,
      hora: hora ?? this.hora,
      motivo: motivo ?? this.motivo,
      organizacion: organizacion ?? this.organizacion,
      dirigente: dirigente ?? this.dirigente,
      cantidad: cantidad ?? this.cantidad,
      telefono: telefono ?? this.telefono,
      nombre: nombre ?? this.nombre,
      cargo: cargo ?? this.cargo,
      grado: grado ?? this.grado,
      funcion: funcion ?? this.funcion,
      instalacion: instalacion ?? this.instalacion,
      medioComunicacion: medioComunicacion ?? this.medioComunicacion,
      descripcion: descripcion ?? this.descripcion,
      direccion: direccion ?? this.direccion,
      unidad: unidad ?? this.unidad,
      numerico: numerico ?? this.numerico,
    );
  }
}

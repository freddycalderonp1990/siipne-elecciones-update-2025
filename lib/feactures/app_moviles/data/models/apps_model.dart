import 'dart:convert';

import 'package:api_provider/core/utils/parse_model.dart';

AppsModel appsModelFromJson(String str) => AppsModel.fromJson(json.decode(str));

String appsModelToJson(AppsModel data) => json.encode(data.toJson());

class AppsModel {
  final int statusCode;
  final String message;
  final List<DataApp> dataApps;

  AppsModel({
    required this.statusCode,
    required this.message,
    required this.dataApps,
  });

  factory AppsModel.fromJson(Map<String, dynamic> json) => AppsModel(
    statusCode: json["status_code"],
    message: json["message"],
    dataApps: List<DataApp>.from(json["data"].map((x) => DataApp.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": List<dynamic>.from(dataApps.map((x) => x.toJson())),
  };
}

class DataApp {
  final int idGenAppsMovil;
  final String nombreAplicacion;
  final String descripcion;
  final String versionAndroid;
  final int versionCodeAndroid;
  final String versionIos;
  final int versionCodeIos;
  final String nemonico;
  final String linkAndroid;
  final String linkIos;
  final String fechaPubliacionAdroid;
  final String fechaPublicacionIos;
  final String icono;
  final bool actualizarApp;

  DataApp({
    required this.idGenAppsMovil,
    required this.nombreAplicacion,
    required this.descripcion,
    required this.versionAndroid,
    required this.versionCodeAndroid,
    required this.versionIos,
    required this.versionCodeIos,
    required this.nemonico,
    required this.linkAndroid,
    required this.linkIos,
    required this.fechaPubliacionAdroid,
    required this.fechaPublicacionIos,
    required this.icono,
    required this.actualizarApp,
  });

  factory DataApp.empty() => DataApp(
    idGenAppsMovil: 0,
    nombreAplicacion: "",
    descripcion: "",
    versionAndroid: "",
    versionCodeAndroid: 0,
    versionIos: "",
    versionCodeIos: 0,
    nemonico: "",
    linkAndroid: "",
    linkIos: "",
    fechaPubliacionAdroid: "",
    fechaPublicacionIos: "",
    icono: "",
    actualizarApp: false,
  );
  factory DataApp.fromJson(Map<String, dynamic> json) => DataApp(
    idGenAppsMovil: ParseModel.parseToInt(json["idGenAppsMovil"]),
    nombreAplicacion: ParseModel.parseToString(json["nombreAplicacion"]),
    descripcion: ParseModel.parseToString(json["descripcion"]),
    versionAndroid: ParseModel.parseToString(json["versionAndroid"]),
    versionCodeAndroid: ParseModel.parseToInt(json["versionCodeAndroid"]),
    versionIos: ParseModel.parseToString(json["versionIos"]),
    versionCodeIos: ParseModel.parseToInt(json["versionCodeIos"]),
    nemonico: ParseModel.parseToString(json["nemonico"]),
    linkAndroid: ParseModel.parseToString(json["linkAndroid"]),
    linkIos: ParseModel.parseToString(json["linkIOS"]),
    fechaPubliacionAdroid: ParseModel.parseToString(
      json["fechaPubliacionAdroid"],
    ),
    fechaPublicacionIos: ParseModel.parseToString(json["fechaPublicacionIos"]),
    icono: ParseModel.parseToString(json["icono"]),
    actualizarApp: json["actualizarApp"],
  );

  Map<String, dynamic> toJson() => {
    "idGenAppsMovil": idGenAppsMovil,
    "nombreAplicacion": nombreAplicacion,
    "descripcion": descripcion,
    "versionAndroid": versionAndroid,
    "versionCodeAndroid": versionCodeAndroid,
    "versionIos": versionIos,
    "versionCodeIos": versionCodeIos,
    "nemonico": nemonico,
    "linkAndroid": linkAndroid,
    "linkIOS": linkIos,
    "fechaPubliacionAdroid": fechaPubliacionAdroid,
    "fechaPublicacionIos": fechaPublicacionIos,
    "icono": icono,
    "actualizarApp": actualizarApp,
  };
}

part of 'models.dart';

EmpresaModel empresaModelFromJson(String str) =>
    EmpresaModel.fromJson(json.decode(str));

String empresaModelToJson(EmpresaModel data) => json.encode(data.toJson());

class EmpresaModel {
  final int statusCode;
  final String message;
  final List<DataEmpresa> dataEmpresa;

  EmpresaModel({
    required this.statusCode,
    required this.message,
    required this.dataEmpresa,
  });

  factory EmpresaModel.fromJson(Map<String, dynamic> json) => EmpresaModel(
    statusCode: json["status_code"],
    message: json["message"],
    dataEmpresa: List<DataEmpresa>.from(
        json["data"].map((x) => DataEmpresa.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": List<dynamic>.from(dataEmpresa.map((x) => x.toJson())),
  };
}

class DataEmpresa {
  final int idDbsEmpresa;
  final int idDbsCatBeneficios;
  final String mostrarInf;
  final String descripcion;
  final String nombreEmpresa;
  final String logo;
  final String tipoDespliegue;
  final String horarioAtencion;
  final String documento;
  final String linkPagina;
  final String contacto;
  final String nombreContacto;
  final String imgBase64;

  DataEmpresa({
    required this.idDbsEmpresa,
    required this.idDbsCatBeneficios,
    required this.mostrarInf,
    required this.nombreEmpresa,
    required this.descripcion,
    required this.logo,
    required this.tipoDespliegue,
    required this.horarioAtencion,
    required this.documento,
    required this.linkPagina,
    required this.contacto,
    required this.nombreContacto,
    required this.imgBase64,
  });

  factory DataEmpresa.fromJson(Map<String, dynamic> json) => DataEmpresa(
    idDbsEmpresa: ParseModel.parseToInt(json["idDbsEmpresa"]),
    idDbsCatBeneficios: ParseModel.parseToInt(json["idDbsCatBeneficios"]),
    mostrarInf: ParseModel.parseToString(json["mostrarInf"]),
    nombreEmpresa: ParseModel.parseToString(json["nombreEmpresa"]),
    descripcion: ParseModel.parseToString(json["descripcion"]),
    logo: ParseModel.parseToString(json["logo"]),
    tipoDespliegue: ParseModel.parseToString(json["tipoDespliegue"]),
    horarioAtencion: ParseModel.parseToString(json["horarioAtencion"]),
    documento: ParseModel.parseToString(json["documento"]),
    linkPagina: ParseModel.parseToString(json["linkPagina"]),
    contacto: ParseModel.parseToString(json["contacto"]),
    nombreContacto: ParseModel.parseToString(json["nombreContacto"]),
    imgBase64: ParseModel.parseToString(json["imgBase64"]),
  );

  Map<String, dynamic> toJson() => {
    "idDbsEmpresa": idDbsEmpresa,
    "idDbsCatBeneficios": idDbsCatBeneficios,
    "mostrarInf": mostrarInf,
    "nombreEmpresa": nombreEmpresa,
    "logo": logo,
    "tipoDespliegue": tipoDespliegue,
    "horarioAtencion": horarioAtencion,
    "documento": documento,
    "linkPagina": linkPagina,
    "contacto": contacto,
    "descripcion":descripcion,
    "nombreContacto": nombreContacto,
    "imgBase64": imgBase64,
  };
}

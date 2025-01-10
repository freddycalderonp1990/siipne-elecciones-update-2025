part of 'models.dart';

BannersModel bannersModelFromJson(String str) => BannersModel.fromJson(json.decode(str));

String bannersModelToJson(BannersModel data) => json.encode(data.toJson());

class BannersModel {
  final int statusCode;
  final String message;
  final List<DataBanner> dataBanners;


  BannersModel({
    required this.statusCode,
    required this.message,
    required this.dataBanners,
  });

  factory BannersModel.fromJson(Map<String, dynamic> json) => BannersModel(
    statusCode: json["status_code"],
    message: json["message"],
    dataBanners: List<DataBanner>.from(json["data"].map((x) => DataBanner.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": List<dynamic>.from(dataBanners.map((x) => x.toJson())),
  };
}

class DataBanner {
  final String empresa;
  final int idDbsBanners;
  final int idDbsEmpresa;
  final String titulo;
  final String descripcion;
  final String fechaInicio;
  final String fechaFin;
  final String imagenReferencia;
  final String imagenFondo;
  final String campoImagen;
  final String imgBase64;
  final bool mostrarImgPersonalizada;

  DataBanner({
    required this.empresa,
    required this.idDbsBanners,
    required this.idDbsEmpresa,
    required this.titulo,
    required this.descripcion,
    required this.fechaInicio,
    required this.fechaFin,
    required this.imagenReferencia,
    required this.imagenFondo,
    required this.campoImagen,
    required this.imgBase64,
    required this.mostrarImgPersonalizada
  });

  factory DataBanner.fromJson(Map<String, dynamic> json) => DataBanner(
    empresa:ParseModel.parseToString( json["empresa"]),
    idDbsBanners: ParseModel.parseToInt( json["idDbsBanners"]),
    idDbsEmpresa: ParseModel.parseToInt( json["idDbsEmpresa"]),
    titulo: ParseModel.parseToString( json["titulo"]),
    descripcion:ParseModel.parseToString(  json["descripcion"]),
    fechaInicio: ParseModel.parseToString( json["fechaInicio"]),
    fechaFin: ParseModel.parseToString( json["fechaFin"]),
    imagenReferencia:ParseModel.parseToString(  json["imagenReferencia"]),
    imagenFondo: ParseModel.parseToString( json["imagenFondo"]),
    campoImagen: ParseModel.parseToString( json["campoImagen"]),
    imgBase64: ParseModel.parseToString( json["imgBase64"]),
    mostrarImgPersonalizada: ParseModel.parseToBool(json["mostrarImgPersonalizada"])
  );

  Map<String, dynamic> toJson() => {
    "empresa": empresa,
    "idDbsBanners": idDbsBanners,
    "idDbsEmpresa": idDbsEmpresa,
    "titulo": titulo,
    "descripcion": descripcion,
    "fechaInicio": fechaInicio,
    "fechaFin": fechaFin,
  "imagenReferencia": imagenReferencia,
    "imagenFondo": imagenFondo,
    "campoImagen": campoImagen,
    "imgBase64": imgBase64,
  };
}

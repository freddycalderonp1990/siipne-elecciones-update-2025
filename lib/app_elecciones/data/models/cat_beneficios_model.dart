part of 'models.dart';

CatBeneficiosModel catBeneficiosModelFromJson(String str) =>
    CatBeneficiosModel.fromJson(json.decode(str));

String catBeneficiosModelToJson(CatBeneficiosModel data) =>
    json.encode(data.toJson());

class CatBeneficiosModel {
  final int statusCode;
  final String message;
  final List<DataCatBeneficio> dataCatBeneficio;

  CatBeneficiosModel({
    required this.statusCode,
    required this.message,
    required this.dataCatBeneficio,
  });

  factory CatBeneficiosModel.fromJson(Map<String, dynamic> json) =>
      CatBeneficiosModel(
        statusCode: json["status_code"],
        message: json["message"],
        dataCatBeneficio: List<DataCatBeneficio>.from(
            json["data"].map((x) => DataCatBeneficio.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": List<dynamic>.from(dataCatBeneficio.map((x) => x.toJson())),
      };
}

class DataCatBeneficio {
  final int idDbsCatBeneficios;
  final int dbsIdDbsCatBeneficios;
  final String descripcion;
  final String nemonico;
  final String icono;
  final String imgBase64;

  DataCatBeneficio({
    required this.idDbsCatBeneficios,
    required this.dbsIdDbsCatBeneficios,
    required this.descripcion,
    required this.nemonico,
    required this.icono,
    required this.imgBase64,
  });

  factory DataCatBeneficio.fromJson(Map<String, dynamic> json) =>
      DataCatBeneficio(
        idDbsCatBeneficios:ParseModel.parseToInt(json["idDbsCatBeneficios"]),
        dbsIdDbsCatBeneficios: ParseModel.parseToInt(json["dbs_idDbsCatBeneficios"]),
        descripcion:ParseModel.parseToString( json["descripcion"]),
        nemonico: ParseModel.parseToString( json["nemonico"]),
        icono: ParseModel.parseToString( json["icono"]),
        imgBase64: ParseModel.parseToString( json["imgBase64"]),
      );

  Map<String, dynamic> toJson() => {
        "idDbsCatBeneficios": idDbsCatBeneficios,
        "dbs_idDbsCatBeneficios": dbsIdDbsCatBeneficios,
        "descripcion": descripcion,
        "nemonico": nemonico,
        "icono": icono,
        "imgBase64": imgBase64,
      };
}

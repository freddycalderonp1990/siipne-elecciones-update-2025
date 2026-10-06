part of '../models.dart';

RecintoTempModel recintoTempModelFromJson(String str) =>
    RecintoTempModel.fromJson(json.decode(str));

String recintoTempModelToJson(RecintoTempModel data) =>
    json.encode(data.toJson());

class RecintoTempModel {
  final int statusCode;
  final String message;
  final List<DataRecintotemp> dataRecintotemp;

  RecintoTempModel({
    required this.statusCode,
    required this.message,
    required this.dataRecintotemp,
  });

  factory RecintoTempModel.fromJson(Map<String, dynamic> json) =>
      RecintoTempModel(
        statusCode: json["status_code"],
        message: json["message"],
        dataRecintotemp: List<DataRecintotemp>.from(
          json["data"].map((x) => DataRecintotemp.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": List<dynamic>.from(dataRecintotemp.map((x) => x.toJson())),
  };
}

class DataRecintotemp {
  final int idDgoReciElectTemp;
  final String nomRecintoElec;
  final String direcRecintoElec;
  final String observacion;
  final String estado;

  DataRecintotemp({
    required this.idDgoReciElectTemp,
    required this.nomRecintoElec,
    required this.direcRecintoElec,
    required this.observacion,
    required this.estado,
  });

  factory DataRecintotemp.fromJson(Map<String, dynamic> json) =>
      DataRecintotemp(
        idDgoReciElectTemp: ParseModel.parseToInt(json["idDgoReciElectTemp"]),
        nomRecintoElec: ParseModel.parseToString(json["nomRecintoElec"]),
        direcRecintoElec: ParseModel.parseToString(json["direcRecintoElec"]),
        observacion: ParseModel.parseToString(json["observacion"]),
        estado: ParseModel.parseToString(json["estado"]),
      );

  Map<String, dynamic> toJson() => {
    "idDgoReciElectTemp": idDgoReciElectTemp,
    "nomRecintoElec": nomRecintoElec,
    "direcRecintoElec": direcRecintoElec,
  };
}

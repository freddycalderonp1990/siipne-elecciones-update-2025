import 'dart:convert';
import 'package:api_provider/core/utils/parse_model.dart';

DataCensoReadQrModel dataReadQrModelFromJson(String str) =>
    DataCensoReadQrModel.fromJson(json.decode(str));

String dataReadQrModelToJson(DataCensoReadQrModel data) =>
    json.encode(data.toJson());

class DataCensoReadQrModel {
  final double latitud;
  final double longitud;
  final int idMesa;
  final int idProceso;
  final int idCensado;
  final int idCensista;
  final String generadoDe;
  final String fecha;


  DataCensoReadQrModel({

    required this.generadoDe,
    required this.fecha,
    required this.latitud,
    required this.longitud,
    required this.idMesa,
    required this.idProceso,
    required this.idCensado,
    required this.idCensista,
  });
  factory DataCensoReadQrModel.empty() => DataCensoReadQrModel(

    generadoDe: "",
    fecha: "",
    latitud: 0,
    longitud: 0,
    idMesa: 0,
    idProceso: 0,
    idCensado: 0,
    idCensista: 0,
  );

  factory DataCensoReadQrModel.fromJson(Map<String, dynamic> json) =>
      DataCensoReadQrModel(

        generadoDe: ParseModel.parseToString(json["generadoDe"]),
        fecha: ParseModel.parseToString(json["fecha"]),
        latitud: ParseModel.parseToDouble(json["latitud"]),
        longitud: ParseModel.parseToDouble(json["longitud"]),
        idMesa:  ParseModel.parseToInt(json["idMesa"]),
        idCensado:  ParseModel.parseToInt(json["idCensado"]),
        idCensista:  ParseModel.parseToInt(json["idCensista"]),
        idProceso:  ParseModel.parseToInt(json["idProceso"]),
      );

  Map<String, dynamic> toJson() => {
    "generadoDe": generadoDe,
    "fecha": fecha,
    "latitud": latitud,
    "longitud": longitud,
    "idMesa": idMesa,
    "idCensado": idCensado,
    "idCensista": idCensista,
    "idProceso": idProceso,
  };
}

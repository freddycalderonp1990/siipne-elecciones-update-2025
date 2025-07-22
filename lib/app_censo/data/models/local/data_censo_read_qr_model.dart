import 'dart:convert';
import 'package:api_provider/core/utils/parse_model.dart';

DataCensoReadQrModel dataReadQrModelFromJson(String str) =>
    DataCensoReadQrModel.fromJson(json.decode(str));

String dataReadQrModelToJson(DataCensoReadQrModel data) =>
    json.encode(data.toJson());

class DataCensoReadQrModel {
  final int idProceso;
  final int idDgpRecinto;
  final int idMesa;
  final double latitudMesa;
  final double longitudMesa;
  final int idGenPersonaCensado;
  final int idGenPersonaCensista;
  final String nameApp;
  final String generadoDe;
  final String fecha;


  DataCensoReadQrModel( {

    required this.generadoDe,
    required this.fecha,
    required this.latitudMesa,
    required this.longitudMesa,
    required this.idMesa,
    required this.idProceso,
    required this.idGenPersonaCensado,
    required this.idGenPersonaCensista,
    required this.idDgpRecinto,required this.nameApp,
  });
  factory DataCensoReadQrModel.empty() => DataCensoReadQrModel(

    generadoDe: "",
    fecha: "",
    latitudMesa: 0,
    longitudMesa: 0,
    idMesa: 0,
    idProceso: 0,
    idGenPersonaCensado: 0,
    idGenPersonaCensista: 0, idDgpRecinto: 0, nameApp: '',
  );

  factory DataCensoReadQrModel.fromJson(Map<String, dynamic> json) =>
      DataCensoReadQrModel(
        idDgpRecinto: ParseModel.parseToInt(json["idDgpRecinto"]),
        nameApp:  ParseModel.parseToString(json["nameApp"]),

        generadoDe: ParseModel.parseToString(json["generadoDe"]),
        fecha: ParseModel.parseToString(json["fecha"]),
        latitudMesa: ParseModel.parseToDouble(json["latitudMesa"]),
        longitudMesa: ParseModel.parseToDouble(json["longitudMesa"]),
        idMesa:  ParseModel.parseToInt(json["idMesa"]),
        idGenPersonaCensado:  ParseModel.parseToInt(json["idGenPersonaCensado"]),
        idGenPersonaCensista:  ParseModel.parseToInt(json["idGenPersonaCensista"]),
        idProceso:  ParseModel.parseToInt(json["idProceso"]),
      );

  Map<String, dynamic> toJson() => {
    "generadoDe": generadoDe,
    "fecha": fecha,
    "latitud": latitudMesa,
    "longitud": longitudMesa,
    "idMesa": idMesa,
    "idGenPersonaCensado": idGenPersonaCensado,
    "idGenPersonaCensista": idGenPersonaCensista,
    "idProceso": idProceso,
  };
}

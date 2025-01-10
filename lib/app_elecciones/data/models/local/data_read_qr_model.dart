part of '../models.dart';

DataReadQrModel dataReadQrModelFromJson(String str) =>
    DataReadQrModel.fromJson(json.decode(str));

String dataReadQrModelToJson(DataReadQrModel data) =>
    json.encode(data.toJson());

class DataReadQrModel {
  final String pasKey;
  final String userName;
  final String nameApp;
  final String generadoDe;
  final String fecha;

  DataReadQrModel({
    required this.pasKey,
    required this.userName,
    required this.nameApp,
    required this.generadoDe,
    required this.fecha,
  });
  factory DataReadQrModel.empty() => DataReadQrModel(
      pasKey: '', userName: '', nameApp: '', generadoDe: '', fecha: '');

  factory DataReadQrModel.fromJson(Map<String, dynamic> json) =>
      DataReadQrModel(
        pasKey: ParseModel.parseToString(json["pasKey"]),
        userName: ParseModel.parseToString(json["userName"]),
        nameApp: ParseModel.parseToString(json["nameApp"]),
        generadoDe: ParseModel.parseToString(json["generadoDe"]),
        fecha: ParseModel.parseToString(json["fecha"]),
      );

  Map<String, dynamic> toJson() => {
        "pasKey": pasKey,
        "userName": userName,
        "nameApp": nameApp,
        "generadoDe": generadoDe,
        "fecha": fecha,
      };
}

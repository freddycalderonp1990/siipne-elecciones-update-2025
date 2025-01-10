part of '../models.dart';


DataSaveAppsQrModel dataSaveAppsQrModelFromJson(String str) => DataSaveAppsQrModel.fromJson(json.decode(str));

String dataSaveAppsQrModelToJson(DataSaveAppsQrModel data) => json.encode(data.toJson());

class DataSaveAppsQrModel {
  final List<ApsQr> apsQr;

  DataSaveAppsQrModel({
    required this.apsQr,
  });

  factory DataSaveAppsQrModel.fromJson(Map<String, dynamic> json) => DataSaveAppsQrModel(
    apsQr: List<ApsQr>.from(json["ApsQR"].map((x) => ApsQr.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ApsQR": List<dynamic>.from(apsQr.map((x) => x.toJson())),
  };
}

class ApsQr {
  final String nameApp;
  final String datos;

  ApsQr({
    required this.nameApp,
    required this.datos,
  });

  factory ApsQr.fromJson(Map<String, dynamic> json) => ApsQr(
    nameApp: json["nameApp"],
    datos: json["datos"],
  );

  Map<String, dynamic> toJson() => {
    "nameApp": nameApp,
    "datos": datos,
  };
}

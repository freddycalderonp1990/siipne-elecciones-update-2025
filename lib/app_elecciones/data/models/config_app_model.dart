part of 'models.dart';

ConfigAppModel configAppModelFromJson(String str) =>
    ConfigAppModel.fromJson(json.decode(str));

String configAppModelToJson(ConfigAppModel data) => json.encode(data.toJson());

class ConfigAppModel {
  final int status_code;
  final String message;
  final DataConfigApp dataConfigApp;

  ConfigAppModel({
    required this.status_code,
    required this.message,
    required this.dataConfigApp,
  });

  factory ConfigAppModel.fromJson(Map<String, dynamic> json) => ConfigAppModel(
        status_code: ParseModel.parseToInt(json["status_code"]),
        message: ParseModel.parseToString(json["message"]),
        dataConfigApp: DataConfigApp.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": status_code,
        "message": message,
        "data": dataConfigApp.toJson(),
      };
}

class DataConfigApp {
  final int versionAndroid;
  final int versionIos;
  final bool compareTimeServer;
  final bool validatePass;
  final bool validateNewPass;
  final String ambiente;

  DataConfigApp({
    required this.versionAndroid,
    required this.versionIos,
    required this.compareTimeServer,
    required this.validatePass,
    required this.validateNewPass,
    required this.ambiente,
  });

  factory DataConfigApp.fromJson(Map<String, dynamic> json) => DataConfigApp(
        versionAndroid: ParseModel.parseToInt(json["versionAndroid"]),
        versionIos: ParseModel.parseToInt(json["versionIos"]),
        compareTimeServer: ParseModel.parseToBool(json["compareTimeServer"]),
        validatePass: ParseModel.parseToBool(json["validatePass"]),
        validateNewPass: ParseModel.parseToBool(json["validateNewPass"]),
        ambiente: ParseModel.parseToString(json["ambiente"]),
      );

  Map<String, dynamic> toJson() => {
        "versionAndroid": versionAndroid,
        "versionIos": versionIos,
      };
}

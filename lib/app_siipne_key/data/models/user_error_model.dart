

import 'dart:convert';

import 'package:api_provider/core/utils/parse_model.dart';

UserErrorModel userErrorModelFromJson(String str) =>
    UserErrorModel.fromJson(json.decode(str));

String userErrorModelToJson(UserErrorModel data) => json.encode(data.toJson());

class UserErrorModel {
  final int statusCode;
  final String message;
  final DataUserError dataUserError;

  UserErrorModel({
    required this.statusCode,
    required this.message,
    required this.dataUserError,
  });

  factory UserErrorModel.fromJson(Map<String, dynamic> json) => UserErrorModel(
        statusCode: ParseModel.parseToInt(json["status_code"]),
        message: ParseModel.parseToString(json["message"]),
        dataUserError: DataUserError.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": dataUserError.toJson(),
      };
}

class DataUserError {
  final int idGenUsuario;
  final bool activarErrores;
  final bool enviarError;

  DataUserError({
    required this.idGenUsuario,
    required this.activarErrores,
    required this.enviarError,
  });

  factory DataUserError.empty() =>
      DataUserError(idGenUsuario: 0, activarErrores: false, enviarError: false);

  factory DataUserError.fromJson(Map<String, dynamic> json) => DataUserError(
        idGenUsuario: ParseModel.parseToInt(json["idGenUsuario"]),
        activarErrores: ParseModel.parseToBool(json["activarErrores"]),
        enviarError: ParseModel.parseToBool(json["enviarError"]),
      );

  Map<String, dynamic> toJson() => {
        "idGenUsuario": idGenUsuario,
        "actrivarErrores": activarErrores,
        "enviarError": enviarError,
      };
}

String logsErrorsUserToJson(LogsErrorsUser data) => json.encode(data.toJson());

class LogsErrorsUser {
  final int idGenUsuario;
  final String versionApp;
  final String fechaCode;
  final String fechaServer;
  final String fechaApp;
  final String unix;
  final String key;
  final String code;
  final String modeloCell;
  final String timeZone;
  final String fechaNow;


  LogsErrorsUser({
    required this.versionApp,
    required this.fechaCode,
    required this.fechaServer,
    required this.fechaApp,
    required this.unix,
    required this.key,
    required this.code,
    required this.modeloCell,
    required this.idGenUsuario,
    required this.timeZone,
    required this.fechaNow
  });

 /* factory LogsErrorsUser.fromJson(Map<String, dynamic> json) => LogsErrorsUser(
        idGenUsuario: ParseModel.parseToInt(json["idGenUsuario"]),
        versionApp: ParseModel.parseToString(json["versionApp"]),
        fechaCode: ParseModel.parseToString(json["fechaCode"]),
        fechaServer: ParseModel.parseToString(json["fechaServer"]),
        fechaApp: ParseModel.parseToString(json["fechaApp"]),
        unix: ParseModel.parseToString(json["unix"]),
        key: ParseModel.parseToString(json["key"]),
        code: ParseModel.parseToString(json["code"]),
        modeloCell: ParseModel.parseToString(json["modeloCell"]),
      );*/

  Map<String, dynamic> toJson() => {
        "idGenUsuario": idGenUsuario,
        "versionApp": versionApp,
        "fechaCode": fechaCode,
        "fechaServer": fechaServer,
        "fechaApp": fechaApp,
        "unix": unix,
        "key": key,
        "code": code,
        "modeloCell": modeloCell,
    "timeZone": timeZone,
    "fechaNow": fechaNow,
      };
}

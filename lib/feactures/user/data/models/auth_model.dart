part of 'models_user.dart';


AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
  final int statusCode;
  final String message;
  final DataAuth dataAuth;

  AuthModel({
    required this.statusCode,
    required this.message,
    required this.dataAuth,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
    statusCode: json["status_code"],
    message: json["message"],
    dataAuth: DataAuth.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": dataAuth.toJson(),
  };
}

class DataAuth {
  final String token;
  final String motivo;
  final bool session;

  DataAuth({
    required this.token,
    required this.motivo,
    required this.session,
  });

  factory DataAuth.fromJson(Map<String, dynamic> json) => DataAuth(
    token: ParseModel.parseToString(json["token"]),
    motivo: ParseModel.parseToString(json["motivo"]),
    session: ParseModel.parseToBool( json["session"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "motivo": motivo,
    "session": session,
  };
}

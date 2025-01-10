part of 'models.dart';

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
    statusCode: json["status_code1"],
    message: json["message1"],
    dataAuth: DataAuth.fromJson(json["data1"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": dataAuth.toJson(),
  };
}

class DataAuth {
  final String token;
  final String foto;

  DataAuth({
    required this.token,
    required this.foto,
  });

  factory DataAuth.fromJson(Map<String, dynamic> json) => DataAuth(
    token: ParseModel.parseToString(json["token"]),
    foto:ParseModel.parseToString(json["foto"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "foto": foto,
  };
}

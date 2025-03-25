part of 'models_user.dart';


DataTokenModel dataTokenModelFromJson(String str) => DataTokenModel.fromJson(json.decode(str));

String dataTokenModelToJson(DataTokenModel data) => json.encode(data.toJson());

class DataTokenModel {
  final int statusCode;
  final String message;
  final DataToken dataToken;

  DataTokenModel({
    required this.statusCode,
    required this.message,
    required this.dataToken,
  });

  factory DataTokenModel.fromJson(Map<String, dynamic> json) => DataTokenModel(
    statusCode: json["status_code"],
    message: json["message"],
    dataToken: DataToken.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": dataToken.toJson(),
  };
}

class DataToken {
  final String token;

  DataToken({
    required this.token,
  });



  factory DataToken.fromJson(Map<String, dynamic> json) => DataToken(
    token: ParseModel.parseToString(json["token"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
  };
}

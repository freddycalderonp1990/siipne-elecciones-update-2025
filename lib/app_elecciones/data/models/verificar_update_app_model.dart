part of 'models.dart';



VerificarUpdateAppModel verificarUpdateAppModelFromJson(String str) => VerificarUpdateAppModel.fromJson(json.decode(str));

String verificarUpdateAppModelToJson(VerificarUpdateAppModel data) => json.encode(data.toJson());

class VerificarUpdateAppModel {
  final int status_code;
  final String message;
  final bool dataUpdate;

  VerificarUpdateAppModel({
    required this.status_code,
    required this.message,
    required this.dataUpdate,
  });

  factory VerificarUpdateAppModel.fromJson(Map<String, dynamic> json) => VerificarUpdateAppModel(
    status_code: ParseModel.parseToInt( json["status_code"]),
    message:ParseModel.parseToString( json["message"]),
    dataUpdate:ParseModel.parseToBool( json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": status_code,
    "message": message,
    "data": dataUpdate,
  };
}


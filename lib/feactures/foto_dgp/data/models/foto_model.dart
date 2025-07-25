
import 'dart:convert';

import 'package:api_provider/core/utils/parse_model.dart';

FotoModel fotoModelFromJson(String str) => FotoModel.fromJson(json.decode(str));

String fotoModelToJson(FotoModel data) => json.encode(data.toJson());

class FotoModel {
  final int statusCode;
  final String message;
  final DataFoto dataFoto;

  FotoModel({
    required this.statusCode,
    required this.message,
    required this.dataFoto,
  });

  factory FotoModel.fromJson(Map<String, dynamic> json) => FotoModel(
    statusCode: json["status_code"],
    message: json["message"],
    dataFoto: DataFoto.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": dataFoto.toJson(),
  };
}

class DataFoto {
  final String foto;

  DataFoto({
    required this.foto,
  });

  factory DataFoto.fromJson(Map<String, dynamic> json) => DataFoto(
    foto: ParseModel.parseToString( json["foto"]),
  );

  Map<String, dynamic> toJson() => {
    "foto": foto,
  };
}

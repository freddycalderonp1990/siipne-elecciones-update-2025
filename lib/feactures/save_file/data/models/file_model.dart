
import 'dart:convert';

import 'package:api_provider/core/utils/parse_model.dart';


FileModel fileModelFromJson(String str) => FileModel.fromJson(json.decode(str));

String fileModelToJson(FileModel data) => json.encode(data.toJson());

class FileModel {
  final int statusCode;
  final String message;
  final DataFile dataFile;

  FileModel({
    required this.statusCode,
    required this.message,
    required this.dataFile,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) => FileModel(
    statusCode: json["status_code"],
    message: json["message"],
    dataFile: DataFile.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": dataFile.toJson(),
  };


}

class DataFile {
  final bool result;
  final String nameFile;

  DataFile({
    required this.result,
    required this.nameFile,
  });

  factory DataFile.empty()=>DataFile(result: false, nameFile: "");

  factory DataFile.fromJson(Map<String, dynamic> json) => DataFile(
    result:ParseModel.parseToBool( json["result"]),
    nameFile:ParseModel.parseToString( json["nameFile"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "nameFile": nameFile,
  };
}

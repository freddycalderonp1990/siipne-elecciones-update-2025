import 'dart:convert';

import 'package:api_provider/core/utils/parse_model.dart';

TimeServerModel timeServerModelFromJson(String str) =>
    TimeServerModel.fromJson(json.decode(str));

String timeServerModelToJson(TimeServerModel data) =>
    json.encode(data.toJson());

class TimeServerModel {
  final int statusCode;
  final String message;
  final DateTime time;

  TimeServerModel({
    required this.statusCode,
    required this.message,
    required this.time,
  });

  factory TimeServerModel.fromJson(Map<String, dynamic> json) =>
      TimeServerModel(
        statusCode: ParseModel.parseToInt(json["status_code"]),
        message: ParseModel.parseToString(json["message"]),
        time: DateTime.parse(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": time.toIso8601String(),
  };
}

part of 'models.dart';

NovedadesUdgaPolicialModel novedadesUdgaPolicialModelFromJson(String str) =>
    NovedadesUdgaPolicialModel.fromJson(json.decode(str));

String novedadesUdgaPolicialModelToJson(NovedadesUdgaPolicialModel data) =>
    json.encode(data.toJson());

class NovedadesUdgaPolicialModel {
  final DataNovedadesUdga dataNovedadesUdga;

  NovedadesUdgaPolicialModel({required this.dataNovedadesUdga});

  factory NovedadesUdgaPolicialModel.fromJson(Map<String, dynamic> json) =>
      NovedadesUdgaPolicialModel(
        dataNovedadesUdga: DataNovedadesUdga.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"data": dataNovedadesUdga.toJson()};
}

class DataNovedadesUdga {
  final String motivo;
  final bool session;

  DataNovedadesUdga({required this.motivo, required this.session});

  factory DataNovedadesUdga.fromJson(Map<String, dynamic> json) =>
      DataNovedadesUdga(
        motivo: ParseModel.parseToString(json["motivo"]),
        session: ParseModel.parseToBool(json["session"]),
      );

  Map<String, dynamic> toJson() => {"motivo": motivo, "session": session};
}

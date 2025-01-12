// To parse this JSON data, do
//
//     final novedadesElectoralesModel = novedadesElectoralesModelFromJson(jsonString);

part of '../models.dart';

NovedadesElectoralesModel novedadesElectoralesModelFromJson(String str) =>
    NovedadesElectoralesModel.fromJson(json.decode(str));

String novedadesElectoralesModelToJson(NovedadesElectoralesModel data) =>
    json.encode(data.toJson());

class NovedadesElectoralesModel {
  NovedadesElectoralesModel({
    required this.novedadesElectorales,
  });

  List<NovedadesElectorale> novedadesElectorales;

  factory NovedadesElectoralesModel.fromJson(Map<String, dynamic> json) =>
      NovedadesElectoralesModel(
        novedadesElectorales: json["datos"] == null
            ? []
            : List<NovedadesElectorale>.from(
                json["datos"].map((x) => NovedadesElectorale.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "novedadesElectorales": novedadesElectorales == null
            ? null
            : List<dynamic>.from(novedadesElectorales.map((x) => x.toJson())),
      };
}

class NovedadesElectorale {
  NovedadesElectorale({
    required this.idDgoNovedadesElect,
    required this.dgoIdDgoNovedadesElect,
    required this.descripcion,
    required this.idGenEstado,
  });

  int idDgoNovedadesElect;
  int dgoIdDgoNovedadesElect;
  String descripcion;
  int idGenEstado;

  factory NovedadesElectorale.empty() => NovedadesElectorale(
      idDgoNovedadesElect: 0,
      dgoIdDgoNovedadesElect: 0,
      descripcion: "",
      idGenEstado: 0);
  factory NovedadesElectorale.fromJson(Map<String, dynamic> json) =>
      NovedadesElectorale(
        idDgoNovedadesElect: ParseModel.parseToInt(json["idDgoNovedadesElect"]),
        dgoIdDgoNovedadesElect:
            ParseModel.parseToInt(json["dgo_idDgoNovedadesElect"]),
        descripcion: ParseModel.parseToString(json["descripcion"]),
        idGenEstado: ParseModel.parseToInt(json["idGenEstado"]),
      );

  Map<String, dynamic> toJson() => {
        "idDgoNovedadesElect":
            idDgoNovedadesElect == null ? null : idDgoNovedadesElect,
        "dgo_idDgoNovedadesElect":
            dgoIdDgoNovedadesElect == null ? null : dgoIdDgoNovedadesElect,
        "descripcion": descripcion == null ? null : descripcion,
        "idGenEstado": idGenEstado == null ? null : idGenEstado,
      };
}

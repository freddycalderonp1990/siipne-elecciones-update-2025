part of 'models.dart';

PerSituacionModel perSituacionModelFromJson(String str) =>
    PerSituacionModel.fromJson(json.decode(str));

String perSituacionModelToJson(PerSituacionModel data) =>
    json.encode(data.toJson());

class PerSituacionModel {
  final int statusCode;
  final String message;
  final List<PerSituacion> perSituacion;

  PerSituacionModel({
    required this.statusCode,
    required this.message,
    required this.perSituacion,
  });

  factory PerSituacionModel.fromJson(Map<String, dynamic> json) =>
      PerSituacionModel(
        statusCode: json["status_code"],
        message: json["message"],
        perSituacion: List<PerSituacion>.from(
            json["data"].map((x) => PerSituacion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": List<dynamic>.from(perSituacion.map((x) => x.toJson())),
      };
}

class PerSituacion {
  final int idDgoPerAsigOpe;
  final int idGenPersona;
  final int idGenEstado;
  final String cargo;
  final String delLog;
  final String observacionPer;
  final String situacion;
  final String situacionDescripcion;

  PerSituacion({
    required this.idDgoPerAsigOpe,
    required this.idGenPersona,
    required this.idGenEstado,
    required this.cargo,
    required this.delLog,
    required this.observacionPer,
    required this.situacion,
    required this.situacionDescripcion,
  });

  factory PerSituacion.fromJson(Map<String, dynamic> json) => PerSituacion(
        idDgoPerAsigOpe: ParseModel.parseToInt(json["idDgoPerAsigOpe"]),
        idGenPersona: ParseModel.parseToInt(json["idGenPersona"]),
        idGenEstado: ParseModel.parseToInt(json["idGenEstado"]),
        cargo: ParseModel.parseToString(json["cargo"]),
        delLog: ParseModel.parseToString(json["delLog"]),
        observacionPer: ParseModel.parseToString(json["observacionPer"]),
        situacion: ParseModel.parseToString(json["situacion"]),
        situacionDescripcion:
            ParseModel.parseToString(json["situacion_descripcion"]),
      );

  factory PerSituacion.empty() => PerSituacion(
      idDgoPerAsigOpe: 0,
      idGenPersona: 0,
      idGenEstado: 0,
      cargo: "",
      delLog: "",
      observacionPer: "",
      situacion: "",
      situacionDescripcion: "");

  Map<String, dynamic> toJson() => {
        "idDgoPerAsigOpe": idDgoPerAsigOpe,
        "idGenPersona": idGenPersona,
        "idGenEstado": idGenEstado,
        "cargo": cargo,
        "delLog": delLog,
        "observacionPer": observacionPer,
        "situacion": situacion,
        "situacion_descripcion": situacionDescripcion,
      };
}

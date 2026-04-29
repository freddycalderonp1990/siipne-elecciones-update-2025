part of 'models.dart';

ProcesosOperativosModel procesosOperativosModelFromJson(String str) =>
    ProcesosOperativosModel.fromJson(json.decode(str));

String procesosOperativosModelToJson(ProcesosOperativosModel data) =>
    json.encode(data.toJson());

class ProcesosOperativosModel {
  ProcesosOperativosModel({required this.procesosOperativos});

  List<ProcesosOperativo> procesosOperativos;

  factory ProcesosOperativosModel.fromJson(Map<String, dynamic> json) =>
      ProcesosOperativosModel(
        procesosOperativos: json["datos"] == null
            ? []
            : List<ProcesosOperativo>.from(
                json["datos"].map((x) => ProcesosOperativo.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "datos": procesosOperativos == null
        ? null
        : List<dynamic>.from(procesosOperativos.map((x) => x.toJson())),
  };
}

class ProcesosOperativo {
  ProcesosOperativo({
    required this.idDgoProcElec,

    required this.descProcElecc,
    required this.fechaInici,
    required this.fechaFin,
    required this.tipo,
    required this.validarRecinto,
    required this.mostrarValidado
  });

  int idDgoProcElec;

  String descProcElecc;
  String fechaInici;
  String fechaFin;
  String tipo;
  bool validarRecinto;
  bool mostrarValidado;

  factory ProcesosOperativo.empty() => ProcesosOperativo(
    idDgoProcElec: 0,
    descProcElecc: "",
    fechaInici: "",
    fechaFin: "",
    validarRecinto: false,
    tipo: "",
    mostrarValidado: false
  );

  factory ProcesosOperativo.fromJson(Map<String, dynamic> json) =>
      ProcesosOperativo(
        idDgoProcElec: ParseModel.parseToInt(json["idDgoProcElec"]),
        descProcElecc: ParseModel.parseToString(json["descProcElecc"]),
        fechaInici: ParseModel.parseToString(json["fechaInici"]),
        fechaFin: ParseModel.parseToString(json["fechaFin"]),
        tipo: ParseModel.parseToString(json["tipo"]),
        validarRecinto: ParseModel.parseToBool(
          json["validarRecinto"],
          valueCompareTrue: "SI",
        ),
        mostrarValidado: ParseModel.parseToBool(
          json["mostrarValidado"],
          valueCompareTrue: "SI",
        ),
      );

  Map<String, dynamic> toJson() => {
    "idDgoProcElec": idDgoProcElec == null ? null : idDgoProcElec,

    "descProcElecc": descProcElecc == null ? null : descProcElecc,
    "fechaInici": fechaInici == null ? null : fechaInici,
    "fechaFin": fechaFin == null ? null : fechaFin,
    "tipo": tipo == null ? null : tipo,
  };
}

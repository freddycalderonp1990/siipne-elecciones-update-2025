part of 'models_censo.dart';

ProcesoModel procesoModelFromJson(String str) =>
    ProcesoModel.fromJson(json.decode(str));

String procesoModelToJson(ProcesoModel data) => json.encode(data.toJson());

class ProcesoModel {
  final int statusCode;
  final String message;
  final List<DataProceso> dataProceso;

  ProcesoModel({
    required this.statusCode,
    required this.message,
    required this.dataProceso,
  });

  factory ProcesoModel.fromJson(Map<String, dynamic> json) => ProcesoModel(
    statusCode: json["status_code"],
    message: json["message"],
    dataProceso: List<DataProceso>.from(json["data"].map((x) => DataProceso.fromJson(x))),

  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": List<dynamic>.from(dataProceso.map((x) => x.toJson())),
  };
}

class DataProceso {
  final int idGenProcesoCenso;
  final String descProceso;
  final String fechaIniProceso;
  final String fechaFinProceso;
  final int idDgpRecinto;
  final String descRecinto;
  final int idDgpMesa;
  final String descMesa;
  final String documento;
  final int idGenPersona;
  final String siglas;
  final String apenom;
  final int idDgpPerCenso;
  final bool censado;
  final String estadoCenso;
  final String fecha;

  DataProceso({
    required this.idGenProcesoCenso,
    required this.descProceso,
    required this.idDgpRecinto,
    required this.descRecinto,
    required this.idDgpMesa,
    required this.descMesa,
    required this.documento,
    required this.idGenPersona,
    required this.siglas,
    required this.apenom,
    required this.idDgpPerCenso,
    required this.censado,
    required this.estadoCenso,
    required this.fechaIniProceso,
    required this.fechaFinProceso,
    required this.fecha,
  });

  factory DataProceso.empty() => DataProceso(
    idGenProcesoCenso: 0,
    descProceso: "",
    idDgpMesa: 0,
    descMesa: "",
    documento: "",
    idGenPersona: 0,
    siglas: "",
    apenom: "",
    idDgpPerCenso: 0,
    censado: false,
    estadoCenso: "",
    idDgpRecinto: 0,
    descRecinto: '',
    fechaIniProceso: '',
    fechaFinProceso: '',
    fecha: '',
  );
  factory DataProceso.fromJson(Map<String, dynamic> json) => DataProceso(
    documento: ParseModel.parseToString(json["documento"]),
    idGenPersona: ParseModel.parseToInt(json["idGenPersona"]),
    idGenProcesoCenso: ParseModel.parseToInt(json["idGenEncPrueba"]),
    descProceso: ParseModel.parseToString(json["descPrueba"]),
    idDgpMesa: ParseModel.parseToInt(json["idDgpMesa"]),
    descMesa: ParseModel.parseToString(json["descMesa"]),
    siglas: ParseModel.parseToString(json["siglas"]),
    apenom: ParseModel.parseToString(json["apenom"]),
    idDgpPerCenso: ParseModel.parseToInt(json["idDgpPerCenso"]),
    censado: ParseModel.parseToBool(json["censado"], valueCompareTrue: 'S'),
    estadoCenso: ParseModel.parseToString(json["estadoCenso"]),
    idDgpRecinto: ParseModel.parseToInt(json["idDgpRecinto"]),
    descRecinto: ParseModel.parseToString(json["descRecinto"]),
    fechaIniProceso: ParseModel.parseToString(json["fechaIniProceso"]),
    fechaFinProceso: ParseModel.parseToString(json["fechaFinProceso"]),
    fecha: ParseModel.parseToString(json["fecha"]),
  );

  Map<String, dynamic> toJson() => {
    "idGenEncPrueba": idGenProcesoCenso,
    "descPrueba": descProceso,
    "idDgpMesa": idDgpMesa,
    "descMesa": descMesa,
    "siglas": siglas,
    "apenom": apenom,
    "idDgpPerCenso": idDgpPerCenso,
    "censado": censado,
    "estadoCenso": estadoCenso,
  };
}

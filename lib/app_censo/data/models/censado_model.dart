part of 'models_censo.dart';

CensadoModel censadoModelFromJson(String str) =>
    CensadoModel.fromJson(json.decode(str));

String censadoModelToJson(CensadoModel data) => json.encode(data.toJson());

class CensadoModel {
  final int statusCode;
  final String message;
  final List<DataCensado> dataCensado;

  CensadoModel({
    required this.statusCode,
    required this.message,
    required this.dataCensado,
  });

  factory CensadoModel.fromJson(Map<String, dynamic> json) => CensadoModel(
    statusCode: json["status_code"],
    message: json["message"],
    dataCensado: List<DataCensado>.from(json["data"].map((x) => DataCensado.fromJson(x))),

  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": List<dynamic>.from(dataCensado.map((x) => x.toJson())),
  };
}

class DataCensado {
  final int idGenProcesoCenso;
  final String descProceso;
  final String fechaIniProceso;
  final String fechaFinProceso;
  final int idDgpRecinto;
  final String descRecinto;
  final int idDgpMesa;
  final String descMesa;
  final int idGenPersona;
  final String siglas;
  final String apenom;
  final int idDgpPerCenso;
  final bool censado;
  final String estadoCenso;
  final String fecha;

  DataCensado({
    required this.idGenProcesoCenso,
    required this.descProceso,
    required this.idDgpRecinto,
    required this.descRecinto,
    required this.idDgpMesa,
    required this.descMesa,
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

  factory DataCensado.empty() => DataCensado(
    idGenProcesoCenso: 0,
    descProceso: "",
    idDgpMesa: 0,
    descMesa: "",
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
  factory DataCensado.fromJson(Map<String, dynamic> json) => DataCensado(
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

part of 'models_censo.dart';

CensadoModel censadoModelFromJson(String str) =>
    CensadoModel.fromJson(json.decode(str));

String censadoModelToJson(CensadoModel data) => json.encode(data.toJson());

class CensadoModel {
  final int statusCode;
  final String message;
  final DataCensado dataCensado;

  CensadoModel({
    required this.statusCode,
    required this.message,
    required this.dataCensado,
  });

  factory CensadoModel.fromJson(Map<String, dynamic> json) => CensadoModel(
    statusCode: json["status_code"],
    message: json["message"],
    dataCensado: DataCensado.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": dataCensado.toJson(),
  };
}

class DataCensado {
  final int idGenEncPrueba;
  final String descProceso;
  final int idDgpMesa;
  final String descMesa;
  final int idDgpRecinto;
  final String descRecinto;
  final String siglas;
  final String apenom;
  final int idDgpPerCenso;
  final bool censado;
  final String estadoCenso;

  DataCensado({
    required this.idGenEncPrueba,
    required this.descProceso,
    required this.idDgpRecinto,
    required this.descRecinto,
    required this.idDgpMesa,
    required this.descMesa,
    required this.siglas,
    required this.apenom,
    required this.idDgpPerCenso,
    required this.censado,
    required this.estadoCenso,
  });

  factory DataCensado.empty() => DataCensado(
    idGenEncPrueba: 0,
    descProceso: "",
    idDgpMesa: 0,
    descMesa: "",
    siglas: "",
    apenom: "",
    idDgpPerCenso: 0,
    censado: false,
    estadoCenso: "",
    idDgpRecinto: 0, descRecinto: '',
  );
  factory DataCensado.fromJson(Map<String, dynamic> json) => DataCensado(
    idGenEncPrueba: ParseModel.parseToInt(json["idGenEncPrueba"]),
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
  );

  Map<String, dynamic> toJson() => {
    "idGenEncPrueba": idGenEncPrueba,
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

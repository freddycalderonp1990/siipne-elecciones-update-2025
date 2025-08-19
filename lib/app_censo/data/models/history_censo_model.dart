part of 'models_censo.dart';

HistoryCensoModel historyCensoModelFromJson(String str) => HistoryCensoModel.fromJson(json.decode(str));

String historyCensoModelToJson(HistoryCensoModel data) => json.encode(data.toJson());

class HistoryCensoModel {
  final int statusCode;
  final String message;
  final List<DataHistoryCenso> dataHistoryCenso;

  HistoryCensoModel({
    required this.statusCode,
    required this.message,
    required this.dataHistoryCenso,
  });

  factory HistoryCensoModel.fromJson(Map<String, dynamic> json) => HistoryCensoModel(
    statusCode: json["status_code"],
    message: json["message"],
    dataHistoryCenso: List<DataHistoryCenso>.from(json["data"].map((x) => DataHistoryCenso.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": List<dynamic>.from(dataHistoryCenso.map((x) => x.toJson())),
  };
}

class DataHistoryCenso {
  final int idGenEncPrueba;
  final String descProceso;
  final String fechaIniProceso;
  final String fechaFinProceso;
  final int idDgpRecinto;
  final String descRecinto;
  final int idDgpMesa;
  final String descMesa;
  final int idGenPersona;
  final String documento;
  final String siglas;
  final String apenom;
  final int idDgpPerCenso;
  final bool censado;
  final String estadoCenso;
  final String fecha;
  final String fechaRegistroCenso;

  DataHistoryCenso({
    required this.idGenEncPrueba,
    required this.descProceso,
    required this.fechaIniProceso,
    required this.fechaFinProceso,
    required this.idDgpRecinto,
    required this.descRecinto,
    required this.idDgpMesa,
    required this.descMesa,
    required this.idGenPersona,
    required this.documento,
    required this.siglas,
    required this.apenom,
    required this.idDgpPerCenso,
    required this.censado,
    required this.estadoCenso,
    required this.fecha,
    required this.fechaRegistroCenso,
  });

  factory DataHistoryCenso.fromJson(Map<String, dynamic> json) => DataHistoryCenso(
    idGenEncPrueba:ParseModel.parseToInt( json["idGenEncPrueba"]),
    descProceso:ParseModel.parseToString( json["descPrueba"]),
    fechaIniProceso:ParseModel.parseToString(json["fechaIniProceso"]),
    fechaFinProceso: ParseModel.parseToString(json["fechaFinProceso"]),
    idDgpRecinto: ParseModel.parseToInt( json["idDgpRecinto"]),
    descRecinto:ParseModel.parseToString( json["descRecinto"]),
    idDgpMesa: ParseModel.parseToInt( json["idDgpMesa"]),
    descMesa: ParseModel.parseToString(json["descMesa"]),
    idGenPersona: ParseModel.parseToInt( json["idGenPersona"]),
    documento: ParseModel.parseToString(json["documento"]),
    siglas: ParseModel.parseToString(json["siglas"]),
    apenom: ParseModel.parseToString(json["apenom"]),
    idDgpPerCenso: ParseModel.parseToInt( json["idDgpPerCenso"]),
    censado: ParseModel.parseToBool(json["censado"], valueCompareTrue: 'S'),
    estadoCenso: ParseModel.parseToString(json["estadoCenso"]),
    fecha: ParseModel.parseToString(json["fecha"]),
    fechaRegistroCenso: ParseModel.parseToString(json["fechaRegistroCenso"]),
  );

  Map<String, dynamic> toJson() => {
    "idGenEncPrueba": idGenEncPrueba,
    "descPrueba": descProceso,
    "fechaIniProceso": fechaIniProceso,
    "fechaFinProceso": fechaFinProceso,
    "idDgpRecinto": idDgpRecinto,
    "descRecinto": descRecinto,
    "idDgpMesa": idDgpMesa,
    "descMesa": descMesa,
    "idGenPersona": idGenPersona,
    "documento": documento,
    "siglas": siglas,
    "apenom": apenom,
    "idDgpPerCenso": idDgpPerCenso,
    "censado": censado,
    "estadoCenso": estadoCenso,
    "fecha": fecha,
    "fechaRegistroCenso": fechaRegistroCenso,
  };
}

part of 'models_censo.dart';


MesasModel mesasModelFromJson(String str) => MesasModel.fromJson(json.decode(str));

String mesasModelToJson(MesasModel data) => json.encode(data.toJson());


class MesasModel {
  final int statusCode;
  final String message;
  final DataMesaResponse dataMesaResponse;

  MesasModel({
    required this.statusCode,
    required this.message,
    required this.dataMesaResponse,
  });

  factory MesasModel.fromJson(Map<String, dynamic> json) => MesasModel(
    statusCode: json["status_code"],
    message: json["message"],
    dataMesaResponse: DataMesaResponse.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": dataMesaResponse.toJson(),
  };
}

class DataMesaResponse {
  final bool isCensita;
  final bool isCensoTodos;
  final List<DataMesa> mesas;

  DataMesaResponse({
    required this.isCensita,
    required this.isCensoTodos,
    required this.mesas,
  });

  factory DataMesaResponse.empty()=>DataMesaResponse(isCensita: false, isCensoTodos: false, mesas: []);

  factory DataMesaResponse.fromJson(Map<String, dynamic> json) => DataMesaResponse(
    isCensita: json["isCensita"],
    isCensoTodos: json["isCensoTodos"],
    mesas: List<DataMesa>.from(json["mesas"].map((x) => DataMesa.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "isCensita": isCensita,
    "isCensoTodos": isCensoTodos,
    "mesas": List<dynamic>.from(mesas.map((x) => x.toJson())),
  };
}

class DataMesa {
  final int idGenEncPrueba;
  final String descPrueba;
  final String fechaIniProceso;
  final String fechaFinProceso;
  final int idDgpRecinto;
  final String descRecinto;
  final int idDgpMesa;
  final String descMesa;
  final double latitud;
  final double longitud;

  DataMesa({
    required this.idGenEncPrueba,
    required this.descPrueba,
    required this.fechaIniProceso,
    required this.fechaFinProceso,
    required this.idDgpRecinto,
    required this.descRecinto,
    required this.idDgpMesa,
    required this.descMesa,
    required this.latitud,
    required this.longitud,
  });

  factory DataMesa.fromJson(Map<String, dynamic> json) => DataMesa(
    idGenEncPrueba: ParseModel.parseToInt(json["idGenEncPrueba"]),
    descPrueba: ParseModel.parseToString(json["descPrueba"]),
    fechaIniProceso: ParseModel.parseToString(json["fechaIniProceso"]),
    fechaFinProceso: ParseModel.parseToString(json["fechaFinProceso"]),
    idDgpRecinto: ParseModel.parseToInt(json["idDgpRecinto"]),
    descRecinto: ParseModel.parseToString(json["descRecinto"]),
    idDgpMesa: ParseModel.parseToInt(json["idDgpMesa"]),
    descMesa: ParseModel.parseToString(json["descMesa"]),
    latitud: ParseModel.parseToDouble(json["latitud"]),
    longitud: ParseModel.parseToDouble(json["longitud"]),
  );

  Map<String, dynamic> toJson() => {
    "idGenEncPrueba": idGenEncPrueba,
    "descPrueba": descPrueba,
    "fechaIniProceso": fechaIniProceso,
    "fechaFinProceso": fechaFinProceso,
    "idDgpRecinto": idDgpRecinto,
    "descRecinto": descRecinto,
    "idDgpMesa": idDgpMesa,
    "descMesa": descMesa,
    "latitud": latitud,
    "longitud": longitud,
  };
}


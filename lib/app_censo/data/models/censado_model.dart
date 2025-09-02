part of 'models_censo.dart';

CensadoModel censadoModelFromJson(String str) =>
    CensadoModel.fromJson(json.decode(str));

String censadoModelToJson(CensadoModel data) => json.encode(data.toJson());

class CensadoModel {
  final int statusCode;
  final String message;
  final List<DataPerCenso> dataPerCenso;

  CensadoModel({
    required this.statusCode,
    required this.message,
    required this.dataPerCenso,
  });

  factory CensadoModel.fromJson(Map<String, dynamic> json) => CensadoModel(
    statusCode: json["status_code"],
    message: json["message"],
    dataPerCenso: List<DataPerCenso>.from(json["data"].map((x) => DataPerCenso.fromJson(x))),

  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": List<dynamic>.from(dataPerCenso.map((x) => x.toJson())),
  };
}

class DataPerCenso {
  final int idProceso;
  final String proceso;
  final String recintoAsignado;
  final int idDgpMesaAsignado;
  final String mesaAsignado;
  final int idDgpPerCenso;
  final String lugarAsignacion;
  final String gradoCensistaAsignado;
  final String nameCensistaAsignado;
  final String recintoCenso;
  final String mesaCensado;
  final String lugarCenso;
  final String gradoCensista;
  final String nameCensista;
  final String documentoCensado;
  final String gradoCensado;
  final String nameCensado;
  final bool censado;
  final String estadoCenso;
  final String fechaRegistroCenso;
  final double latitudCenso;
  final double longitudCenso;
  final String descCausaNCs;
  final String obsNoCenso;

  DataPerCenso( {
    required this.gradoCensistaAsignado,required this.gradoCensista,required this.gradoCensado,

    required this.idProceso,
    required this.proceso,
    required this.recintoAsignado,
    required this.idDgpMesaAsignado,
    required this.mesaAsignado,
    required this.idDgpPerCenso,
    required this.lugarAsignacion,
    required this.nameCensistaAsignado,
    required this.recintoCenso,
    required this.mesaCensado,
    required this.lugarCenso,
    required this.nameCensista,
    required this.documentoCensado,
    required this.nameCensado,
    required this.censado,
    required this.estadoCenso,
    required this.fechaRegistroCenso,
    required this.latitudCenso,required this.longitudCenso,required this.descCausaNCs,required this.obsNoCenso,
  });

  factory DataPerCenso.empty() => DataPerCenso(
    idProceso: 0,
    proceso: "",
    recintoAsignado: "",
    idDgpMesaAsignado: 0,
    mesaAsignado: "",
    idDgpPerCenso: 0,
    lugarAsignacion: "",
    nameCensistaAsignado: "",
    recintoCenso: "",
    mesaCensado: "",
    lugarCenso: "",
    nameCensista: "",
    documentoCensado: "",
    nameCensado: "",
    censado: false,
    estadoCenso: "",
    fechaRegistroCenso: "",
    latitudCenso: 0,
    longitudCenso: 0,
    descCausaNCs: "",
    obsNoCenso: "", gradoCensistaAsignado: '', gradoCensista: '', gradoCensado: '',
  );
  factory DataPerCenso.fromJson(Map<String, dynamic> json) => DataPerCenso(
    idProceso: ParseModel.parseToInt(json["idProceso"]),
    proceso: ParseModel.parseToString(json["proceso"]),
    recintoAsignado: ParseModel.parseToString(json["recintoAsignado"]),
    idDgpMesaAsignado: ParseModel.parseToInt(json["idDgpMesaAsignado"]),
    mesaAsignado: ParseModel.parseToString(json["mesaAsignado"]),
    idDgpPerCenso: ParseModel.parseToInt(json["idDgpPerCenso"]),
    lugarAsignacion: ParseModel.parseToString(json["lugarAsignacion"]),
    nameCensistaAsignado: ParseModel.parseToString(json["nameCensistaAsignado"]),
    recintoCenso: ParseModel.parseToString(json["recintoCenso"]),
    mesaCensado: ParseModel.parseToString(json["mesaCensado"]),
    lugarCenso: ParseModel.parseToString(json["lugarCenso"]),
    nameCensista: ParseModel.parseToString(json["nameCensista"]),
    documentoCensado: ParseModel.parseToString(json["documentoCensado"]),
    nameCensado: ParseModel.parseToString(json["nameCensado"]),
    censado: ParseModel.parseToBool(json["censado"], valueCompareTrue: 'S'),
    estadoCenso: ParseModel.parseToString(json["estadoCenso"]),
    fechaRegistroCenso:
    ParseModel.parseToString(json["fechaRegistroCenso"]),
    latitudCenso:ParseModel.parseToDouble( json["latitudCenso"]),
    longitudCenso: ParseModel.parseToDouble(json["longitudCenso"]),
    descCausaNCs: ParseModel.parseToString(json["descCausaNCs"]),
    obsNoCenso: ParseModel.parseToString(json["obsNoCenso"]),
    gradoCensistaAsignado: ParseModel.parseToString(json["gradoCensistaAsignado"]),
    gradoCensista: ParseModel.parseToString(json["gradoCensista"]),
    gradoCensado: ParseModel.parseToString(json["gradoCensado"]),

  );


  Map<String, dynamic> toJson() => {
    "idProceso": idProceso,
    "proceso": proceso,
    "recintoAsignado": recintoAsignado,
    "idDgpMesaAsignado": idDgpMesaAsignado,
    "mesaAsignado": mesaAsignado,
    "idDgpPerCenso": idDgpPerCenso,
    "lugarAsignacion": lugarAsignacion,
    "nameCensistaAsignado": nameCensistaAsignado,
    "recintoCenso": recintoCenso,
    "mesaCensado": mesaCensado,
    "lugarCenso": lugarCenso,
    "nameCensista": nameCensista,
    "documentoCensado": documentoCensado,
    "nameCensado": nameCensado,
    "censado": censado ? "S" : "N",
    "estadoCenso": estadoCenso,
    "fechaRegistroCenso": fechaRegistroCenso,
    "latitudCenso": latitudCenso,
    "longitudCenso": longitudCenso,
    "descCausaNCs": descCausaNCs,
    "obsNoCenso": obsNoCenso,
  };



}

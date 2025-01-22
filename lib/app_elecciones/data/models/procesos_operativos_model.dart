part of 'models.dart';

ProcesosOperativosModel procesosOperativosModelFromJson(String str) => ProcesosOperativosModel.fromJson(json.decode(str));

String procesosOperativosModelToJson(ProcesosOperativosModel data) => json.encode(data.toJson());

class ProcesosOperativosModel {
  ProcesosOperativosModel({
   required this.procesosOperativos,
  });

  List<ProcesosOperativo> procesosOperativos;

  factory ProcesosOperativosModel.fromJson(Map<String, dynamic> json) => ProcesosOperativosModel(
    procesosOperativos: json["datos"] == null ? [] : List<ProcesosOperativo>.from(json["datos"].map((x) => ProcesosOperativo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "datos": procesosOperativos == null ? null : List<dynamic>.from(procesosOperativos.map((x) => x.toJson())),
  };
}

class ProcesosOperativo {
  ProcesosOperativo({
   required this.idDgoProcElec,
    required  this.idGenGeoSenplades,
    required  this.descProcElecc,
    required  this.fechaInici,
    required  this.fechaFin,
    required  this.tipo,

  });

  int idDgoProcElec;
  int idGenGeoSenplades;
  String descProcElecc;
  String fechaInici;
  String fechaFin;
  String tipo;


  factory ProcesosOperativo.fromJson(Map<String, dynamic> json) => ProcesosOperativo(
    idDgoProcElec: ParseModel.parseToInt(json["idDgoProcElec"]),
    idGenGeoSenplades:ParseModel.parseToInt(json["idGenGeoSenplades"]),
    descProcElecc: ParseModel.parseToString(json["descProcElecc"] ),
    fechaInici:ParseModel.parseToString( json["fechaInici"] ),
    fechaFin: ParseModel.parseToString(json["fechaFin"] ),
    tipo: ParseModel.parseToString(json["tipo"]),
  );

  Map<String, dynamic> toJson() => {
    "idDgoProcElec": idDgoProcElec == null ? null : idDgoProcElec,
    "idGenGeoSenplades": idGenGeoSenplades == null ? null : idGenGeoSenplades,
    "descProcElecc": descProcElecc == null ? null : descProcElecc,
    "fechaInici": fechaInici == null ? null : fechaInici,
    "fechaFin": fechaFin == null ? null : fechaFin,
    "tipo": tipo == null ? null : tipo,
  };
}



part of '../models.dart';

PersonalRecintoElectoralModel personalRecintoElectoralModelFromJson(String str) => PersonalRecintoElectoralModel.fromJson(json.decode(str));

String personalRecintoElectoralModelToJson(PersonalRecintoElectoralModel data) => json.encode(data.toJson());

class PersonalRecintoElectoralModel {
  PersonalRecintoElectoralModel({
    required this.personalRecintoElectoral,
  });

  List<PersonalRecintoElectoral> personalRecintoElectoral;

  factory PersonalRecintoElectoralModel.fromJson(Map<String, dynamic> json) => PersonalRecintoElectoralModel(
    personalRecintoElectoral: json["datos"] == null ? [] : List<PersonalRecintoElectoral>.from(json["datos"].map((x) => PersonalRecintoElectoral.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "personalRecintoElectoral": personalRecintoElectoral == null ? null : List<dynamic>.from(personalRecintoElectoral.map((x) => x.toJson())),
  };
}

class PersonalRecintoElectoral {
  PersonalRecintoElectoral({
    required   this.cargo,
    required  this.idDgoCreaOpReci,
    required  this.nomRecintoElec,
    required   this.recintoEstado,
    required  this.fechaIni,
    required  this.fechaFin,
    required  this.personal,
    required  this.estadoPersonal,
    required  this.idDgoPerAsigOpe
  });

  String cargo;
  int idDgoCreaOpReci;
  String nomRecintoElec;
  String recintoEstado;
  String fechaIni;
  String fechaFin;
  String personal;
  String estadoPersonal;
  int idDgoPerAsigOpe;

  factory PersonalRecintoElectoral.fromJson(Map<String, dynamic> json) => PersonalRecintoElectoral(
    cargo: ParseModel.parseToString(json["cargo"]) ,
    idDgoCreaOpReci: ParseModel.parseToInt(json["idDgoCreaOpReci"]),
    nomRecintoElec: ParseModel.parseToString(json["nomRecintoElec"]),
    recintoEstado: ParseModel.parseToString(json["recintoEstado"]) ,
    fechaIni: ParseModel.parseToString(json["fechaIni"]),
    fechaFin: ParseModel.parseToString(json["FechaFin"] ),
    personal: ParseModel.parseToString(json["personal"] ),
    estadoPersonal: ParseModel.parseToString(json["estado_personal"] ),
    idDgoPerAsigOpe: ParseModel.parseToInt(json["idDgoPerAsigOpe"]),
  );

  Map<String, dynamic> toJson() => {
    "cargo": cargo == null ? null : cargo,
    "idDgoCreaOpReci": idDgoCreaOpReci == null ? null : idDgoCreaOpReci,
    "nomRecintoElec": nomRecintoElec == null ? null : nomRecintoElec,
    "recintoEstado": recintoEstado == null ? null : recintoEstado,
    "fechaIni": fechaIni == null ? null : fechaIni,
    "FechaFin": fechaFin == null ? null : fechaFin,
    "personal": personal == null ? null : personal,
    "estado_personal": estadoPersonal == null ? null : estadoPersonal,
  };
}

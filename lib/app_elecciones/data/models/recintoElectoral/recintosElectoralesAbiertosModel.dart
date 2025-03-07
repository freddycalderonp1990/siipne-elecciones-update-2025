// To parse this JSON data, do
//
//     final recintosElectoralesAbiertosModel = recintosElectoralesAbiertosModelFromJson(jsonString);

part of '../models.dart';

RecintosElectoralesAbiertosModel recintosElectoralesAbiertosModelFromJson(
        String str) =>
    RecintosElectoralesAbiertosModel.fromJson(json.decode(str));

String recintosElectoralesAbiertosModelToJson(
        RecintosElectoralesAbiertosModel data) =>
    json.encode(data.toJson());

class RecintosElectoralesAbiertosModel {
  RecintosElectoralesAbiertosModel({
    required this.recintosElectoralesAbiertos,
  });

  RecintosElectoralesAbiertos recintosElectoralesAbiertos;

  factory RecintosElectoralesAbiertosModel.fromJson(
          Map<String, dynamic> json) =>
      RecintosElectoralesAbiertosModel(
        recintosElectoralesAbiertos: json["datos"] == null
            ? RecintosElectoralesAbiertos.empty()
            : RecintosElectoralesAbiertos.fromJson(json["datos"]),
      );

  Map<String, dynamic> toJson() => {
        "recintosElectoralesAbiertos": recintosElectoralesAbiertos == null
            ? null
            : recintosElectoralesAbiertos.toJson(),
      };
}

class RecintosElectoralesAbiertos {
  RecintosElectoralesAbiertos({
    required this.idDgoCreaOpReci,
    required this.descProcElecc,
    required this.idDgoPerAsigOpe,
    required this.idDgoProcElec,
    required this.codigoRecinto,
    required this.fechaIni,
    required this.nomRecintoElec,
    required this.idDgoReciElect,
    required this.encargado,
    required this.documento,
    required this.cargo,
    required this.descripcion,
    this.isJefe = false,
    this.isRecinto = false,
    required this.idDgoTipoEje,
  });

  int idDgoCreaOpReci;
  String descProcElecc;
  int idDgoPerAsigOpe;
  //Se agrega para capturar el proceso u operativo seleccionado
  int idDgoProcElec;
  int codigoRecinto;
  String fechaIni;
  String nomRecintoElec;
  int idDgoReciElect;
  String encargado;
  String documento;
  String cargo;
  String descripcion;
  bool isJefe;
  bool isRecinto;

  //Se agrega esta variable para al macenar el tipo de eje seleccionado
  int idDgoTipoEje;

  factory RecintosElectoralesAbiertos.empty() => RecintosElectoralesAbiertos(
      idDgoCreaOpReci: 0,
      descProcElecc: "",
      idDgoPerAsigOpe: 0,
      idDgoProcElec: 0,
      codigoRecinto: 0,
      fechaIni: "",
      nomRecintoElec: "",
      idDgoReciElect: 0,
      encargado: "",
      documento: "",
      cargo: "",
      descripcion: "",
      idDgoTipoEje: 0);
  factory RecintosElectoralesAbiertos.fromJson(Map<String, dynamic> json) {

    return    RecintosElectoralesAbiertos(
      idDgoProcElec: ParseModel.parseToInt(json["idDgoProcElec"]),
      descProcElecc: ParseModel.parseToString(json["descProcElecc"]),
      idDgoTipoEje: ParseModel.parseToInt(json["idDgoTipoEje"]),
      idDgoCreaOpReci: ParseModel.parseToInt(json["idDgoCreaOpReci"]),
      idDgoPerAsigOpe: ParseModel.parseToInt(json["idDgoPerAsigOpe"]),
      codigoRecinto: ParseModel.parseToInt(json["codigoRecinto"]),
      fechaIni: ParseModel.parseToString(json["fechaIni"]),
      nomRecintoElec: ParseModel.parseToString(json["nomRecintoElec"]),
      idDgoReciElect: ParseModel.parseToInt(json["idDgoReciElect"]),
      encargado: ParseModel.parseToString(json["encargado"]),
      documento: ParseModel.parseToString(json["documento"]),
      cargo: ParseModel.parseToString(json["cargo"]),
      descripcion: ParseModel.parseToString(json["descripcion"]),
      isJefe: json["cargo"] == null
          ? false
          : json["cargo"] == "J"
          ? true
          : false,
      isRecinto: json["isRecinto"] == null ? false : json["isRecinto"],
    );
  }


  Map<String, dynamic> toJson() => {
        "idDgoCreaOpReci": idDgoCreaOpReci == null ? null : idDgoCreaOpReci,
        "idDgoPerAsigOpe": idDgoPerAsigOpe == null ? null : idDgoPerAsigOpe,
        "codigoRecinto": codigoRecinto == null ? null : codigoRecinto,
        "fechaIni": fechaIni == null ? null : fechaIni,
        "nomRecintoElec": nomRecintoElec == null ? null : nomRecintoElec,
        "idDgoReciElect": idDgoReciElect == null ? null : idDgoReciElect,
        "encargado": encargado == null ? null : encargado,
        "documento": documento == null ? null : documento,
        "cargo": cargo == null ? null : cargo,
        "descripcion": descripcion == null ? null : descripcion,
      };
}

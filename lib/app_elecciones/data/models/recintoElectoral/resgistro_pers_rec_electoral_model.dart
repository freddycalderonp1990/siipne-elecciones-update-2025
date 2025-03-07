// To parse this JSON data, do
//
//     final resgistroPersEnRecElectoralModel = resgistroPersEnRecElectoralModelFromJson(jsonString);

part of '../models.dart';

ResgistroPersEnRecElectoralModel resgistroPersEnRecElectoralModelFromJson(
        String str) =>
    ResgistroPersEnRecElectoralModel.fromJson(json.decode(str));

String resgistroPersEnRecElectoralModelToJson(
        ResgistroPersEnRecElectoralModel data) =>
    json.encode(data.toJson());

class ResgistroPersEnRecElectoralModel {
  ResgistroPersEnRecElectoralModel({
    required this.resgistroPersEnRecElectoral,
  });

  ResgistroPersEnRecElectoral resgistroPersEnRecElectoral;

  factory ResgistroPersEnRecElectoralModel.fromJson(
          Map<String, dynamic> json) =>
      ResgistroPersEnRecElectoralModel(
        resgistroPersEnRecElectoral: json["datos"] == null
            ? ResgistroPersEnRecElectoral.empty()
            : ResgistroPersEnRecElectoral.fromJson(json["datos"]),
      );

  Map<String, dynamic> toJson() => {
        "resgistroPersEnRecElectoral": resgistroPersEnRecElectoral == null
            ? null
            : resgistroPersEnRecElectoral.toJson(),
      };
}

class ResgistroPersEnRecElectoral {
  ResgistroPersEnRecElectoral({
    required this.idDgoPerAsigOpe,
    required this.codigoRecinto,
    required this.fechaIni,
    required this.nomRecintoElec,
    required this.encargado,
    required this.documento,
  });

  int idDgoPerAsigOpe;
  int codigoRecinto;
  String fechaIni;
  String nomRecintoElec;
  String encargado;
  String documento;

  factory ResgistroPersEnRecElectoral.empty() => ResgistroPersEnRecElectoral(
      idDgoPerAsigOpe: 0,
      codigoRecinto: 0,
      fechaIni: "",
      nomRecintoElec: "",
      encargado: "",
      documento: "");
  factory ResgistroPersEnRecElectoral.fromJson(Map<String, dynamic> json) {

    print("ResgistroPersEnRecElectoral ${json["codigoRecinto"]}");

     return ResgistroPersEnRecElectoral(
      idDgoPerAsigOpe: ParseModel.parseToInt(json["idDgoPerAsigOpe"]),
      codigoRecinto: ParseModel.parseToInt(json["codigoRecinto"]),
      fechaIni: ParseModel.parseToString(json["fechaIni"]),
      nomRecintoElec: ParseModel.parseToString(json["nomRecintoElec"]),
      encargado: ParseModel.parseToString(json["encargado"]),
      documento: ParseModel.parseToString(json["documento"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "idDgoPerAsigOpe": idDgoPerAsigOpe == null ? null : idDgoPerAsigOpe,
        "codigoRecinto": codigoRecinto == null ? null : codigoRecinto,
        "fechaIni": fechaIni == null ? null : fechaIni,
        "nomRecintoElec": nomRecintoElec == null ? null : nomRecintoElec,
        "encargado": encargado == null ? null : encargado,
        "documento": documento == null ? null : documento,
      };
}

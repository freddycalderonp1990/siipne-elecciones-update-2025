// To parse this JSON data, do
//
//     final datosRecintoElectoral = datosRecintoElectoralFromJson(jsonString);

part of '../models.dart';

DatosRecintoElectoral datosRecintoElectoralFromJson(String str) =>
    DatosRecintoElectoral.fromJson(json.decode(str));

String datosRecintoElectoralToJson(DatosRecintoElectoral data) =>
    json.encode(data.toJson());

class DatosRecintoElectoral {
  DatosRecintoElectoral({
    required this.datosRecintoElectoral,
  });

  DatosRecintoElectoralClass datosRecintoElectoral;

  factory DatosRecintoElectoral.fromJson(Map<String, dynamic> json) =>
      DatosRecintoElectoral(
        datosRecintoElectoral: json["datos"] == null
            ? DatosRecintoElectoralClass.empty()
            : DatosRecintoElectoralClass.fromJson(json["datos"]),
      );

  Map<String, dynamic> toJson() => {
        "datosRecintoElectoral": datosRecintoElectoral == null
            ? null
            : datosRecintoElectoral.toJson(),
      };
}

class DatosRecintoElectoralClass {
  DatosRecintoElectoralClass({
    required this.idDgoReciElect,
    required this.nomRecintoElec,
    required this.idDgoTipoEje,
    required this.encargado,
    required this.documento,
    required this.sexoPerson,
    required this.idDgoProcElec
  });

  int idDgoReciElect;
  int idDgoProcElec;
  String nomRecintoElec;
  int idDgoTipoEje;
  String encargado;
  String documento;
  String sexoPerson;

  factory DatosRecintoElectoralClass.empty() => DatosRecintoElectoralClass(
    idDgoProcElec: 0,
      idDgoReciElect: 0,
      nomRecintoElec: "",
      idDgoTipoEje: 0,
      encargado: "",
      documento: "",
      sexoPerson: "");
  factory DatosRecintoElectoralClass.fromJson(Map<String, dynamic> json) =>
      DatosRecintoElectoralClass(
        idDgoProcElec: ParseModel.parseToInt(json["idDgoProcElec"]),
        idDgoReciElect: ParseModel.parseToInt(json["idDgoReciElect"]),
        nomRecintoElec: ParseModel.parseToString(json["nomRecintoElec"]),
        idDgoTipoEje: ParseModel.parseToInt(json["idDgoTipoEje"]),
        encargado: ParseModel.parseToString(json["encargado"]),
        documento: ParseModel.parseToString(json["documento"]),
        sexoPerson: ParseModel.parseToString(json["sexoPerson"]),
      );

  Map<String, dynamic> toJson() => {
        "nomRecintoElec": nomRecintoElec == null ? null : nomRecintoElec,
        "encargado": encargado == null ? null : encargado,
        "documento": documento == null ? null : documento,
        "sexoPerson": sexoPerson == null ? null : sexoPerson,
      };
}

part of 'models.dart';

DatosPersModel datosPersModelFromJson(String str) =>
    DatosPersModel.fromJson(json.decode(str));

String datosPersModelToJson(DatosPersModel data) => json.encode(data.toJson());

class DatosPersModel {
  DatosPersModel({
    required this.datosPers,
  });

  List<DatosPer> datosPers;

  factory DatosPersModel.fromJson(Map<String, dynamic> json) => DatosPersModel(
    datosPers: json["datos"] == null
        ? []
        : List<DatosPer>.from(
        json["datos"].map((x) => DatosPer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "dataPersona": datosPers == null
        ? null
        : List<dynamic>.from(datosPers.map((x) => x.toJson())),
  };
}

class DatosPer {
  DatosPer(
      {required this.idGenPersona,
        required this.idDgpGrado,
        required this.siglas,
        required this.apenom,
        this.poliRegistrado = false,
        required this.documento});

  int idGenPersona;
  int idDgpGrado;
  String siglas;
  String apenom;
  String documento;
  bool poliRegistrado;
  factory DatosPer.empty() =>
      DatosPer(
        idDgpGrado: 0,
          idGenPersona: 0, siglas: "", apenom: "", documento: "");
  factory DatosPer.fromJson(Map<String, dynamic> json) => DatosPer(
    idDgpGrado:  ParseModel.parseToInt(json["idDgpGrado"]),
    idGenPersona: ParseModel.parseToInt(json["idGenPersona"]),
    siglas: ParseModel.parseToString(json["siglas"]),
    documento: ParseModel.parseToString(json["documento"]),
    apenom: ParseModel.parseToString(json["apenom"]),
    poliRegistrado:
    json["poliRegistrado"] == null ? false : json["poliRegistrado"],
  );

  Map<String, dynamic> toJson() => {
    "idGenPersona": idGenPersona == null ? null : idGenPersona,
    "siglas": siglas == null ? null : siglas,
    "documento": documento == null ? null : documento,
    "apenom": apenom == null ? null : apenom,
    "poliRegistrado": poliRegistrado == null ? null : poliRegistrado,
  };
}
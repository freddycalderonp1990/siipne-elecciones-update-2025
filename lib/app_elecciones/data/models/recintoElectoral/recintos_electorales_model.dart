// To parse this JSON data, do
//
//     final RecintosElectoralsModel = RecintosElectoralsModelFromJson(jsonString);

part of '../models.dart';

RecintosElectoralsModel RecintosElectoralsModelFromJson(String str) =>
    RecintosElectoralsModel.fromJson(json.decode(str));

String RecintosElectoralsModelToJson(RecintosElectoralsModel data) =>
    json.encode(data.toJson());

class RecintosElectoralsModel {
  RecintosElectoralsModel({
 required   this.RecintosElectorals,
  });

  List<RecintosElectoral> RecintosElectorals;

  factory RecintosElectoralsModel.fromJson(Map<String, dynamic> json) =>
      RecintosElectoralsModel(
        RecintosElectorals: json["datos"] == null
            ? []
            : List<RecintosElectoral>.from(
                json["datos"].map((x) => RecintosElectoral.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "RecintosElectorals": RecintosElectorals == null
            ? null
            : List<dynamic>.from(RecintosElectorals.map((x) => x.toJson())),
      };
}



class RecintosElectoral {
  RecintosElectoral({
    this.nomRecintoElecOnly='',



    this.idDgoReciElect = 0,


    this.codRecintoElec = '',
    this.nomRecintoElec = '',
    this.direcRecintoElec = '',
    this.latitud = 0,
    this.longitud = 0,


    this.idDgoTipoEje = 0,

    this.distance = '0',
    this.validado=false
  });



  int idDgoReciElect;


  String codRecintoElec;
  String nomRecintoElec;
  String nomRecintoElecOnly;
  String direcRecintoElec;
  double latitud;
  double longitud;

  int idDgoTipoEje;

  String distance;
  bool validado;

  factory RecintosElectoral.fromJson(Map<String, dynamic> json) {
    String nomRecinto =
        json["nomRecintoElec"] == null ? null : json["nomRecintoElec"];

    String dist = ParseModel.parseToString(json["distance"]) == null ? '' : "\nDistancia:" + ParseModel.parseToString(json["distance"])+ "m";

    print("dis=${ParseModel.parseToInt(json["distance"])}");
    nomRecinto = nomRecinto + dist;

    return RecintosElectoral(

      idDgoReciElect: ParseModel.parseToInt(json["idDgoReciElect"]),

      codRecintoElec: ParseModel.parseToString(json["codRecintoElec"]),
      nomRecintoElec: nomRecinto,
      nomRecintoElecOnly:       ParseModel.parseToString(json["nomRecintoElec"]),
      direcRecintoElec: ParseModel.parseToString(json["direcRecintoElec"] ),
      latitud: ParseModel.parseToDouble(json["latitud"] ),
      longitud: ParseModel.parseToDouble(json["longitud"] ),

      idDgoTipoEje:  ParseModel.parseToInt(json["idDgoTipoEje"]),
      distance:  ParseModel.parseToString(json["distance"]),
      validado: ParseModel.parseToBool(json["estadoRegistro"],valueCompareTrue: "VALIDADO")
    );
  }

  Map<String, dynamic> toJson() => {

        "idDgoReciElect": idDgoReciElect == null ? null : idDgoReciElect,

        "codRecintoElec": codRecintoElec == null ? null : codRecintoElec,
        "nomRecintoElec": nomRecintoElec == null ? null : nomRecintoElec,
        "direcRecintoElec": direcRecintoElec == null ? null : direcRecintoElec,
        "latitud": latitud == null ? null : latitud,
        "longitud": longitud == null ? null : longitud,
        "idDgoTipoEje": idDgoTipoEje == null ? null : idDgoTipoEje,

        "distance": distance == null ? null : distance,
      };
}

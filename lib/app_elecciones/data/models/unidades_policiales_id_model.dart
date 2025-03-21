part of 'models.dart';

UnidadesPolicialesId unidadesPolicialesIdFromJson(String str) =>
    UnidadesPolicialesId.fromJson(json.decode(str));

String unidadesPolicialesIdToJson(UnidadesPolicialesId data) =>
    json.encode(data.toJson());

class UnidadesPolicialesId {
  UnidadesPolicialesIdClass unidadesPolicialesId;

  UnidadesPolicialesId({
    required this.unidadesPolicialesId,
  });

  factory UnidadesPolicialesId.fromJson(Map<String, dynamic> json) =>
      UnidadesPolicialesId(
        unidadesPolicialesId:
            UnidadesPolicialesIdClass.fromJson(json["unidadesPolicialesId"]),
      );

  Map<String, dynamic> toJson() => {
        "unidadesPolicialesId": unidadesPolicialesId.toJson(),
      };
}

class UnidadesPolicialesIdClass {
  int codeError;
  String msj;
  List<DatosUnidadesId> datosUnidadesId;

  UnidadesPolicialesIdClass({
    required this.codeError,
    required this.msj,
    required this.datosUnidadesId,
  });

  factory UnidadesPolicialesIdClass.fromJson(Map<String, dynamic> json) =>
      UnidadesPolicialesIdClass(
        codeError: json["codeError"],
        msj: json["msj"],
        datosUnidadesId: List<DatosUnidadesId>.from(
            json["datos"].map((x) => DatosUnidadesId.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "codeError": codeError,
        "msj": msj,
        "datos": List<dynamic>.from(datosUnidadesId.map((x) => x.toJson())),
      };
}

class DatosUnidadesId {
  int idDgoTipoEje;
  int dgoIdDgoTipoEje;
  String ejeHijo2;
  String ejeHijo3;
  String ejeHijo4;
  String ejePadre;

  DatosUnidadesId({
    required this.idDgoTipoEje,
    required this.dgoIdDgoTipoEje,
    required this.ejeHijo2,
    required this.ejeHijo3,
    required this.ejeHijo4,
    required this.ejePadre,
  });

  factory DatosUnidadesId.fromJson(Map<String, dynamic> json) =>
      DatosUnidadesId(
        idDgoTipoEje: ParseModel.parseToInt(json["idDgoTipoEje"]),
        dgoIdDgoTipoEje: ParseModel.parseToInt(json["dgo_idDgoTipoEje"]),
        ejeHijo2: ParseModel.parseToString(json["ejeHijo2"]),
        ejeHijo3: ParseModel.parseToString(json["ejeHijo3"]),
        ejeHijo4: ParseModel.parseToString(json["ejeHijo4"]),
        ejePadre: ParseModel.parseToString(json["ejePadre"]),
      );

  factory DatosUnidadesId.empty() => DatosUnidadesId(
      idDgoTipoEje: 0,
      dgoIdDgoTipoEje: 0,
      ejeHijo2: "",
      ejeHijo3: "",
      ejeHijo4: "",
      ejePadre: "");

  Map<String, dynamic> toJson() => {
        "idDgoTipoEje": idDgoTipoEje,
        "dgo_idDgoTipoEje": dgoIdDgoTipoEje,
        "ejeHijo2": ejeHijo2,
        "ejeHijo3": ejeHijo3,
        "ejeHijo4": ejeHijo4,
        "ejePadre": ejePadre,
      };
}

part of 'models.dart';

UnidadesPolicialesModel unidadesPolicialesModelFromJson(String str) =>
    UnidadesPolicialesModel.fromJson(json.decode(str));

String unidadesPolicialesModelToJson(UnidadesPolicialesModel data) =>
    json.encode(data.toJson());

class UnidadesPolicialesModel {
  UnidadesPolicialesModel({
    required this.unidadesPoliciales,
  });

  List<UnidadesPoliciale> unidadesPoliciales;

  factory UnidadesPolicialesModel.fromJson(Map<String, dynamic> json) =>
      UnidadesPolicialesModel(
        unidadesPoliciales: json["datos"] == null
            ? []
            : List<UnidadesPoliciale>.from(
                json["datos"].map((x) => UnidadesPoliciale.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "datos": unidadesPoliciales == null
            ? null
            : List<dynamic>.from(unidadesPoliciales.map((x) => x.toJson())),
      };
}

class UnidadesPoliciale {
  UnidadesPoliciale({
    required this.idDgoTipoEje,
    required this.dgoIdDgoTipoEje,
    required this.descripcion,
  });

  int idDgoTipoEje;
  int dgoIdDgoTipoEje;
  String descripcion;

  factory UnidadesPoliciale.empty()=>UnidadesPoliciale(idDgoTipoEje: 0,dgoIdDgoTipoEje: 0,descripcion: "");

  factory UnidadesPoliciale.fromJson(Map<String, dynamic> json) =>
      UnidadesPoliciale(
        idDgoTipoEje: ParseModel.parseToInt(json["idDgoTipoEje"]),
        dgoIdDgoTipoEje: ParseModel.parseToInt(json["dgo_idDgoTipoEje"]),
        descripcion: ParseModel.parseToString(json["descripcion"]),
      );

  Map<String, dynamic> toJson() => {
        "idDgoTipoEje": idDgoTipoEje == null ? null : idDgoTipoEje,
        "dgo_idDgoTipoEje": dgoIdDgoTipoEje == null ? null : dgoIdDgoTipoEje,
        "descripcion": descripcion == null ? null : descripcion,
      };
}

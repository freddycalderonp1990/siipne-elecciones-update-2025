part of 'models.dart';

ConveniosModel conveniosModelFromJson(String str) =>
    ConveniosModel.fromJson(json.decode(str));

String conveniosModelToJson(ConveniosModel data) => json.encode(data.toJson());

class ConveniosModel {
  final int statusCode;
  final String message;
  final List<DataConvenio> dataConvenio;

  ConveniosModel({
    required this.statusCode,
    required this.message,
    required this.dataConvenio,
  });

  factory ConveniosModel.fromJson(Map<String, dynamic> json) => ConveniosModel(
        statusCode: json["status_code"],
        message: json["message"],
        dataConvenio: List<DataConvenio>.from(
            json["data"].map((x) => DataConvenio.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": List<dynamic>.from(dataConvenio.map((x) => x.toJson())),
      };
}

class DataConvenio {
  final int idDbsItemsConvenios;
  final String titulo;
  final List<String> item;

  DataConvenio({
    required this.idDbsItemsConvenios,
    required this.titulo,
    required this.item,
  });

  factory DataConvenio.fromJson(Map<String, dynamic> json) => DataConvenio(
        idDbsItemsConvenios: ParseModel.parseToInt(json["idDbsItemsConvenios"]),
        titulo: ParseModel.parseToString(json["titulo"]),
        item: List<String>.from(
            json["item"].map((x) => ParseModel.parseToString(x))),
      );

  Map<String, dynamic> toJson() => {
        "idDbsItemsConvenios": idDbsItemsConvenios,
        "titulo": titulo,
        "item": List<dynamic>.from(item.map((x) => x)),
      };
}

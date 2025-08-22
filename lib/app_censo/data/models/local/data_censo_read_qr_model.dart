import 'dart:convert';
import 'package:api_provider/core/utils/parse_model.dart';

DataCensoReadQrModel dataReadQrModelFromJson(String str) =>
    DataCensoReadQrModel.fromJson(json.decode(str));

String dataReadQrModelToJson(DataCensoReadQrModel data) =>
    json.encode(data.toJson());

class DataCensoReadQrModel {
  final int idProceso;
  final int idDgpRecinto;
  final double latitudMesa;
  final double longitudMesa;
  final int idGenPersonaCensado;
  final int idGenPersonaCensista;
  final String fecha;

  DataCensoReadQrModel({
    required this.idProceso,
    required this.idDgpRecinto,
    required this.latitudMesa,
    required this.longitudMesa,
    required this.idGenPersonaCensado,
    required this.idGenPersonaCensista,
    required this.fecha,
  });

  factory DataCensoReadQrModel.empty() => DataCensoReadQrModel(
    idProceso: 0,
    idDgpRecinto: 0,
    latitudMesa: 0,
    longitudMesa: 0,
    idGenPersonaCensado: 0,
    idGenPersonaCensista: 0,
    fecha: "",
  );

  /// Recibe una **lista** en lugar de un map
  factory DataCensoReadQrModel.fromJson(List<dynamic> json) {
    return DataCensoReadQrModel(
      idProceso: ParseModel.parseToInt(json[0]),
      idDgpRecinto: ParseModel.parseToInt(json[1]),
      latitudMesa: ParseModel.parseToDouble(json[2]),
      longitudMesa: ParseModel.parseToDouble(json[3]),
      idGenPersonaCensado: ParseModel.parseToInt(json[4]),
      idGenPersonaCensista: ParseModel.parseToInt(json[5]),
      fecha: ParseModel.parseToString(json[6]),
    );
  }

  /// Si quieres exportar como lista igual que llega
  List<dynamic> toJson() => [
    idProceso,
    idDgpRecinto,
    latitudMesa,
    longitudMesa,
    idGenPersonaCensado,
    idGenPersonaCensista,
    fecha,
  ];
}

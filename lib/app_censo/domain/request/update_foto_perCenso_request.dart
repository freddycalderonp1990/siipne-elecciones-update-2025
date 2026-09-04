part of 'request_censo.dart';

class UpdateFotoPerCensoRequest {

  final int idDgpPerCenso;
  final String nameFotografia;
  final double latitud;
  final double longitud;
  final String ip;
  final int idUsuarioCensista;
  final int idUsuarioCensado;
  final String gradoCensista;

  UpdateFotoPerCensoRequest( {

    required this.idDgpPerCenso,
    required this.idUsuarioCensista,
    required this.nameFotografia,
    required this.latitud,
    required this.longitud,
    required this.ip,
    required this.gradoCensista,
    required this.idUsuarioCensado,
  });

  Map<String, dynamic> toJson() {
    return {
      "idDgpPerCenso": idDgpPerCenso,
      "nameFotografia": nameFotografia,
      "latitud": latitud,
      "longitud": longitud,
      "ip": ip,
      "idUsuarioCensista": idUsuarioCensista,
      "gradoCensista": gradoCensista,
      "idUsuarioCensado": idUsuarioCensado,
    };
  }
}

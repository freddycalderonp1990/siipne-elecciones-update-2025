part of 'request_censo.dart';

class UpdateFotoPerCensoRequest {

  final int idDgpPerCenso;
  final String nameFotografia;
  final double latitud;
  final double longitud;
  final String ip;
  final int idGenUsuario;

  UpdateFotoPerCensoRequest({

    required this.idDgpPerCenso,
    required this.idGenUsuario,
    required this.nameFotografia,
    required this.latitud,
    required this.longitud,
    required this.ip,
  });

  Map<String, dynamic> toJson() {
    return {
      "idDgpPerCenso": idDgpPerCenso,
      "nameFotografia": nameFotografia,
      "latitud": latitud,
      "longitud": longitud,
      "ip": ip,
      "idGenUsuario": idGenUsuario,
    };
  }
}

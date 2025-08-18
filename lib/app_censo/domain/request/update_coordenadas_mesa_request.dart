part of 'request_censo.dart';

class UpdateCoordenadasMesaRequest {

  final int idDgpMesa;

  final double latitud;
  final double longitud;
  final String ip;
  final int usuario;


  UpdateCoordenadasMesaRequest({

    required this.idDgpMesa,
    required this.usuario,
    required this.latitud,
    required this.longitud,
    required this.ip,
  });

  Map<String, dynamic> toJson() {
    return {
      "idDgpMesa": idDgpMesa,
      "latitud": latitud,
      "longitud": longitud,
      "ip": ip,
      "usuario": usuario,
    };
  }
}

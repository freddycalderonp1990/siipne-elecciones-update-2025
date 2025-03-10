part of 'request.dart';

class RecintoCercanosRequest {
  final double latitud;
  final double longitud;
  final int idDgoProcElec;
  final int idDgoTipoEje;

  RecintoCercanosRequest({
    required this.latitud,
    required this.longitud,
    required this.idDgoProcElec,
    required this.idDgoTipoEje,
  });

  /// Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      "latitud": latitud,
      "longitud": longitud,
      "idDgoProcElec": idDgoProcElec,
      "idDgoTipoEje": idDgoTipoEje,
    };
  }
}

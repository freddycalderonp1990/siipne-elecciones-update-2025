part of 'request.dart';

class GetNovedadesRegistradasdRequest {
  final int idDgoCreaOpReci;
  final int idDgoProcElec;
  final int idDgoReciElect;

  GetNovedadesRegistradasdRequest({
    required this.idDgoCreaOpReci,
    required this.idDgoProcElec,
    required this.idDgoReciElect,
  });

  /// Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      "idDgoCreaOpReci": idDgoCreaOpReci,
      "idDgoProcElec": idDgoProcElec,
      "idDgoReciElect": idDgoReciElect,
    };
  }
}

part of 'request.dart';

class GetNovedadesHijasRequest {
  final int idDgoTipoEje;
  final int idNovedadesPadre;
  final int idDgoProcElec;
  final int idDgoReciElect;

  GetNovedadesHijasRequest({
    required this.idDgoTipoEje,
    required this.idNovedadesPadre,
    required this.idDgoProcElec,
    required this.idDgoReciElect,
  });

  /// Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      "idDgoTipoEje": idDgoTipoEje,
      "idNovedadesPadre": idNovedadesPadre,
      "idDgoProcElec": idDgoProcElec,
      "idDgoReciElect": idDgoReciElect,
    };
  }
}

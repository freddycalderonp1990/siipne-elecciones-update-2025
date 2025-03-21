part of 'request.dart';

class GetNovedadesPadresRequest {
  final int idDgoTipoEje;

  final int idDgoProcElec;
  final int idDgoReciElect;

  GetNovedadesPadresRequest({
    required this.idDgoTipoEje,
    required this.idDgoProcElec,
    required this.idDgoReciElect,
  });

  /// Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      "idDgoTipoEje": idDgoTipoEje,
      "idDgoProcElec": idDgoProcElec,
      "idDgoReciElect": idDgoReciElect,
    };
  }
}

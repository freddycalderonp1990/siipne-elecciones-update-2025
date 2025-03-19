part of 'request.dart';

/// Clase para la solicitud de finalización de recinto
class FinalizarRecintoRequest {
  final int usuario;
  final String ip;
  final int idDgoCreaOpReci;
  final int idDgoProcElec;
  final int idDgoReciElect;
  final int idDgoPerAsigOpe;
  final int idDgoTipoEje;

  FinalizarRecintoRequest({
    required this.usuario,
    required this.ip,
    required this.idDgoCreaOpReci,
    required this.idDgoProcElec,
    required this.idDgoReciElect,
    required this.idDgoPerAsigOpe,
    required this.idDgoTipoEje,
  });

  /// Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      "usuario": usuario,
      "ip": ip,
      "idDgoCreaOpReci": idDgoCreaOpReci,
      "idDgoProcElec": idDgoProcElec,
      "idDgoReciElect": idDgoReciElect,
      "idDgoPerAsigOpe": idDgoPerAsigOpe,
      "idDgoTipoEje": idDgoTipoEje,
    };
  }
}

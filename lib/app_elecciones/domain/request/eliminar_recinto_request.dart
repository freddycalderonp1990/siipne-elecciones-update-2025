part of 'request.dart';

class EliminarRecintoRequest {
  final int usuario;
  final String ip;
  final int idDgoCreaOpReci;
  final int idDgoProcElec;
  final int idDgoReciElect;

  EliminarRecintoRequest({
    required this.usuario,
    required this.ip,
    required this.idDgoCreaOpReci,
    required this.idDgoProcElec,
    required this.idDgoReciElect,
  });

  /// Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      "usuario": usuario,
      "ip": ip,
      "idDgoCreaOpReci": idDgoCreaOpReci,
      "idDgoProcElec": idDgoProcElec,
      "idDgoReciElect": idDgoReciElect,
    };
  }
}

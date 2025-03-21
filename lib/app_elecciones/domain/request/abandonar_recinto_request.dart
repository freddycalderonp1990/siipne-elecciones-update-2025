part of 'request.dart';

class AbandonarRecintoRequest {
  final int idDgoPerAsigOpe;
  final int usuario;
  final double latitud;
  final double longitud;
  final int idDgoProcElec;
  final int idDgoReciElect;
  final int idGenPersona;
  final String ip;

  AbandonarRecintoRequest( {
    required this.idDgoPerAsigOpe,
    required this.usuario,
    required this.latitud,
    required this.longitud,
    required this.idDgoProcElec,
    required this.idDgoReciElect,
    required this.idGenPersona,
    required this.ip,
  });

  /// Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      "idDgoPerAsigOpe": idDgoPerAsigOpe,
      "usuario": usuario,
      "idGenPersona": idGenPersona,
      "latitud": latitud,
      "longitud": longitud,
      "idDgoProcElec": idDgoProcElec,
      "idDgoReciElect": idDgoReciElect,
      "ip": ip,
    };
  }
}

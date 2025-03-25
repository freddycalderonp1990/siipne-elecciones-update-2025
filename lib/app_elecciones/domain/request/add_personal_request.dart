part of 'request.dart';

class AddPersonalRequest {
  final int idDgoCreaOpReci;
  final int idGenPersona;
  final int usuario;
  final double latitud;
  final double longitud;
  final int idDgoReciElect;
  final int idDgoTipoEje;
  final int idDgoProcElec;
  final int idDgpGrado;
  final String ip;

  AddPersonalRequest({
    required this.idDgoCreaOpReci,
    required this.idGenPersona,
    required this.usuario,
    required this.latitud,
    required this.longitud,
    required this.idDgoReciElect,
    required this.idDgoTipoEje,
    required this.idDgoProcElec,
    required this.ip,
    required this.idDgpGrado
  });

  /// Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      "idDgoCreaOpReci": idDgoCreaOpReci,
      "idGenPersona": idGenPersona,
      "usuario": usuario,
      "latitud": latitud,
      "longitud": longitud,
      "idDgoReciElect": idDgoReciElect,
      "idDgoTipoEje": idDgoTipoEje,
      "idDgoProcElec": idDgoProcElec,
      "ip": ip,
      "idDgpGrado": idDgpGrado,

    };
  }
}

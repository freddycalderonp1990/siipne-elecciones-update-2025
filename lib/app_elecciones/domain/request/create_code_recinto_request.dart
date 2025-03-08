part of 'request.dart';

class CreateCodeRecintoRequest {
  final int usuario;
  final int idGenPersona;
  final int idDgoReciElect;
  final double latitud;
  final double longitud;
  final int idDgoProcElec;
  final int idDgoReciUnidadPolicial;
  final String telefono;
  final String ip;
  final int idDgoTipoEje;

  CreateCodeRecintoRequest({
    required this.usuario,
    required this.idGenPersona,
    required this.idDgoReciElect,
    required this.latitud,
    required this.longitud,
    required this.idDgoProcElec,
    required this.idDgoReciUnidadPolicial,
    required this.telefono,
    required this.ip,
    required this.idDgoTipoEje,
  });

  /// Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      "usuario": usuario,
      "idGenPersona": idGenPersona,
      "idDgoReciElect": idDgoReciElect,
      "latitud": latitud,
      "longitud": longitud,
      "idDgoProcElec": idDgoProcElec,
      "idDgoReciUnidadPolicial": idDgoReciUnidadPolicial,
      "telefono": telefono,
      "ip": ip,
      "idDgoTipoEje": idDgoTipoEje,
    };
  }
}

part of 'request.dart';

class AddNovedadesRequest {
  final int idDgoNovedadesElect;
  final int idDgoPerAsigOpe;
  final String observacion;
  final int usuario;
  final double latitud;
  final double longitud;
  final String? nombreDetenido;
  final int? idGenPersonaD;
  final String cedula;
  final int idDgoProcElec;
  final int idDgoReciElect;
  final String imagen;
  final String ip;

  AddNovedadesRequest({
    required this.idDgoNovedadesElect,
    required this.idDgoPerAsigOpe,
    required this.observacion,
    required this.usuario,
    required this.latitud,
    required this.longitud,
    this.nombreDetenido,
    this.idGenPersonaD,
    this.cedula = 'null',
    required this.idDgoProcElec,
    required this.idDgoReciElect,
    this.imagen = "No Imagen",
    required this.ip,
  });


  /// Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      "idDgoNovedadesElect": idDgoNovedadesElect,
      "idDgoPerAsigOpe": idDgoPerAsigOpe,
      "observacion": observacion,
      "usuario": usuario,
      "latitud": latitud,
      "longitud": longitud,
      "nombreDetenido": nombreDetenido,
      "idGenPersonaD": idGenPersonaD,
      "cedula": cedula,
      "idDgoProcElec": idDgoProcElec,
      "idDgoReciElect": idDgoReciElect,
      "imagen": imagen,
      "ip": ip,
    };
  }
}

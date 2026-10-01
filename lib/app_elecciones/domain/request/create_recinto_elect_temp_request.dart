part of 'request.dart';

class CreateRecintoElectTempRequest {
  final String nomRecintoElec;
  final String direcRecintoElec;
  final double latitud;
  final double longitud;
  final String fotografia;
  final int usuario;
  final String ip;

  CreateRecintoElectTempRequest({
    required this.nomRecintoElec,
    required this.direcRecintoElec,
    required this.latitud,
    required this.longitud,
    required this.fotografia,
    required this.usuario,
    required this.ip,
  });

  /// Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      "nomRecintoElec": nomRecintoElec,
      "direcRecintoElec": direcRecintoElec,
      "latitud": latitud,
      "longitud": longitud,
      "fotografia": fotografia,
      "usuario": usuario,
      "ip": ip,
    };
  }
}

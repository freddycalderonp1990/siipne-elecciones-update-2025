part of 'request.dart';

class GetRecintoElectTempByUserRequest {
  final double latitud;
  final double longitud;
  final int usuario;

  GetRecintoElectTempByUserRequest({
    required this.latitud,
    required this.longitud,
    required this.usuario,
  });

  /// Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
    return {"latitud": latitud, "longitud": longitud, "usuario": usuario};
  }
}

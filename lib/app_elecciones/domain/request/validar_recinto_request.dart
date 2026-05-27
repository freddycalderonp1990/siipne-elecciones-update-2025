part of 'request.dart';

class ValidarRecintoRequest {
  final int idDgoComisios;
  final double latitudValidacion;
  final double longitudValidacion;
  final String telefono;

  final int usuario;
  final String ip;




ValidarRecintoRequest(
    {
      required this.latitudValidacion,
      required this.longitudValidacion,
      required this.idDgoComisios,
      required this.telefono,

      required this.usuario,
      required this.ip,

  });

  /// Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      "idDgoComisios": idDgoComisios,
      "latitudValidacion": latitudValidacion,
      "longitudValidacion": longitudValidacion,
      "telefono": telefono,
      "usuario": usuario,
      "ip": ip

    };
  }
}

part of 'request.dart';

class ValidarRecintoRequest {
  final int idDgoComisios;
  final double latitudValidacion;
  final double longitudValidacion;

  final int usuario;
  final String ip;




ValidarRecintoRequest(
    {
      required this.latitudValidacion,
      required this.longitudValidacion,
      required this.idDgoComisios,required this.usuario,required this.ip,

  });

  /// Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      "idDgoComisios": idDgoComisios,
      "latitudValidacion": latitudValidacion,
      "longitudValidacion": longitudValidacion,
      "usuario": usuario,
      "ip": ip

    };
  }
}

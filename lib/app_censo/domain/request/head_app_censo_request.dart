part of 'request_censo.dart';



class HeadAppCensoRequest {
  final String? modulo;
  final String uri;
  final Map<String, dynamic> bodyRequest;

  HeadAppCensoRequest({
    this.modulo,
    required this.uri,
    required this.bodyRequest,
  });

  /// Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> body = {
      "modulo": modulo ?? CensoApiConstantes.MODULO, // Usa ?? en lugar de operador ternario
      "uri": uri,
      ...bodyRequest, // Agrega los valores del bodyRequest al mapa usando spread operator
    };

    return body;
  }
}

part of 'request_censo.dart';

class GetMesasByIdusuarioRequest {
  final int idGenUsuario;



  GetMesasByIdusuarioRequest({
    required this.idGenUsuario,

  });

  /// Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      "idGenUsuario": idGenUsuario,
    };
  }
}

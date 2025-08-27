part of 'request_censo.dart';

class GetDatosPersonaCensoRequest {
  final int idDgpPerCenso;
  final int idGenUsuarioCensista;
  final bool isCensoTodos;


  GetDatosPersonaCensoRequest({
    required this.idDgpPerCenso,
    required this.idGenUsuarioCensista,
    required this.isCensoTodos
  });

  /// Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      "idDgpPerCenso": idDgpPerCenso,
      "idGenUsuarioCensista": idGenUsuarioCensista,
      "isCensoTodos": isCensoTodos,
    };
  }
}

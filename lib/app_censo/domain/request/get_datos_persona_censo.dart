part of 'request_censo.dart';

class GetDatosPersonaCensoRequest {
  final int idDgpPerCenso;
  final int idGenUsuarioCensista;


  GetDatosPersonaCensoRequest({
    required this.idDgpPerCenso,
    required this.idGenUsuarioCensista,

  });

  /// Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      "idDgpPerCenso": idDgpPerCenso,
      "idGenUsuarioCensista": idGenUsuarioCensista,
    };
  }
}

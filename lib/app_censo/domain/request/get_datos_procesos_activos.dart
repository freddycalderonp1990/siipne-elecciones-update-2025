part of 'request_censo.dart';

class GetDatosProcesosActivosRequest {
  final int idGenPersonaCensado;



  GetDatosProcesosActivosRequest({
    required this.idGenPersonaCensado,

  });

  /// Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      "idGenPersonaCensado": idGenPersonaCensado,
    };
  }
}

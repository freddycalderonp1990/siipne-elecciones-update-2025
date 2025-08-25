part of 'request_censo.dart';

class DownloadPdfCensoRequest {
  final int idPerCensista;
  final int idPerCensado;

  DownloadPdfCensoRequest({
    required this.idPerCensista,
    required this.idPerCensado,
  });

  /// Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
    return {"idPerCensista": idPerCensista, "idPerCensado": idPerCensado};
  }
}

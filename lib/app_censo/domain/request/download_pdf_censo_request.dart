part of 'request_censo.dart';

class DownloadPdfCensoRequest {
  final int idDpgPerCenso;
  final int idPerCensado;

  DownloadPdfCensoRequest({
    required this.idDpgPerCenso,
    required this.idPerCensado,
  });

  /// Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
    return {"idDpgPerCenso": idDpgPerCenso, "idPerCensado": idPerCensado};
  }
}

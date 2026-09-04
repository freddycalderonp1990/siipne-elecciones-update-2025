part of 'censo_use_cases.dart';

class DownloadPdfCensoUseCase {
  final CensoRepository repository;

  DownloadPdfCensoUseCase({required this.repository});

  Future<String> call({required DownloadPdfCensoRequest request}) {
    return repository.downloadPdfCenso(request: request);
  }
}

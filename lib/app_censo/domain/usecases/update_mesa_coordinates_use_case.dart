part of 'censo_use_cases.dart';

class UpdateMesaCoordinatesUseCase {
  final CensoRepository repository;

  UpdateMesaCoordinatesUseCase({required this.repository});

  Future<bool> call({required UpdateCoordenadasMesaRequest request}) {
    return repository.updateCoordenadasMesa(request: request);
  }
}

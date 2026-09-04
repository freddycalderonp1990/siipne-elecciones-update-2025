
part of 'censo_use_cases.dart';

class FetchCensusPersonDataUseCase {
  final CensoRepository repository;

  FetchCensusPersonDataUseCase({required this.repository});

  Future<List<DataPerCenso>> call({required GetDatosPersonaCensoRequest request }) {
    return repository.getDatosPersonaCenso(request: request);
  }
}


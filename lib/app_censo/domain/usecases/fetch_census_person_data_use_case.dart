
part of 'censo_use_cases.dart';

class FetchCensusPersonDataUseCase {
  final CensoRepository repository;

  FetchCensusPersonDataUseCase({required this.repository});

  Future<List<DataCensado>> call({required GetDatosPersonaCensoRequest request }) {
    return repository.getDatosPersonaCenso(request: request);
  }
}


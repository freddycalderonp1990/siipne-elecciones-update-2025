part of 'censo_use_cases.dart';

class FetchDataHistoryCensusUseCase {
  final CensoRepository repository;

  FetchDataHistoryCensusUseCase({required this.repository});

  Future<List<DataHistoryCenso>> call({required int idPerCensado}) {
    return repository.getDatosHistoryCensos(idPerCensado: idPerCensado);
  }
}


part of 'censo_use_cases.dart';

class FetchActiveProcessesByCensusPersonUseCase {
  final CensoRepository repository;

  FetchActiveProcessesByCensusPersonUseCase({required this.repository});

  Future<List<DataProceso>> call({required GetDatosProcesosActivosRequest request }) {
    return repository.getDatosProcesosActivosByCensado(request: request);
  }
}


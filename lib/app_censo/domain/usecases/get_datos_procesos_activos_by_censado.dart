
part of 'censo_use_cases.dart';

class GetDatosProcesosActivosByCensado {
  final CensoRepository repository;

  GetDatosProcesosActivosByCensado({required this.repository});

  Future<List<DataCensado>> call({required GetDatosProcesosActivosRequest request }) {
    return repository.getDatosProcesosActivosByCensado(request: request);
  }
}


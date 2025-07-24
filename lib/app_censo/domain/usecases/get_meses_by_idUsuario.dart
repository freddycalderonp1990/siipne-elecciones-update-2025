part of 'censo_use_cases.dart';

class GetMesesByIdusuario {
  final CensoRepository repository;

  GetMesesByIdusuario({required this.repository});

  Future<List<DataCensado>> call({
    required GetMesasByIdusuarioRequest request,
  }) {
    return repository.getMesasByIdUsuario(request: request);
  }
}

part of 'censo_use_cases.dart';

class GetMesasByIdusuarioUseCase {
  final CensoRepository repository;

  GetMesasByIdusuarioUseCase({required this.repository});

  Future<DataMesaResponse> call({
    required GetMesasByIdusuarioRequest request,
  }) {
    return repository.getMesasByIdUsuario(request: request);
  }
}

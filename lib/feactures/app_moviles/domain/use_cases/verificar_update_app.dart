import '../../data/models/apps_model.dart';
import '../repository/apps_repository.dart';
import '../request/verificar_update_request.dart';

class VerificarUpdateUseCase {
  final AppsRepository repository;

  VerificarUpdateUseCase({required this.repository});

  Future<DataApp> call({required VerificarUpdateRequest request}) {
    return repository.verificarUpdateApp(request: request);
  }
}

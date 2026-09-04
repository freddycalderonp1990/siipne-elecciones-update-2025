

import '../repository/fecha_server_repository.dart';

class GetFechaServerUseCase {
  final FechaServerRepository repository;

  GetFechaServerUseCase({required this.repository});

  Future<DateTime> call() {
    return repository.getTimeServer();
  }
}

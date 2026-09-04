


import '../repository/local_storage_repository.dart';

class LocalStoreClockServerUseCase {
  final LocalStorageClockServerRepository repository;

  LocalStoreClockServerUseCase({required this.repository});


  Future<String> getFechaCellPause() async {
    return await repository.getFechaCellPause();
  }


  Future<String> getFechaServer() async {
    return await repository.getFechaServer();
  }


  Future<void> setFechaCellPause(String value) async {
    return await repository.setFechaCellPause(value);
  }


  Future<void> setFechaServer(String value) async {
    return await repository.setFechaServer(value);
  }





}

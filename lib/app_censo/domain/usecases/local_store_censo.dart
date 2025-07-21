


import '../repositories/local/local_storage_censo_repository.dart';

class LocalStoreCensoUseCase {
  final LocalStorageCensoRepository repository;

  LocalStoreCensoUseCase({required this.repository});



  Future<void> clearAllData() async {
    repository.clearAllData();
  }



  Future<void> setFechaServer(String value) async {
    return repository.setFechaServer(value);
  }

  Future<String> getFechaServer() async {
    return repository.getFechaServer();
  }


  Future<String> getFechaCellPauseCenso() async {
    return repository.getFechaCellPauseCenso();
  }


  Future<void> setFechaCellPauseCenso(String value) async {
    return repository.setFechaCellPauseCenso(value);
  }


  Future<String> getCodeUnicoCenso(String userName) async {
    return repository.getCodeUnicoCenso(userName);
  }


  Future<void> setCodeUnicoCenso(String userName, String passCode) async {
    return repository.setCodeUnicoCenso(userName, passCode);
  }
}




import '../repositories/local/local_storage_censo_repository.dart';

class LocalStoreCensoUseCase {
  final LocalStorageCensoRepository repository;

  LocalStoreCensoUseCase({required this.repository});



  Future<void> clearAllData() async {
    repository.clearAllData();
  }






  Future<String> getCodeUnicoCenso(String userName) async {
    return repository.getCodeUnicoCenso(userName);
  }


  Future<void> setCodeUnicoCenso(String userName, String passCode) async {
    return repository.setCodeUnicoCenso(userName, passCode);
  }
}

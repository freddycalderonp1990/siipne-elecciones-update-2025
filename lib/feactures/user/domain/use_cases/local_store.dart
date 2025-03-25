


import '../entities/user.dart';
import '../repository/local/local_storage_repository.dart';

class LocalStoreUseCase {
  final LocalStorageRepository repository;

  LocalStoreUseCase({required this.repository});



  Future<void> clearAllData() async {
    repository.clearAllData();
  }


  Future<bool> getAceptacionUserCodeTemporal() async {
    return repository.getAceptacionUserCodeTemporal();
  }


  Future<String> getAppPagePublic() async {
    return repository.getAppPagePublic();
  }


  Future<bool> getConfigHuella() async {
    return repository.getConfigHuella();
  }


  Future<int> getContadorFallido() async {
    return repository.getContadorFallido();
  }


  Future<bool> getLoginInit() async {
    return repository.getLoginInit();
  }


  Future<String> getPass() async {
    return repository.getPass();
  }


  Future<String> getPassCodeTemSiipne(String userName) async {
    return repository.getPassCodeTemSiipne(userName);
  }


  Future<String> getPinCode() async {
    return repository.getPinCode();
  }


  Future<bool> getShowDataUser() async {
    return repository.getShowDataUser();
  }




  Future<String> getUser() async {
    return repository.getUser();
  }


  Future<UserEntities> getUserModel() async {
    return repository.getUserModel();
  }


  Future<void> setAceptacionUserCodeTemporal(bool value) async {
    return repository.setAceptacionUserCodeTemporal(value);
  }


  Future<void> setAppPageSelect(String value) async {
    return repository.setAppPageSelect(value);
  }


  Future<void> setConfigHuella(bool value) async {
    return repository.setConfigHuella(value);
  }


  Future<void> setContadorFallido(int value) async {
    return repository.setContadorFallido(value);
  }


  Future<void> setLoginInit(bool value) async {
    return repository.setLoginInit(value);
  }


  Future<void> setPass(String pass) async {
    return repository.setPass(pass);
  }


  Future<void> setPassCodeTemSiipne(String userName, String passCode) async {
    return repository.setPassCodeTemSiipne(userName, passCode);
  }


  Future<void> setPinCode(String value) async {
    return repository.setPinCode(value);
  }


  Future<void> setShowDataUser(bool value) async {
    return repository.setShowDataUser(value);
  }




  Future<void> setUser(String user) async {
    return repository.setUser(user);
  }


  Future<void> setUserModel(UserEntities user) async {
    return repository.setUserModel(user);
  }
}

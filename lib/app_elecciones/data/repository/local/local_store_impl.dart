part of '../data_repositories.dart';

class LocalStoreImpl extends LocalStorageRepository {
  final LocalStoreProviderImpl _localStoreProviderImpl;
  LocalStoreImpl(this._localStoreProviderImpl);

  @override
  Future<void> clearAllData() async {
    return _localStoreProviderImpl.clearAllData();
  }

  @override
  Future<void> setUserModel(DataUser user) async {
    return _localStoreProviderImpl.setUserModel(user);
  }

  @override
  Future<DataUser> getUserModel() async {
    return _localStoreProviderImpl.getUserModel();
  }

  @override
  Future<String> getUser() async {
    return _localStoreProviderImpl.getUser();
  }

  @override
  Future<void> setUser(String user) async {
    return _localStoreProviderImpl.setUser(user);
  }

  @override
  Future<Uint8List?> getFoto() async {
    return _localStoreProviderImpl.getFoto();
  }

  @override
  Future<void> setFoto(String? foto) async {
    return _localStoreProviderImpl.setFoto(foto);
  }

  @override
  Future<String> getPass() async {
    return _localStoreProviderImpl.getPass();
  }

  @override
  Future<void> setPass(String pass) async {
    return _localStoreProviderImpl.setPass(pass);
  }

  @override
  Future<String> getUserName() async {
    return _localStoreProviderImpl.getUserName();
  }

  @override
  Future<void> setUserName(String userName) async {
    return _localStoreProviderImpl.setUserName(userName);
  }

  @override
  Future<bool> getLoginInit() async {
    return _localStoreProviderImpl.getLoginInit();
  }

  @override
  Future<bool> getConfigHuella() async {
    return _localStoreProviderImpl.getConfigHuella();
  }

  @override
  Future<void> setLoginInit(bool value) async {
    return _localStoreProviderImpl.setLoginInit(value);
  }

  @override
  Future<void> setConfigHuella(bool value) async {
    return _localStoreProviderImpl.setConfigHuella(value);
  }

  //Cuando el usuario a cambiado la clave y al precionar la huella por segunda  vez y no ingresa tiene que reiniciarse
  //para que se loguee con su nueva cuenta
  @override
  Future<int> getContadorFallido() async {
    return _localStoreProviderImpl.getContadorFallido();
  }

  @override
  Future<void> setContadorFallido(int value) async {
    return _localStoreProviderImpl.setContadorFallido(value);
  }

  @override
  Future<String> getPinCode() async {
    return await _localStoreProviderImpl.getPinCode();
  }

  @override
  Future<void> setPinCode(String value) async {
    return await _localStoreProviderImpl.setPinCode(value);
  }

  @override
  Future<String> getAppPagePublic() async {
    return await _localStoreProviderImpl.getAppPagePublic();
  }

  @override
  Future<void> setAppPageSelect(String value) async {
    return await _localStoreProviderImpl.setAppPageSelect(value);
  }

  @override
  Future<List<ApsQr>> getDataAppsQrPublic() async {
    return await _localStoreProviderImpl.getDataAppsQrPublic();
  }

  @override
  Future<void> setDataAppsQrPublic(DataSaveAppsQrModel value) async {
    return await _localStoreProviderImpl.setDataAppsQrPublic(value);
  }

  @override
  Future<String> getPassCodeTemSiipne(String userName) async {
    return await _localStoreProviderImpl.getPassCodeTemSiipne(userName);
  }

  @override
  Future<void> setPassCodeTemSiipne(String userName, String passCode) async {
    return await _localStoreProviderImpl.setPassCodeTemSiipne(
        userName, passCode);
  }

  @override
  Future<bool> getAceptacionUserCodeTemporal() async {
    return await _localStoreProviderImpl.getAceptacionUserCodeTemporal();
  }

  @override
  Future<void> setAceptacionUserCodeTemporal(bool value) async {
    return await _localStoreProviderImpl.setAceptacionUserCodeTemporal(value);
  }

  @override
  Future<String> getShowTutorial() async {
    return await _localStoreProviderImpl.getShowTutorial();
  }

  @override
  Future<void> showTutorial(String value) async {
    return await _localStoreProviderImpl.showTutorial(value);
  }

  @override
  Future<bool> getShowDataUser() async {
    return await _localStoreProviderImpl.getShowDataUser();
  }

  @override
  Future<void> setShowDataUser(bool value) async {
    return await _localStoreProviderImpl.setShowDataUser(value);
  }

  @override
  Future<String> getFechaCellPause() async {
    return await _localStoreProviderImpl.getFechaCellPause();
  }

  @override
  Future<String> getFechaServer() async {
    return await _localStoreProviderImpl.getFechaServer();
  }

  @override
  Future<void> setFechaCellPause(String value) async {
    return await _localStoreProviderImpl.setFechaCellPause(value);
  }

  @override
  Future<void> setFechaServer(String value) async {
    return await _localStoreProviderImpl.setFechaServer(value);
  }

  @override
  Future<DateTime> getFechaSolicitarAcceso() async {
    return await _localStoreProviderImpl.getFechaSolicitarAcceso();
  }

  @override
  Future<void> setFechaSolicitarAcceso(DateTime value) async {
    return await _localStoreProviderImpl.setFechaSolicitarAcceso(value);
  }
}

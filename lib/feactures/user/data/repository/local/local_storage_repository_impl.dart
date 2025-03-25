import 'dart:typed_data';

import 'package:siipnemovil2/feactures/user/domain/entities/user.dart';

import '../../../domain/repository/local/local_storage_repository.dart';
import '../../datasources/local_storage_data_source.dart';

class LocalStorageRepositoryImpl implements LocalStorageRepository {
  final LocalStorageDataSource localStorageDataSource;

  LocalStorageRepositoryImpl({required this.localStorageDataSource});

  @override
  Future<void> clearAllData() async {
    localStorageDataSource.clearAllData();
  }

  @override
  Future<bool> getAceptacionUserCodeTemporal() async {
    return localStorageDataSource.getAceptacionUserCodeTemporal();
  }

  @override
  Future<String> getAppPagePublic() async {
    return localStorageDataSource.getAppPagePublic();
  }

  @override
  Future<bool> getConfigHuella() async {
    return localStorageDataSource.getConfigHuella();
  }

  @override
  Future<int> getContadorFallido() async {
    return localStorageDataSource.getContadorFallido();
  }

  @override
  Future<bool> getLoginInit() async {
    return localStorageDataSource.getLoginInit();
  }

  @override
  Future<String> getPass() async {
    return localStorageDataSource.getPass();
  }

  @override
  Future<String> getPassCodeTemSiipne(String userName) async {
    return localStorageDataSource.getPassCodeTemSiipne(userName);
  }

  @override
  Future<String> getPinCode() async {
    return localStorageDataSource.getPinCode();
  }

  @override
  Future<bool> getShowDataUser() async {
    return localStorageDataSource.getShowDataUser();
  }


  @override
  Future<String> getUser() async {
    return localStorageDataSource.getUser();
  }

  @override
  Future<UserEntities> getUserModel() async {
    return localStorageDataSource.getUserModel();
  }

  @override
  Future<void> setAceptacionUserCodeTemporal(bool value) async {
    return localStorageDataSource.setAceptacionUserCodeTemporal(value);
  }

  @override
  Future<void> setAppPageSelect(String value) async {
    return localStorageDataSource.setAppPageSelect(value);
  }

  @override
  Future<void> setConfigHuella(bool value) async {
    return localStorageDataSource.setConfigHuella(value);
  }

  @override
  Future<void> setContadorFallido(int value) async {
    return localStorageDataSource.setContadorFallido(value);
  }

  @override
  Future<void> setLoginInit(bool value) async {
    return localStorageDataSource.setLoginInit(value);
  }

  @override
  Future<void> setPass(String pass) async {
    return localStorageDataSource.setPass(pass);
  }

  @override
  Future<void> setPassCodeTemSiipne(String userName, String passCode) async {
    return localStorageDataSource.setPassCodeTemSiipne(userName, passCode);
  }

  @override
  Future<void> setPinCode(String value) async {
    return localStorageDataSource.setPinCode(value);
  }

  @override
  Future<void> setShowDataUser(bool value) async {
    return localStorageDataSource.setShowDataUser(value);
  }


  @override
  Future<void> setUser(String user) async {
    return localStorageDataSource.setUser(user);
  }

  @override
  Future<void> setUserModel(UserEntities user) async {
    return localStorageDataSource.setUserModel(user);
  }
}

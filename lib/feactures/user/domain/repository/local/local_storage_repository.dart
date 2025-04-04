//Para Guardar informacion en local


import '../../entities/user.dart';

abstract class LocalStorageRepository{
  //Se define que cosas quiero hacer
  //se definen los contartos


  Future<UserEntities> getUserModel();
  Future<void> setUserModel(UserEntities user);


  Future<int> getContadorFallido();
  Future<void> setContadorFallido(int value);

  Future<bool> getLoginInit();
  Future<void> setLoginInit(bool value);



  Future<bool> getConfigHuella() ;
  Future<void> setConfigHuella(bool value) ;



  Future<void> setUser(String user);
  Future<String> getUser();

  Future<void> setPass(String pass);
  Future<String> getPass();





  Future<void> setPinCode(String value);
  Future<String> getPinCode();



  Future<void> setPassCodeTemSiipne(String userName,String passCode);
  Future<String> getPassCodeTemSiipne(String userName);

  //Para que el usario acepte y ya no le muetre el mensaje de que existe un codigo teporal guardado

  Future<bool> getAceptacionUserCodeTemporal() ;
  Future<void> setAceptacionUserCodeTemporal(bool value) ;

  Future<void> setAppPageSelect(String value);
  Future<String> getAppPagePublic();



  Future<bool> getShowDataUser() ;
  Future<void> setShowDataUser(bool value) ;

  Future<void> clearAllData();






}
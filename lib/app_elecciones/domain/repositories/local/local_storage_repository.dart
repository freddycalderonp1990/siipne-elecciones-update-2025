//Para Guardar informacion en local

part of '../domain_repositories.dart';
abstract class LocalStorageRepository{
  //Se define que cosas quiero hacer
  //se definen los contartos


  Future<DataUser> getUserModel();
  Future<void> setUserModel(DataUser user);


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


  Future<void> setFoto(String? foto);
  Future<Uint8List?> getFoto();

  Future<void> setUserName(String userName);
  Future<String> getUserName();


  Future<void> setPinCode(String value);
  Future<String> getPinCode();





  Future<void> setDataAppsQrPublic(DataSaveAppsQrModel value);
  Future<List<ApsQr> > getDataAppsQrPublic();


  Future<void> setPassCodeTemSiipne(String userName,String passCode);
  Future<String> getPassCodeTemSiipne(String userName);

  //Para que el usario acepte y ya no le muetre el mensaje de que existe un codigo teporal guardado


  Future<bool> getAceptacionUserCodeTemporal() ;
  Future<void> setAceptacionUserCodeTemporal(bool value) ;

  Future<void> setAppPageSelect(String value);
  Future<String> getAppPagePublic();

  Future<String> getShowTutorial() ;
  Future<void> showTutorial(String value) ;

  Future<bool> getShowDataUser() ;
  Future<void> setShowDataUser(bool value) ;

  Future<void> clearAllData();


  Future<void> setFechaServer(String value);
  Future<String> getFechaServer();

  Future<void> setFechaCellPause(String value);
  Future<String> getFechaCellPause();



  Future<void> setFechaSolicitarAcceso(DateTime value);
  Future<DateTime> getFechaSolicitarAcceso();




}
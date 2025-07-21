//Para Guardar informacion en local

abstract class LocalStorageCensoRepository{


  Future<void> clearAllData();


  Future<void> setFechaServer(String value);
  Future<String> getFechaServer();


  Future<void> setFechaCellPauseCenso(String value);
  Future<String> getFechaCellPauseCenso();


  Future<void> setCodeUnicoCenso(String userName,String passCode);
  Future<String> getCodeUnicoCenso(String userName);


}
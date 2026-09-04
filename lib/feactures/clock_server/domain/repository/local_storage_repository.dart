
abstract class LocalStorageClockServerRepository{
  Future<void> setFechaServer(String value);
  Future<String> getFechaServer();

  Future<void> setFechaCellPause(String value);
  Future<String> getFechaCellPause();




}
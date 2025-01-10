part of '../../domain_repositories.dart';
abstract class ConfigAppRepository{

  Future<bool> verificarUpdateApp(UpdateAppRequest updateAppRequest) ;

  Future<bool> saveConfigVersionApp(ConfigAppRequest configAppRequest) ;

  Future<DataConfigApp> consultarConfigVersionApp() ;

  Future<DateTime> getTimeServer();




}
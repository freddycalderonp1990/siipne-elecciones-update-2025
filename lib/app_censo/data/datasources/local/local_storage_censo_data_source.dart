
import 'package:shared_preferences/shared_preferences.dart';
abstract class LocalStorageCensoDataSource {


  Future<void> clearAllData();

  Future<void> setFechaServer(String value);
  Future<String> getFechaServer();

  Future<void> setFechaCellPauseCenso(String value);
  Future<String> getFechaCellPauseCenso();

  Future<void> setCodeUnicoCenso(String userName,String passCode);
  Future<String> getCodeUnicoCenso(String userName);



}

const _APP = 'CENSO';

const _PREF_FECHA_SERVER = '${_APP}PREF_FECHA_SERVER';
const _PREF_FECHA_CELL_PAUSE = '${_APP}PREF_FECHA_CELL_PAUSE';

const _PREF_CODIGO_CENSO = '${_APP}_PREF_CODIGO_CENSO';




class LocalStorageCensoDataSourceImpl implements LocalStorageCensoDataSource {
  @override
  Future<void> clearAllData() async {


  }


  @override
  Future<String> getFechaServer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_PREF_FECHA_SERVER) ?? '';
  }

  @override
  Future<void> setFechaServer(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_PREF_FECHA_SERVER, value);
  }

  @override
  Future<String> getFechaCellPauseCenso() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_PREF_FECHA_CELL_PAUSE) ?? '';
  }

  @override
  Future<void> setFechaCellPauseCenso(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_PREF_FECHA_CELL_PAUSE, value);
  }

  @override
  Future<String> getCodeUnicoCenso(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_PREF_CODIGO_CENSO+userName) ?? '';
  }

  @override
  Future<void> setCodeUnicoCenso(String userName, String passCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_PREF_CODIGO_CENSO+userName, passCode);
  }





}

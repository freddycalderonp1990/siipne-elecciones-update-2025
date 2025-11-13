
import 'package:shared_preferences/shared_preferences.dart';
abstract class LocalStorageClockServerDataSource {

  Future<void> setFechaServer(String value);
  Future<String> getFechaServer();

  Future<void> setFechaCellPause(String value);
  Future<String> getFechaCellPause();




}
const _PREF_FECHA_SERVER= 'PREF_FECHA_SERVER';
const _PREF_FECHA_CELL_PAUSE= 'PREF_FECHA_CELL_PAUSE';

class LocalStorageClockServerDataSourceImpl implements LocalStorageClockServerDataSource {


  @override
  Future<String> getFechaCellPause() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_PREF_FECHA_CELL_PAUSE) ?? '';

  }

  @override
  Future<String> getFechaServer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_PREF_FECHA_SERVER) ?? '';

  }

  @override
  Future<void> setFechaCellPause(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_PREF_FECHA_CELL_PAUSE, value);
  }

  @override
  Future<void> setFechaServer(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_PREF_FECHA_SERVER, value);
  }


}

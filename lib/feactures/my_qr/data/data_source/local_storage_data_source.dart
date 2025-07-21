import 'dart:typed_data';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../../app/core/utils/photo_helper.dart';


import '../../../../app/domain/enums/enums.dart';


abstract class LocalStorageDataSource {

  Future<void> setFechaServer(String value);
  Future<String> getFechaServer();



}




const _PREF_FECHA_SERVER = 'PREF_FECHA_SERVER';


class LocalStorageDataSourceImpl implements LocalStorageDataSource {
  @override
  Future<void> clearAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setFechaServer("");

  }





  @override
  Future<String> getFechaServer()  async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_PREF_FECHA_SERVER) ?? '';
  }

  @override
  Future<void> setFechaServer(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_PREF_FECHA_SERVER, value);
  }





}

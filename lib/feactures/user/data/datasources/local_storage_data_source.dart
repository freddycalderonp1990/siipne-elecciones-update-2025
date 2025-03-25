import 'dart:typed_data';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../../app/core/utils/photo_helper.dart';
import '../../../../app_elecciones/domain/enums/enums.dart';
import '../../domain/entities/user.dart';

abstract class LocalStorageDataSource {

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

const _PREF_TOKEN = 'TOKEN';
const _PREF_USER = 'USER';
const _PREF_PASS = 'PASS';
const _PREF_FOTO = 'FOTO';
const _PREF_APP_INICIAL =
    'APP_INICIAL'; // sirve para controlar si el usuario recien instalo la aplicacion y mostrarle directamente el login
const _PREF_TIENE_HUELLA = 'TIENE_HUELLA';
const _PREF_USER_NAME = 'USER_NAME';

const _PREF_CONTADOR_FALLIDO =
    'CONTADOR_FALLIDO'; //Cuando el usuario a cambiado la clave y al precionar la huella por segunda  vez y no ingresa tiene que reiniciarse
//para que se loguee con su nueva cuenta

const _PREF_USER_JSON = 'USER_JSON';

const _PREF_CODE_PIN = 'CODE_PIN';

const _PREF_APP_PAGE_SELECT = 'APP_PAGE_SELECT';
const _PREF_APP_SAVE_QR = 'APP_SAVE_QR';
const _PREF_ACEPTACIONUSER_CODE_TOTP = 'ACEPTACIONUSER_CODE_TOTP';

const _PREF_SHOW_TUTORIAL = 'SHOW_TUTORIAL';

const _PREF_SHOW_DATA_USER = 'SHOW_DATA_USUARIO';
const _PREF_FECHA_SERVER = 'PREF_FECHA_SERVER';
const _PREF_FECHA_CELL_PAUSE = 'PREF_FECHA_CELL_PAUSE';

const _PREF_FECHA_SOLICITAR_ACCESO = 'PREF_FECHA_SOLICITAR_ACCESO';

class LocalStorageDataSourceImpl implements LocalStorageDataSource {
  @override
  Future<void> clearAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setConfigHuella(false);
    setContadorFallido(0);

    setLoginInit(false);
    setPass('');
    setPinCode('');

    setUser('');
    setUserModel(UserEntities.empty());
    //setUserName(''); no lo limpiamos para saber que usaurio fue el ultimo que uso la app

    setAceptacionUserCodeTemporal(false);

    // prefs.clear();
  }

  @override
  Future<void> setUserModel(UserEntities user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String jsonString = userEntitiesToJson(user);

    print(" json user es= ${jsonString}");
    prefs.setString(_PREF_USER_JSON, jsonString);

    final String data1 = prefs.getString(_PREF_USER_JSON) ?? '';
  }

  @override
  Future<UserEntities> getUserModel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String data = prefs.getString(_PREF_USER_JSON) ?? '';

    if (data == '') {
      return UserEntities.empty();
    }

    return userEntitiesFromJson(data);
  }

  @override
  Future<String> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_PREF_USER) ?? '';
  }

  @override
  Future<void> setUser(String user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_PREF_USER, user);
  }




  @override
  Future<String> getPass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_PREF_PASS) ?? '';
  }

  @override
  Future<void> setPass(String pass) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_PREF_PASS, pass);
  }



  @override
  Future<bool> getLoginInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_PREF_APP_INICIAL) ?? false;
  }

  @override
  Future<bool> getConfigHuella() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_PREF_TIENE_HUELLA) ?? false;
  }

  @override
  Future<void> setLoginInit(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_PREF_APP_INICIAL, value);
  }

  @override
  Future<void> setConfigHuella(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_PREF_TIENE_HUELLA, value);
  }

  //Cuando el usuario a cambiado la clave y al precionar la huella por segunda  vez y no ingresa tiene que reiniciarse
  //para que se loguee con su nueva cuenta
  @override
  Future<int> getContadorFallido() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_PREF_CONTADOR_FALLIDO) ?? 0;
  }

  @override
  Future<void> setContadorFallido(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(_PREF_CONTADOR_FALLIDO, value);
  }

  @override
  Future<String> getPinCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_PREF_CODE_PIN) ?? '';
  }

  @override
  Future<void> setPinCode(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_PREF_CODE_PIN, value);
  }

  @override
  Future<String> getAppPagePublic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_PREF_APP_PAGE_SELECT) ??
        PageAppsSelect.Bienvenida.toString();
  }

  @override
  Future<void> setAppPageSelect(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_PREF_APP_PAGE_SELECT, value);
  }

  @override
  Future<String> getPassCodeTemSiipne(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userName) ?? '';
  }

  @override
  Future<void> setPassCodeTemSiipne(String userName, String passCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userName, passCode);
  }

  @override
  Future<bool> getAceptacionUserCodeTemporal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_PREF_ACEPTACIONUSER_CODE_TOTP) ?? false;
  }

  @override
  Future<void> setAceptacionUserCodeTemporal(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_PREF_ACEPTACIONUSER_CODE_TOTP, value);
  }



  @override
  Future<bool> getShowDataUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_PREF_SHOW_DATA_USER) ?? true;
  }

  @override
  Future<void> setShowDataUser(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_PREF_SHOW_DATA_USER, value);
  }





}

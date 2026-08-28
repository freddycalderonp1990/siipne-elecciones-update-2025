import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';


import '../../../../app/domain/enums/enums.dart';
import '../../domain/entities/user.dart';

abstract class LocalStorageDataSource {
  Future<UserEntities> getUserModel();
  Future<void> setUserModel(UserEntities user);

  Future<int> getContadorFallido();
  Future<void> setContadorFallido(int value);

  Future<int> getLastIdGenUsuario();
  Future<void> setLastIdGenUsuario(int value);

  Future<bool> getLoginInit();
  Future<void> setLoginInit(bool value);

  Future<bool> getConfigHuella();
  Future<void> setConfigHuella(bool value);

  Future<void> setUser(String user);
  Future<String> getUser();

  Future<void> setPass(String pass);
  Future<String> getPass();

  Future<void> setPinCode(String value);
  Future<String> getPinCode();

  Future<void> setPassCodeTemSiipne(String userName, String passCode);
  Future<String> getPassCodeTemSiipne(String userName);

  //Para que el usario acepte y ya no le muetre el mensaje de que existe un codigo teporal guardado

  Future<bool> getAceptacionUserCodeTemporal();
  Future<void> setAceptacionUserCodeTemporal(bool value);

  Future<void> setAppPageSelect(String value);
  Future<String> getAppPagePublic();

  Future<bool> getShowDataUser();
  Future<void> setShowDataUser(bool value);

  Future<void> clearAllData();
}

const _PREF_USER = 'USER';
const _PREF_PASS = 'PASS';

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

const _PREF_ACEPTACIONUSER_CODE_TOTP = 'ACEPTACIONUSER_CODE_TOTP';

const _PREF_SHOW_DATA_USER = 'SHOW_DATA_USUARIO';
const _PREF_FECHA_SERVER = 'PREF_FECHA_SERVER';

const _PREF_LAST_ID_GENUSUARIO = '_PREF_LAST_ID_GENUSUARIO';
const _PREF_TEMP_CODE_PREFIX = 'TEMP_CODE_';

class LocalStorageDataSourceImpl implements LocalStorageDataSource {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  @override
  Future<void> clearAllData() async {
    await setConfigHuella(false);
    await setContadorFallido(0);
    await setLoginInit(false);
    await setPass('');
    await setPinCode('');
    await setUser('');
    await setUserModel(UserEntities.empty());
    await setAceptacionUserCodeTemporal(false);
  }

  @override
  Future<void> setUserModel(UserEntities user) async {
    await _storage.write(key: _PREF_USER_JSON, value: userEntitiesToJson(user));
  }

  @override
  Future<UserEntities> getUserModel() async {
    final data = await _storage.read(key: _PREF_USER_JSON) ?? '';
    return data.isEmpty ? UserEntities.empty() : userEntitiesFromJson(data);
  }

  @override
  Future<String> getUser() async => await _storage.read(key: _PREF_USER) ?? '';

  @override
  Future<void> setUser(String user) async {
    if (user.isEmpty) {
      await _storage.delete(key: _PREF_USER);
      return;
    }
    await _storage.write(key: _PREF_USER, value: user);
  }

  @override
  Future<String> getPass() async => await _storage.read(key: _PREF_PASS) ?? '';

  @override
  Future<void> setPass(String pass) async {
    if (pass.isEmpty) {
      await _storage.delete(key: _PREF_PASS);
      return;
    }
    await _storage.write(key: _PREF_PASS, value: pass);
  }

  @override
  Future<bool> getLoginInit() async =>
      (await _storage.read(key: _PREF_APP_INICIAL)) == 'true';

  @override
  Future<void> setLoginInit(bool value) async =>
      await _storage.write(key: _PREF_APP_INICIAL, value: value.toString());

  @override
  Future<bool> getConfigHuella() async =>
      (await _storage.read(key: _PREF_TIENE_HUELLA)) == 'true';

  @override
  Future<void> setConfigHuella(bool value) async =>
      await _storage.write(key: _PREF_TIENE_HUELLA, value: value.toString());

  @override
  Future<int> getContadorFallido() async =>
      int.tryParse(await _storage.read(key: _PREF_CONTADOR_FALLIDO) ?? '') ?? 0;

  @override
  Future<void> setContadorFallido(int value) async => await _storage.write(
    key: _PREF_CONTADOR_FALLIDO,
    value: value.toString(),
  );

  @override
  Future<String> getPinCode() async =>
      await _storage.read(key: _PREF_CODE_PIN) ?? '';

  @override
  Future<void> setPinCode(String value) async {
    if (value.isEmpty) {
      await _storage.delete(key: _PREF_CODE_PIN);
      return;
    }
    await _storage.write(key: _PREF_CODE_PIN, value: value);
  }

  @override
  Future<String> getAppPagePublic() async =>
      await _storage.read(key: _PREF_APP_PAGE_SELECT) ??
      PageAppsSelect.Bienvenida.toString();

  @override
  Future<void> setAppPageSelect(String value) async =>
      await _storage.write(key: _PREF_APP_PAGE_SELECT, value: value);

  @override
  Future<String> getPassCodeTemSiipne(String userName) async =>
      await _storage.read(key: '$_PREF_TEMP_CODE_PREFIX$userName') ?? '';

  @override
  Future<void> setPassCodeTemSiipne(String userName, String passCode) async {
    final key = '$_PREF_TEMP_CODE_PREFIX$userName';
    if (passCode.isEmpty) {
      await _storage.delete(key: key);
      return;
    }
    await _storage.write(key: key, value: passCode);
  }

  @override
  Future<bool> getAceptacionUserCodeTemporal() async =>
      (await _storage.read(key: _PREF_ACEPTACIONUSER_CODE_TOTP)) == 'true';

  @override
  Future<void> setAceptacionUserCodeTemporal(bool value) async => await _storage
      .write(key: _PREF_ACEPTACIONUSER_CODE_TOTP, value: value.toString());

  @override
  Future<bool> getShowDataUser() async {
    final value = await _storage.read(key: _PREF_SHOW_DATA_USER);
    return value == null ? true : value == 'true';
  }

  @override
  Future<void> setShowDataUser(bool value) async =>
      await _storage.write(key: _PREF_SHOW_DATA_USER, value: value.toString());

  @override
  Future<String> getFechaServer() async =>
      await _storage.read(key: _PREF_FECHA_SERVER) ?? '';

  @override
  Future<void> setFechaServer(String value) async {
    if (value.isEmpty) {
      await _storage.delete(key: _PREF_FECHA_SERVER);
      return;
    }
    await _storage.write(key: _PREF_FECHA_SERVER, value: value);
  }

  @override
  Future<int> getLastIdGenUsuario() async =>
      int.tryParse(await _storage.read(key: _PREF_LAST_ID_GENUSUARIO) ?? '') ??
      0;

  @override
  Future<void> setLastIdGenUsuario(int value) async => await _storage.write(
    key: _PREF_LAST_ID_GENUSUARIO,
    value: value.toString(),
  );
}

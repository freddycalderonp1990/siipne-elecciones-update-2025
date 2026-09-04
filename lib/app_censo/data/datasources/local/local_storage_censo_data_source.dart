import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class LocalStorageCensoDataSource {
  Future<void> clearAllData();
  Future<void> setFechaServer(String value);
  Future<String> getFechaServer();
  Future<void> setFechaCellPauseCenso(String value);
  Future<String> getFechaCellPauseCenso();
  Future<void> setCodeUnicoCenso(String userName, String passCode);
  Future<String> getCodeUnicoCenso(String userName);
}

const _APP = 'CENSO';
const _PREF_FECHA_SERVER = '${_APP}PREF_FECHA_SERVER';
const _PREF_FECHA_CELL_PAUSE = '${_APP}PREF_FECHA_CELL_PAUSE';
const _PREF_CODIGO_CENSO = '${_APP}_PREF_CODIGO_CENSO';

class LocalStorageCensoDataSourceImpl implements LocalStorageCensoDataSource {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  @override
  Future<void> clearAllData() async {
    await _storage.delete(key: _PREF_FECHA_SERVER);
    await _storage.delete(key: _PREF_FECHA_CELL_PAUSE);
    final data = await _storage.readAll();
    final prefix = _PREF_CODIGO_CENSO;
    for (final key in data.keys) {
      if (key.startsWith(prefix)) {
        await _storage.delete(key: key);
      }
    }
  }

  @override
  Future<String> getFechaServer() async => await _storage.read(key: _PREF_FECHA_SERVER) ?? '';

  @override
  Future<void> setFechaServer(String value) async {
    if (value.isEmpty) {
      await _storage.delete(key: _PREF_FECHA_SERVER);
      return;
    }
    await _storage.write(key: _PREF_FECHA_SERVER, value: value);
  }

  @override
  Future<String> getFechaCellPauseCenso() async => await _storage.read(key: _PREF_FECHA_CELL_PAUSE) ?? '';

  @override
  Future<void> setFechaCellPauseCenso(String value) async {
    if (value.isEmpty) {
      await _storage.delete(key: _PREF_FECHA_CELL_PAUSE);
      return;
    }
    await _storage.write(key: _PREF_FECHA_CELL_PAUSE, value: value);
  }

  @override
  Future<String> getCodeUnicoCenso(String userName) async => await _storage.read(key: '$_PREF_CODIGO_CENSO$userName') ?? '';

  @override
  Future<void> setCodeUnicoCenso(String userName, String passCode) async {
    final key = '$_PREF_CODIGO_CENSO$userName';
    if (passCode.isEmpty) {
      await _storage.delete(key: key);
      return;
    }
    await _storage.write(key: key, value: passCode);
  }
}
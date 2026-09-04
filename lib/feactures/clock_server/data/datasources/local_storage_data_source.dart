import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class LocalStorageClockServerDataSource {
  Future<void> setFechaServer(String value);
  Future<String> getFechaServer();
  Future<void> setFechaCellPause(String value);
  Future<String> getFechaCellPause();
}

const _PREF_FECHA_SERVER = 'PREF_FECHA_SERVER';
const _PREF_FECHA_CELL_PAUSE = 'PREF_FECHA_CELL_PAUSE';

class LocalStorageClockServerDataSourceImpl implements LocalStorageClockServerDataSource {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  @override
  Future<String> getFechaCellPause() async => await _storage.read(key: _PREF_FECHA_CELL_PAUSE) ?? '';

  @override
  Future<String> getFechaServer() async => await _storage.read(key: _PREF_FECHA_SERVER) ?? '';

  @override
  Future<void> setFechaCellPause(String value) async {
    if (value.isEmpty) {
      await _storage.delete(key: _PREF_FECHA_CELL_PAUSE);
      return;
    }
    await _storage.write(key: _PREF_FECHA_CELL_PAUSE, value: value);
  }

  @override
  Future<void> setFechaServer(String value) async {
    if (value.isEmpty) {
      await _storage.delete(key: _PREF_FECHA_SERVER);
      return;
    }
    await _storage.write(key: _PREF_FECHA_SERVER, value: value);
  }
}
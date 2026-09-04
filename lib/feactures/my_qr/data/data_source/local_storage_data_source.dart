import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class LocalStorageDataSource {
  Future<void> setFechaServer(String value);
  Future<String> getFechaServer();
  Future<void> clearAllData();
}

const _PREF_FECHA_SERVER = 'PREF_FECHA_SERVER';

class LocalStorageDataSourceImpl implements LocalStorageDataSource {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  @override
  Future<void> clearAllData() async {
    await _storage.delete(key: _PREF_FECHA_SERVER);
  }

  @override
  Future<String> getFechaServer() async {
    return await _storage.read(key: _PREF_FECHA_SERVER) ?? '';
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
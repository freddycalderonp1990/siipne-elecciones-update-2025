import 'dart:typed_data';

import '../../domain/repository/local_storage_repository.dart';
import '../datasources/local_storage_data_source.dart';


class LocalStorageClockServerRepositoryImpl implements LocalStorageClockServerRepository {
  final LocalStorageClockServerDataSource localStorageDataSource;

  LocalStorageClockServerRepositoryImpl({required this.localStorageDataSource});

  @override
  Future<String> getFechaCellPause() async {
    return await localStorageDataSource.getFechaCellPause();
  }

  @override
  Future<String> getFechaServer() async {
    return await localStorageDataSource.getFechaServer();
  }

  @override
  Future<void> setFechaCellPause(String value) async {
    return await localStorageDataSource.setFechaCellPause(value);
  }

  @override
  Future<void> setFechaServer(String value) async {
    return await localStorageDataSource.setFechaServer(value);
  }

}

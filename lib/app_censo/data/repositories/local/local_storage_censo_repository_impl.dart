import 'dart:typed_data';

import '../../../domain/repositories/local/local_storage_censo_repository.dart';
import '../../datasources/local/local_storage_censo_data_source.dart';



class LocalStorageCensoRepositoryImpl implements LocalStorageCensoRepository {
  final LocalStorageCensoDataSource localStorageCensoDataSource;

  LocalStorageCensoRepositoryImpl({required this.localStorageCensoDataSource});

  @override
  Future<void> clearAllData() async {
    localStorageCensoDataSource.clearAllData();
  }


  @override
  Future<String> getFechaServer() async {
    return localStorageCensoDataSource.getFechaServer();
  }

  @override
  Future<void> setFechaServer(String value) async {
    return localStorageCensoDataSource.setFechaServer(value);
  }

  @override
  Future<String> getFechaCellPauseCenso() async {
    return localStorageCensoDataSource.getFechaCellPauseCenso();
  }

  @override
  Future<void> setFechaCellPauseCenso(String value) async {
    return localStorageCensoDataSource.setFechaCellPauseCenso(value);
  }

  @override
  Future<String> getCodeUnicoCenso(String userName) async {
    return localStorageCensoDataSource.getCodeUnicoCenso(userName);
  }

  @override
  Future<void> setCodeUnicoCenso(String userName, String passCode) async {
    return localStorageCensoDataSource.setCodeUnicoCenso(userName, passCode);
  }
}

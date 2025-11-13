

import '../../domain/repository/fecha_server_repository.dart';
import '../datasources/fecha_server_remote_data_source.dart';

class FechaServerRepositoryImpl implements FechaServerRepository {
  final FechaServerDataSource fechaServerDataSource;

  FechaServerRepositoryImpl({required this.fechaServerDataSource});




  @override
  Future<DateTime> getTimeServer() async {
   return await fechaServerDataSource.getTimeServer();
  }


}

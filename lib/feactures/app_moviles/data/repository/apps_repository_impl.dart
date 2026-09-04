

import 'package:siipnemovil2/feactures/app_moviles/data/models/apps_model.dart';

import 'package:siipnemovil2/feactures/app_moviles/domain/request/verificar_update_request.dart';

import '../../domain/repository/apps_repository.dart';
import '../datasources/apps_remote_data_source.dart';

class AppsRepositoryImpl implements AppsRepository {
  final AppsRemoteDataSource appsRemoteDataSource;

  AppsRepositoryImpl({required this.appsRemoteDataSource});


  @override
  Future<DataApp> verificarUpdateApp({required VerificarUpdateRequest request})  async {

   return appsRemoteDataSource.verificarUpdateApp(request: request);
  }


}

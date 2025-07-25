
import 'package:get/get.dart';

import 'data/datasources/foto_dgp_remote_data_source.dart';
import 'data/repository/foto_dgp_repository_impl.dart';
import 'domain/repository/foto_dgp_repository.dart';
import 'domain/use_cases/get_foto_dgp_by_documento.dart';

class DependencyInjectionFotoDgp {

  static init() async {
    // Use cases

    Get.lazyPut(()=>GetFotoDgpByDocumentoUseCase(repository: Get.find()), fenix: true);

    // Repository
    Get.lazyPut<FotoDgpRepository>(()=>FotoDgpRepositoryImpl(fotoDgpRemoteDataSource: Get.find()),fenix: true);

    // Data sources
    Get.lazyPut<FotoDgpRemoteDataSource>(()=>FotoDgpRemoteDataSourceImpl(), fenix: true);

  }
}

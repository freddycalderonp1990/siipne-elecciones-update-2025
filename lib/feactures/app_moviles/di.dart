
import 'package:get/get.dart';
import 'package:siipnemovil2/feactures/app_moviles/data/datasources/apps_remote_data_source.dart';

import 'data/repository/apps_repository_impl.dart';
import 'domain/repository/apps_repository.dart';
import 'domain/use_cases/verificar_update_app.dart';


class DependencyInjectionAppsMoviles {

  static init() async {
    // Use cases

    Get.lazyPut(()=>VerificarUpdateUseCase(repository: Get.find()), fenix: true);

    // Repository
    Get.lazyPut<AppsRepository>(()=>AppsRepositoryImpl(appsRemoteDataSource: Get.find()),fenix: true);

    // Data sources
    Get.lazyPut<AppsRemoteDataSource>(()=>AppsRemoteDataSourceImpl(), fenix: true);

  }
}

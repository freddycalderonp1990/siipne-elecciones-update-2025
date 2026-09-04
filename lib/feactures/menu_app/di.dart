
import 'package:get/get.dart';
import 'package:siipnemovil2/feactures/app_moviles/data/datasources/apps_remote_data_source.dart';

import 'data/datasources/menu_app_remote_data_source.dart';
import 'data/repository/menu_app_repository_impl.dart';
import 'domain/repository/menu_app_repository.dart';
import 'domain/use_cases/get_menu_app_use_case.dart';


class DependencyInjectionMenuApps {

  static init() async {
    // Use cases

    Get.lazyPut(()=>GetMenuAppUseCase(repository: Get.find()), fenix: true);

    // Repository
    Get.lazyPut<MenuAppRepository>(()=>MenuAppRepositoryImpl(menuAppRemoteDataSource: Get.find()),fenix: true);

    // Data sources
    Get.lazyPut<MenuAppRemoteDataSource>(()=>MenuAppRemoteDataSourceImpl(), fenix: true);

  }
}

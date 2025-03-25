
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:siipnemovil2/feactures/user/data/datasources/local_storage_data_source.dart';
import 'package:siipnemovil2/feactures/user/data/datasources/user_remote_data_source.dart';
import 'package:siipnemovil2/feactures/user/data/repository/local/local_storage_repository_impl.dart';
import 'package:siipnemovil2/feactures/user/domain/repository/local/local_storage_repository.dart';

import 'package:siipnemovil2/feactures/user/domain/repository/user_repository.dart';
import 'package:siipnemovil2/feactures/user/domain/use_cases/auth.dart';
import 'package:siipnemovil2/feactures/user/domain/use_cases/get_data_user.dart';
import 'package:siipnemovil2/feactures/user/domain/use_cases/local_store.dart';

import 'user/data/repository/user_repository_impl.dart';

class DependencyInjectionUser  {

  static init() async {
    // Use cases
    Get.lazyPut<LocalStoreUseCase>(()=>LocalStoreUseCase(repository: Get.find()),fenix: true);

    Get.lazyPut<GetDataUserUseCase>(() => GetDataUserUseCase(repository: Get.find()),
        fenix: true);
    Get.lazyPut<AuthUseCase>(()=>AuthUseCase(repository: Get.find()));




    // Repository
    Get.lazyPut<UserRepository>(() =>
        UserRepositoryImpl(userRemoteDataSource: Get.find()), fenix: true);
    Get.lazyPut<LocalStorageRepository>(() =>
        LocalStorageRepositoryImpl(localStorageDataSource: Get.find()), fenix: true);





    // Data sources
    Get.lazyPut<UserRemoteDataSource>(() => UserRemoteDataSourceImpl(),
        fenix: true);

    Get.lazyPut<LocalStorageDataSource>(() => LocalStorageDataSourceImpl(),
        fenix: true);
  }
}

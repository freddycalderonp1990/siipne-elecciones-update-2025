
import 'package:get/get.dart';

import 'data/data_sources/local_storage_data_source.dart';
import 'data/data_sources/user_remote_data_source.dart';

import 'data/repository/local/local_storage_repository_impl.dart';
import 'data/repository/user_repository_impl.dart';
import 'domain/repository/local/local_storage_repository.dart';
import 'domain/repository/user_repository.dart';
import 'domain/use_cases/auth.dart';
import 'domain/use_cases/get_data_user.dart';
import 'domain/use_cases/local_store.dart';
import 'presentation/modules/controllers.dart';


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

    Get.put(LoginController());
  }
}




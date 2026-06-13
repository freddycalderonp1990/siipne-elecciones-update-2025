
import 'package:get/get.dart';


import 'data/data_sources/push_notification_remote_data_source.dart';
import 'data/repository/push_notification_repository_impl.dart';
import 'domain/repository/push_notification_repository.dart';
import 'domain/use_cases/insert_token_fcm.dart';
import 'presentation/modules/controllers.dart';


class DependencyInjectionUser  {

  static init() async {
    // Use cases


    Get.lazyPut<InsertTopkenFcmUseCase>(() => InsertTopkenFcmUseCase(repository: Get.find()),
        fenix: true);


    // Repository
    Get.lazyPut<PushNotificationRepository>(() =>
        PushNotificationRepositoryImpl(pushNotificationRemoteDataSource: Get.find()), fenix: true);


    // Data sources
    Get.lazyPut<PushNotificationRemoteDataSource>(() => PusNotificationFirebaseRemoteDataSourceImpl(),
        fenix: true);



    Get.put(LoginController());
  }
}




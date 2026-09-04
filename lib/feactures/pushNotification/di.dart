import 'package:get/get.dart';
import 'package:siipnemovil2/feactures/pushNotification/services/notification_service.dart';

import 'data/data_sources/push_notification_local_data_source.dart';
import 'data/data_sources/push_notification_remote_data_source.dart';

import 'data/repository/push_notification_local_repository_impl.dart';
import 'data/repository/push_notification_repository_impl.dart';

import 'domain/repository/push_notification_local_repository.dart';
import 'domain/repository/push_notification_repository.dart';

import 'domain/use_cases/insert_token_fcm.dart';
import 'domain/use_cases/notification_local_usecases.dart';

class DependencyInjectionPushNotification {
  static init() async {

    /// ============================
    /// USE CASES REMOTOS
    /// ============================

    Get.lazyPut<InsertTokenFcmUseCase>(
          () => InsertTokenFcmUseCase(
        repository: Get.find(),
      ),
      fenix: true,
    );

    /// ============================
    /// USE CASES LOCALES
    /// ============================


    Get.lazyPut<GuardarNotificacionRemotaUseCase>(
          () => GuardarNotificacionRemotaUseCase(
        repository: Get.find(),
      ),
      fenix: true,
    );

    Get.lazyPut<GuardarNotificacionUseCase>(
          () => GuardarNotificacionUseCase(
        repository: Get.find(),
      ),
      fenix: true,
    );

    Get.lazyPut<ObtenerNotificacionesUseCase>(
          () => ObtenerNotificacionesUseCase(
        repository: Get.find(),
      ),
      fenix: true,
    );

    Get.lazyPut<MarcarNotificacionLeidaUseCase>(
          () => MarcarNotificacionLeidaUseCase(
        repository: Get.find(),
      ),
      fenix: true,
    );

    Get.lazyPut<ObtenerCantidadNoLeidasUseCase>(
          () => ObtenerCantidadNoLeidasUseCase(
        repository: Get.find(),
      ),
      fenix: true,
    );

    Get.lazyPut<EliminarNotificacionUseCase>(
          () => EliminarNotificacionUseCase(
        repository: Get.find(),
      ),
      fenix: true,
    );

    Get.lazyPut<EliminarTodasNotificacionesUseCase>(
          () => EliminarTodasNotificacionesUseCase(
        repository: Get.find(),
      ),
      fenix: true,
    );

    /// ============================
    /// REPOSITORY REMOTO
    /// ============================

    Get.lazyPut<PushNotificationRepository>(
          () => PushNotificationRepositoryImpl(
        pushNotificationRemoteDataSource: Get.find(),
      ),
      fenix: true,
    );

    /// ============================
    /// REPOSITORY LOCAL
    /// ============================

    Get.lazyPut<PushNotificationLocalRepository>(
          () => PushNotificationLocalRepositoryImpl(
        pushNotificationLocalDataSource: Get.find(),
      ),
      fenix: true,
    );

    /// ============================
    /// DATA SOURCE REMOTO
    /// ============================

    Get.lazyPut<PushNotificationRemoteDataSource>(
          () => PusNotificationFirebaseRemoteDataSourceImpl(),
      fenix: true,
    );

    /// ============================
    /// DATA SOURCE LOCAL
    /// ============================

    Get.lazyPut<PushNotificationLocalDataSource>(
          () => PushNotificationLocalDataSourceImpl(),
      fenix: true,
    );


//Registro el Servicio
    Get.put<NotificationService>(
      NotificationService(),
      permanent: true,
    );
  }
}
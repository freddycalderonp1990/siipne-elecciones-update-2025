

import 'package:siipnemovil2/feactures/pushNotification/domain/request/request_push_notification.dart';




import '../../domain/repository/push_notification_repository.dart';
import '../data_sources/push_notification_remote_data_source.dart';
import '../models/models_push_notification.dart';

class PushNotificationRepositoryImpl implements PushNotificationRepository {
  final PushNotificationRemoteDataSource pushNotificationRemoteDataSource;


  PushNotificationRepositoryImpl({required this.pushNotificationRemoteDataSource});



  @override
  Future<bool> insertarToken({required PushTokenRequest request}) async {
    return pushNotificationRemoteDataSource.insertarToken(request: request);
  }

}

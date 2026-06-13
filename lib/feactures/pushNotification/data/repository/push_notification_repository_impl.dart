

import 'package:siipnemovil2/feactures/pushNotification/domain/request/request_push_notification.dart';

import '../../domain/entities/user.dart';
import '../../domain/mappers/mappers.dart';


import '../../domain/repository/push_notification_repository.dart';
import '../data_sources/push_notification_remote_data_source.dart';
import '../models/models_user.dart';

class PushNotificationRepositoryImpl implements PushNotificationRepository {
  final PushNotificationRemoteDataSource pushNotificationRemoteDataSource;


  PushNotificationRepositoryImpl({required this.pushNotificationRemoteDataSource});



  @override
  Future<bool> insertarToken({required PushTokenRequest request}) async {
    return pushNotificationRemoteDataSource.insertarToken(request: request);
  }

}

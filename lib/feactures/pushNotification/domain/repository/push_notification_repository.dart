


import '../request/request_push_notification.dart';

abstract class PushNotificationRepository {
  Future<bool> insertarToken({required PushTokenRequest request});



}

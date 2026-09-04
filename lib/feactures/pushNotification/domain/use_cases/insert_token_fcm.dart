
import '../../data/models/models_push_notification.dart';
import '../repository/push_notification_repository.dart';
import '../request/request_push_notification.dart';


class InsertTokenFcmUseCase {
  final PushNotificationRepository repository;

  InsertTokenFcmUseCase({required this.repository});

  Future<bool> call({required PushTokenRequest request}) {
    return repository.insertarToken(request: request);
  }
}

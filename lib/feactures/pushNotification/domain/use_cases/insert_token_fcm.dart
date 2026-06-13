
import '../../data/models/models_user.dart';
import '../repository/push_notification_repository.dart';
import '../request/request_push_notification.dart';


class InsertTopkenFcmUseCase {
  final PushNotificationRepository repository;

  InsertTopkenFcmUseCase({required this.repository});

  Future<bool> call({required PushTokenRequest request}) {
    return repository.insertarToken(request: request);
  }
}

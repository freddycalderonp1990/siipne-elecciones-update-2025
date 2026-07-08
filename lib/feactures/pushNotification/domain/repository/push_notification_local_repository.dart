import '../../data/models/models_push_notification.dart';
import '../request/request_push_notification.dart';

abstract class PushNotificationLocalRepository {

  Future<List<NotificationLocalModel>> obtenerNotificaciones({
    required int idGenUsuario,
  });

  Future<int> eliminarTodas({
    required int idGenUsuario,
  });

  Future<int> obtenerCantidadNoLeidas({
    required int idGenUsuario,
  });

  Future<int> guardarNotificacion({
    required NotificationLocalModel notification,
  });



  Future<int> marcarComoLeida({required int id});

  Future<int> eliminarNotificacion({required int id});






}

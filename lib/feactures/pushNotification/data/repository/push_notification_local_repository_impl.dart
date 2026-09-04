import '../../domain/repository/push_notification_local_repository.dart';

import '../data_sources/push_notification_local_data_source.dart';

import '../models/models_push_notification.dart';

class PushNotificationLocalRepositoryImpl
    implements PushNotificationLocalRepository {
  final PushNotificationLocalDataSource pushNotificationLocalDataSource;

  PushNotificationLocalRepositoryImpl({
    required this.pushNotificationLocalDataSource,
  });

  @override
  Future<int> eliminarNotificacion({required int id}) async {
    return await pushNotificationLocalDataSource.eliminarNotificacion(id: id);
  }

  @override
  Future<int> eliminarTodas({required int idGenUsuario}) async {
    return await pushNotificationLocalDataSource.eliminarTodas(
      idGenUsuario: idGenUsuario,
    );
  }

  @override
  Future<int> guardarNotificacion({
    required NotificationLocalModel notification,
  }) async {
    return await pushNotificationLocalDataSource.guardarNotificacion(
      notification: notification,
    );
  }

  @override
  Future<int> marcarComoLeida({required int id}) async {
    return await pushNotificationLocalDataSource.marcarComoLeida(id: id);
  }

  @override
  Future<int> obtenerCantidadNoLeidas({required int idGenUsuario}) async {
    return await pushNotificationLocalDataSource.obtenerCantidadNoLeidas(
      idGenUsuario: idGenUsuario,
    );
  }

  @override
  Future<List<NotificationLocalModel>> obtenerNotificaciones({
    required int idGenUsuario,
  }) async {
    return await pushNotificationLocalDataSource.obtenerNotificaciones(
      idGenUsuario: idGenUsuario,
    );
  }
}

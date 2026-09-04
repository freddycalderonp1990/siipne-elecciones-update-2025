import '../../../user/data/data_sources/local_storage_data_source.dart';
import '../../../user/domain/use_cases/local_store.dart';
import '../../data/models/models_push_notification.dart';
import '../repository/push_notification_local_repository.dart';

/// =======================================================
/// Guardar Notificación
/// =======================================================

class GuardarNotificacionUseCase {
  final PushNotificationLocalRepository repository;

  GuardarNotificacionUseCase({
    required this.repository,
  });

  Future<int> call({
    required NotificationLocalModel notification,
  }) {
    return repository.guardarNotificacion(
      notification: notification,
    );
  }
}

/// =======================================================
/// Obtener Notificaciones
/// =======================================================

class ObtenerNotificacionesUseCase {
  final PushNotificationLocalRepository repository;

  ObtenerNotificacionesUseCase({
    required this.repository,
  });

  Future<List<NotificationLocalModel>> call() async {

    final LocalStorageDataSource localStorage =
    LocalStorageDataSourceImpl();

    final idGenUsuario =
        await localStorage.getLastIdGenUsuario();

    return repository.obtenerNotificaciones(idGenUsuario: idGenUsuario);

  }
}

/// =======================================================
/// Marcar como Leída
/// =======================================================

class MarcarNotificacionLeidaUseCase {
  final PushNotificationLocalRepository repository;

  MarcarNotificacionLeidaUseCase({
    required this.repository,
  });

  Future<int> call({
    required int id,
  }) {
    return repository.marcarComoLeida(
      id: id,
    );
  }
}

/// =======================================================
/// Obtener Cantidad de No Leídas
/// =======================================================

class ObtenerCantidadNoLeidasUseCase {
  final PushNotificationLocalRepository repository;

  ObtenerCantidadNoLeidasUseCase({
    required this.repository,
  });

  Future<int> call() async {

    final LocalStorageDataSource localStorage =
    LocalStorageDataSourceImpl();

    final idGenUsuario =
        await localStorage.getLastIdGenUsuario();


    return repository.obtenerCantidadNoLeidas(idGenUsuario: idGenUsuario);
  }
}

/// =======================================================
/// Eliminar Notificación
/// =======================================================

class EliminarNotificacionUseCase {
  final PushNotificationLocalRepository repository;

  EliminarNotificacionUseCase({
    required this.repository,
  });

  Future<int> call({
    required int id,
  }) {
    return repository.eliminarNotificacion(
      id: id,
    );
  }
}

/// =======================================================
/// Eliminar Todas las Notificaciones
/// =======================================================

class EliminarTodasNotificacionesUseCase {
  final PushNotificationLocalRepository repository;

  EliminarTodasNotificacionesUseCase({
    required this.repository,
  });

  Future<int> call() async {
    final LocalStorageDataSource localStorage =
    LocalStorageDataSourceImpl();

    final idGenUsuario =
        await localStorage.getLastIdGenUsuario();
    return repository.eliminarTodas(idGenUsuario: idGenUsuario);
  }
}


/// =======================================================
/// Guardar una notificación recibida desde Firebase
/// =======================================================

class GuardarNotificacionRemotaUseCase {
  final PushNotificationLocalRepository repository;

  GuardarNotificacionRemotaUseCase({
    required this.repository,
  });

  Future<int> call({
    required NotificationModel notification,
    required int idGenUsuario
  }) {
    final local = NotificationLocalModel.fromRemote(notification,idGenUsuario: idGenUsuario);

    return repository.guardarNotificacion(
      notification: local,
    );
  }
}
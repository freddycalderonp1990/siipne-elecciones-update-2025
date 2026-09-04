import 'package:get/get.dart';

import '../data/models/models_push_notification.dart';
import '../domain/use_cases/notification_local_usecases.dart';

class NotificationService extends GetxService {

  /// Lista de notificaciones
  final RxList<NotificationLocalModel> lista =
      <NotificationLocalModel>[].obs;

  /// Cantidad no leídas
  final RxInt cantidadNoLeidas = 0.obs;

  late final ObtenerNotificacionesUseCase
  _obtenerNotificacionesUseCase;

  late final ObtenerCantidadNoLeidasUseCase
  _obtenerCantidadNoLeidasUseCase;

  late final MarcarNotificacionLeidaUseCase
  _marcarNotificacionLeidaUseCase;

  late final EliminarNotificacionUseCase
  _eliminarNotificacionUseCase;

  @override
  void onInit() {
    super.onInit();

    _obtenerNotificacionesUseCase = Get.find();
    _obtenerCantidadNoLeidasUseCase = Get.find();
    _marcarNotificacionLeidaUseCase = Get.find();
    _eliminarNotificacionUseCase = Get.find();

    cargar();
  }

  Future<void> eliminarNotificacion(
      NotificationLocalModel notification) async {

    if (notification.id == null) return;

    await _eliminarNotificacionUseCase(
      id: notification.id!,
    );

    await cargar();
  }

  /// Carga toda la información desde SQLite
  Future<void> cargar() async {

    lista.value =
    await _obtenerNotificacionesUseCase();

    cantidadNoLeidas.value =
    await _obtenerCantidadNoLeidasUseCase();
  }

  /// Marca una notificación como leída
  Future<void> marcarComoLeida(
      NotificationLocalModel notification) async {

    if (notification.id == null) return;

    await _marcarNotificacionLeidaUseCase(
      id: notification.id!,
    );

    await cargar();
  }

  /// Refresca solamente el contador
  Future<void> refrescarContador() async {

    cantidadNoLeidas.value =
    await _obtenerCantidadNoLeidasUseCase();
  }

  /// Refresca solamente la lista
  Future<void> refrescarLista() async {

    lista.value =
    await _obtenerNotificacionesUseCase();
  }
}
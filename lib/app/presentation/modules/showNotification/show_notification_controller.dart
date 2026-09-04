part of '../controllers.dart';

class ShowNotificationController extends GetxController {
  final loginController = Get.find<LoginController>();

  final NotificationService notificationService = Get.find();





  late UserEntities  user;


  Rx<DataMenu> dataShowNotification = DataMenu.empty().obs;
  RxBool showMenuCenso = false.obs;
  RxBool showMenuElecciones = false.obs;


  RxBool peticionServerState = false.obs;


  @override
  void onInit() async {



    super.onInit();
  }

  @override
  void onReady() {
    // TODO: Donde la vista ya se presento
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose

    super.onClose();
  }

  cerrarSession() {
    Get.toNamed(AppRoutes.SPLASH_APP);
  }


  Future<void> marcarComoLeida(int index) async {
    await notificationService.marcarComoLeida(
      notificationService.lista[index],
    );
  }

  Future<void> eliminarNotificacion(int index) async {
    await notificationService.eliminarNotificacion(
      notificationService.lista[index],
    );
  }









}

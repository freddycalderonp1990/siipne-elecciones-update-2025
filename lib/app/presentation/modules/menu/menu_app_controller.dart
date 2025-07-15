part of '../controllers.dart';

class MenuAppController extends GetxController {
  final loginController = Get.find<LoginController>();



  late UserEntities  user;

  RxBool peticionServerState = false.obs;
  @override
  void onInit() async {
    user=loginController.user.value;

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





}

part of '../controllers.dart';

class CensoPolicialController extends GetxController {
  final loginController = Get.find<LoginController>();






  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
    Get.back();
  }
}

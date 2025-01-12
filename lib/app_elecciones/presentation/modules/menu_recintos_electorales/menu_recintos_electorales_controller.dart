part of '../controllers.dart';

class MenuRecintosElectoralesController extends GetxController {
  final loginController = Get.find<LoginController>();
  final EleccionesProcesosApiImpl _eleccionesProcesosApiImpl =
      Get.find<EleccionesProcesosApiImpl>();

  final EleccionesRecintosApiImpl _eleccionesRecintosApiImpl =
      Get.find<EleccionesRecintosApiImpl>();

  RxList<DatosProcesoImg> listDatosProcesoImg = <DatosProcesoImg>[].obs;

 RecintosElectoralesAbiertos recintosElectoralesAbiertos =
      RecintosElectoralesAbiertos.empty();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late DataUser  user;

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

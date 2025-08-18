part of '../controllers.dart';

class MenuAppController extends GetxController {
  final loginController = Get.find<LoginController>();

  final  GetMenuAppUseCase getMenuAppUseCase=Get.find();


  late UserEntities  user;


  Rx<DataMenu> dataMenuApp = DataMenu.empty().obs;

  RxBool peticionServerState = false.obs;
  @override
  void onInit() async {
    user=loginController.user.value;
    await getDatosMenuApp();

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


  Future<void> getDatosMenuApp() async {
    peticionServerState(true);
    await ExceptionDialogos.manejarErroresShowDialogo(
          () async {
            dataMenuApp.value = await getMenuAppUseCase();
      },
    );
    peticionServerState(false);
  }





}

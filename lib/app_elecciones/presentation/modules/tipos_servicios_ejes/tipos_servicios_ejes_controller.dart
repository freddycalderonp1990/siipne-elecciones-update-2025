part of '../controllers.dart';

class TiposServiciosEjesController extends GetxController {
  final loginController = Get.find<LoginController>();

  final selectProcesoOperativoController =
      Get.find<SelectProcesoOperativoController>();

  final EleccionesTipoEjesApiImpl _eleccionesTipoEjesApiImpl =
      Get.find<EleccionesTipoEjesApiImpl>();

  Rx<TipoEjesActivos> tipoEjesActivos = TipoEjesActivos.empty().obs;

  late DataUser user;

  RxBool peticionServerState = false.obs;
  @override
  void onInit() async {
    user = loginController.user.value;
    getTipoEjesActivosEnProcesoOperativos();

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

  Future<void> getTipoEjesActivosEnProcesoOperativos() async {
    peticionServerState(true);
    await ExceptionHelper.manejarErroresShowDialogo(() async {
      tipoEjesActivos.value = await
          _eleccionesTipoEjesApiImpl.getTipoEjesActivosEnProcesoOperativos(
              usuario: user.idGenUsuario,
              idDgoProcElec: selectProcesoOperativoController
                  .selectProcesosOperativo.value.idDgoProcElec);
    });
    peticionServerState(false);


  }

  goToPage(String name) {
    Get.offNamed(name);
  }

  cerrarSession() {
    Get.toNamed(AppRoutes.SPLASH_APP);
  }
}

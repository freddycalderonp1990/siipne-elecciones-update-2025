part of '../controllers.dart';

class MenuAppController extends GetxController {
  final LocalStoreImpl _localStoreImpl = Get.find<LocalStoreImpl>();

  final ProcesosEleccionesApiImpl _procesosEleccionesApiImpl =
      Get.find<ProcesosEleccionesApiImpl>();

  RxList<DatosProcesoImg> listDatosProcesoImg = <DatosProcesoImg>[].obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxBool peticionServerState = false.obs;
  @override
  void onInit() async {
    getImgProceso();
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

  Future<void> getImgProceso() async {
    peticionServerState(true);
    await ExceptionHelper.manejarErrores(() async {
      listDatosProcesoImg.value =
          await _procesosEleccionesApiImpl.getProcesoActivoImgs();
    });

    if(listDatosProcesoImg.length>0){
      SiipneImages.imgCabeceraProceso.value=listDatosProcesoImg[0].imgBase64;
    }


    peticionServerState(false);
  }

  gotoToPage(String data) {
    Get.toNamed(SiipneRoutes.CATALOGO, arguments: {'data': data});
  }
}

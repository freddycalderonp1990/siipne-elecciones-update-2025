part of '../controllers.dart';

class SelectProcesoOperativoController extends GetxController {
  final loginController = Get.find<LoginController>();

  RxBool cargaInicial=false.obs;

  final EleccionesProcesosApiImpl _eleccionesProcesosApiImpl =
      Get.find<EleccionesProcesosApiImpl>();

  RxList<ProcesosOperativo> listProcesosOperativo = <ProcesosOperativo>[].obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late DataUser user;

  RxBool peticionServerState = false.obs;
  @override
  void onInit() async {
    user = loginController.user.value;
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

  Future<void> getProcesoOperativos() async {
    print("consultando");

    peticionServerState(true);
    cargaInicial.value=true;

    await ExceptionHelper.manejarErrores(() async {
      final locationBloc = BlocProvider.of<LocationBloc>(Get.context!);
      LatLng position = await locationBloc.getCurrentPosition();

      listProcesosOperativo.value =
          await _eleccionesProcesosApiImpl.getProcesosOperativos(
              latitud: position.latitude, longitud: position.longitude);
      if(listProcesosOperativo.length==0){
        DialogosAwesome.getInformation(descripcion: "Actualmente no hay procesos activos disponibles. Por favor, inténtelo más tarde.");
     return;
      }

      if(listProcesosOperativo.length==1){

      }



    });



    peticionServerState(false);



  }
}

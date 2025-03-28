part of '../controllers.dart';

class MenuAppController extends GetxController {
  final loginController = Get.find<LoginController>();
  final EleccionesProcesosApiImpl _eleccionesProcesosApiImpl =
      Get.find<EleccionesProcesosApiImpl>();

  final EleccionesRecintosApiImpl _eleccionesRecintosApiImpl =
      Get.find<EleccionesRecintosApiImpl>();


 RecintosElectoralesAbiertos recintosElectoralesAbiertos =
      RecintosElectoralesAbiertos.empty();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late UserEntities  user;

  RxBool peticionServerState = false.obs;
  @override
  void onInit() async {
    user=loginController.user.value;
   await getImgProceso();
    verificarperAsignadoRecElectoral();

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

  Future<void> verificarperAsignadoRecElectoral() async {
    peticionServerState(true);
    await ExceptionHelper.manejarErroresShowDialogo(() async {
      int idGenPersona = user.idGenPersona;
      recintosElectoralesAbiertos = await _eleccionesRecintosApiImpl
          .verificarperAsignadoRecElectoral(idGenPersona: idGenPersona);
    });
    peticionServerState(false);
    print("a ${recintosElectoralesAbiertos.codigoRecinto}");

    if(recintosElectoralesAbiertos.idDgoCreaOpReci==0){

      print("No tengo codigo me quedo en la misma pantalla");
      return;
    }


      if (recintosElectoralesAbiertos.isJefe) {
        //Menu Recintos Electorales
        print('Menu Recintos Electorales');
        goToPage(SiipneRoutes.MENU_RECINTOS_ELECTORALES_JEFE,);

      } else {
        //Menu Unidades Policiales u Otros
        goToPage(SiipneRoutes.MENU_RECINTOS_ELECTORALES_INTEGRANTE,);
      }

  }

  Future<void> getImgProceso() async {
    peticionServerState(true);

    List<DatosProcesoImg> listDatosProcesoImg = <DatosProcesoImg>[];
    await ExceptionHelper.manejarErroresShowDialogo(() async {
      listDatosProcesoImg =
          await _eleccionesProcesosApiImpl.getProcesoActivoImgs();
    });

    if (listDatosProcesoImg.length > 0) {
      SiipneImages.imgCabeceraProceso.value = listDatosProcesoImg[0].imgBase64;
    }

    peticionServerState(false);
  }


  goToPage(String name){
    Get.offAllNamed(name,arguments:{"recintosElectoralesAbiertos":recintosElectoralesAbiertos} );


  }


  cerrarSession() {
    Get.toNamed(AppRoutes.SPLASH_APP);
  }
}

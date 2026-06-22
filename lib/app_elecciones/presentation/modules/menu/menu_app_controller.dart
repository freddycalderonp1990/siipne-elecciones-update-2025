part of '../controllers.dart';

class MenuAppEleccionesController extends GetxController {
  final loginController = Get.find<LoginController>();

  final EleccionesProcesosApiImpl _eleccionesProcesosApiImpl =
  Get.find<EleccionesProcesosApiImpl>();

  final EleccionesRecintosApiImpl _eleccionesRecintosApiImpl =
      Get.find<EleccionesRecintosApiImpl>();

  final EleccionesNovedadesApiImpl _eleccionesNovedadesApiImpl =
  Get.find<EleccionesNovedadesApiImpl>();


 RecintosElectoralesAbiertos recintosElectoralesAbiertos =
      RecintosElectoralesAbiertos.empty();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late UserEntities  user;

  int idDgoProcElec=0;

  RxBool peticionServerState = false.obs;
  @override
  void onInit() async {
    user=loginController.user.value;

    await verificarNovedadesRegistradasProcElect();

    verificarperAsignadoRecElectoral();

    super.onInit();
  }

  @override
  void onReady() {
    // TODO: Donde la vista ya se presento
    //no xq usa blocprovider
    /*Get.find<NotificationsBloc>().requestPermission(
      appName: NamApps.Elecciones,
      idGenUsuario: user.idGenUsuario,
    );*/
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose

    super.onClose();
  }

  Future<void> verificarperAsignadoRecElectoral() async {
    peticionServerState(true);
    await ExceptionDialogos.manejarErroresShowDialogo(() async {
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
        goToPage(EleccionesRoutes.MENU_RECINTOS_ELECTORALES_JEFE,);

      } else {
        //Menu Unidades Policiales u Otros
        goToPage(EleccionesRoutes.MENU_RECINTOS_ELECTORALES_INTEGRANTE,);
      }

  }




  goToPage(String name){
    Get.offAllNamed(name,arguments:{"recintosElectoralesAbiertos":recintosElectoralesAbiertos} );


  }


  cerrarSession() {
    Get.toNamed(AppRoutes.SPLASH_APP);
  }


  Future<void> getImgProceso() async {
    //peticionServerState(true);

    List<DatosProcesoImg> listDatosProcesoImg = <DatosProcesoImg>[];
    await ExceptionDialogos.manejarErroresShowDialogo(() async {
      listDatosProcesoImg =
      await _eleccionesProcesosApiImpl.getProcesoActivoImgs();
    });

    if (listDatosProcesoImg.length > 0) {
      SiipneEleccionesImages.imgCabeceraProceso.value = listDatosProcesoImg[0].imgBase64;
      idDgoProcElec=listDatosProcesoImg[0].idDgoProcElec;
    }

    //peticionServerState(false);
  }

  Future<void> verificarNovedadesRegistradasProcElect() async {
    peticionServerState(true);
    await getImgProceso();


    await ExceptionDialogos.manejarErroresShowDialogo(() async {

      DataNovedadesUdga data =
      await _eleccionesNovedadesApiImpl.verificarNovedadesRegistradasByProcElect(idGenPersona: user.idGenPersona,idDgoProcElec: idDgoProcElec);

      if (data.session == false) {
        String msj=data.motivo.replaceAll("No Puede iniciar Session", "");
        // msj="No puede continuar, ya que tiene registrado lo siguiente:\n${msj}";
        msj="Usted se encuentra inactivo para este proceso. Por favor, coordine con Talento Humano.";
        DialogosAwesome.getError(
          title: "Acción no permitida",
            descripcion: msj,btnOkOnPress: (){
              Get.back();
              Get.back();
        });
        return;
      }




    });
    peticionServerState(false);
  }

}

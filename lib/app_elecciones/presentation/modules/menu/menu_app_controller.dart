part of '../controllers.dart';

class MenuAppEleccionesController extends GetxController {
  final loginController = Get.find<LoginController>();

  final EleccionesProcesosApiImpl _eleccionesProcesosApiImpl =
  Get.find<EleccionesProcesosApiImpl>();

  final EleccionesRecintosApiImpl _eleccionesRecintosApiImpl =
      Get.find<EleccionesRecintosApiImpl>();

  final EleccionesNovedadesApiImpl _eleccionesNovedadesApiImpl =
  Get.find<EleccionesNovedadesApiImpl>();

  Rx<ProcesosOperativo> selectProcesosOperativo=ProcesosOperativo.empty().obs;

  RxBool showValidarRecinto1 = false.obs;


 RecintosElectoralesAbiertos recintosElectoralesAbiertos =
      RecintosElectoralesAbiertos.empty();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late UserEntities  user;



  RxBool peticionServerState = false.obs;
  @override
  void onInit() async {
    user=loginController.user.value;


    super.onInit();
  }

  @override
  void onReady() async {
    // TODO: Donde la vista ya se presento

    final locationBloc = BlocProvider.of<LocationBloc>(Get.context!);
    LatLng position = await locationBloc.getCurrentPosition();

    await verificarNovedadesRegistradasProcElect( position);

    verificarperAsignadoRecElectoral();
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





  Future<void> getProcesos( LatLng position) async {
    //peticionServerState(true);

    List<ProcesosOperativo> listProcesos = <ProcesosOperativo>[];

    await ExceptionDialogos.manejarErroresShowDialogo(() async {

      listProcesos =
      await _eleccionesProcesosApiImpl.getProcesosOperativos(
          latitud: position.latitude, longitud: position.longitude);
    });




    if (listProcesos.length > 0) {
      if(listProcesos.length==1){
        print("valida recinto ${listProcesos[0].validarRecinto}");

       selectProcesosOperativo.value =listProcesos[0];

      //  showValidarRecinto.value=selectProcesosOperativo.validarRecinto;


      }

    }

    //peticionServerState(false);
  }

  Future<void> verificarNovedadesRegistradasProcElect( LatLng position) async {
    peticionServerState(true);
    await getProcesos(position);


    await ExceptionDialogos.manejarErroresShowDialogo(() async {

      DataNovedadesUdga data =
      await _eleccionesNovedadesApiImpl.verificarNovedadesRegistradasByProcElect(idGenPersona: user.idGenPersona,idDgoProcElec: selectProcesosOperativo.value.idDgoProcElec);

      if (data.session == false) {
        String msj=data.motivo.replaceAll("No Puede iniciar Session", "");
        // msj="No puede continuar, ya que tiene registrado lo siguiente:\n${msj}";
       // msj="Usted se encuentra inactivo para este proceso. Por favor, coordine con Talento Humano.";
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

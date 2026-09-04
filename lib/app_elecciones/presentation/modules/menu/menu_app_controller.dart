part of '../controllers.dart';

class MenuAppEleccionesController extends GetxController {
  final loginController=Get.find<LoginController>();

  final EleccionesProcesosApiImpl _eleccionesProcesosApiImpl=Get.find<EleccionesProcesosApiImpl>();
  final EleccionesRecintosApiImpl _eleccionesRecintosApiImpl=Get.find<EleccionesRecintosApiImpl>();
  final EleccionesNovedadesApiImpl _eleccionesNovedadesApiImpl=Get.find<EleccionesNovedadesApiImpl>();

  Rx<ProcesosOperativo> selectProcesosOperativo=ProcesosOperativo.empty().obs;
  RxBool showValidarRecinto1=false.obs;

  RecintosElectoralesAbiertos recintosElectoralesAbiertos=RecintosElectoralesAbiertos.empty();

  GlobalKey<FormState> formKey=GlobalKey<FormState>();

  late UserEntities user;

  RxBool peticionServerState=true.obs;

  @override
  void onInit(){
    super.onInit();
    user=loginController.user.value;
    _inicializarModulo();
  }

  @override
  void onReady(){
    super.onReady();
  }

  @override
  void onClose(){
    super.onClose();
  }

  Future<void> _inicializarModulo() async {
    peticionServerState(true);

    try{
      final locationBloc=BlocProvider.of<LocationBloc>(Get.context!);

      LatLng position=await locationBloc.getCurrentPosition();

      await getProcesos(position);

      bool puedeContinuar=await verificarNovedadesRegistradasProcElect(position);

      if(!puedeContinuar)return;

      await verificarperAsignadoRecElectoral();
    }catch(e){
      print("Error inicializando módulo elecciones: $e");
    }finally{
      peticionServerState(false);
    }
  }

  Future<void> verificarperAsignadoRecElectoral() async {
    await ExceptionDialogos.manejarErroresShowDialogo(() async {
      int idGenPersona=user.idGenPersona;

      recintosElectoralesAbiertos=await _eleccionesRecintosApiImpl.verificarperAsignadoRecElectoral(
        idGenPersona:idGenPersona,
      );
    });

    print("a ${recintosElectoralesAbiertos.codigoRecinto}");

    if(recintosElectoralesAbiertos.idDgoCreaOpReci==0){
      print("No tengo codigo me quedo en la misma pantalla");
      return;
    }

    if(recintosElectoralesAbiertos.isJefe){
      print('Menu Recintos Electorales');
      goToPage(EleccionesRoutes.MENU_RECINTOS_ELECTORALES_JEFE);
    }else{
      goToPage(EleccionesRoutes.MENU_RECINTOS_ELECTORALES_INTEGRANTE);
    }
  }

  void goToPage(String name){
    Get.offAllNamed(
      name,
      arguments:{
        "recintosElectoralesAbiertos":recintosElectoralesAbiertos,
      },
    );
  }

  void cerrarSession(){
    Get.toNamed(AppRoutes.SPLASH_APP);
  }

  Future<void> getProcesos(LatLng position) async {
    List<ProcesosOperativo> listProcesos=<ProcesosOperativo>[];

    await ExceptionDialogos.manejarErroresShowDialogo(() async {
      listProcesos=await _eleccionesProcesosApiImpl.getProcesosOperativos(
        latitud:position.latitude,
        longitud:position.longitude,
      );
    });

    if(listProcesos.isNotEmpty){
      if(listProcesos.length==1){
        print("valida recinto ${listProcesos[0].validarRecinto}");

        selectProcesosOperativo.value=listProcesos[0];
      }
    }
  }

  Future<bool> verificarNovedadesRegistradasProcElect(LatLng position) async {
    bool puedeContinuar=true;

    await ExceptionDialogos.manejarErroresShowDialogo(() async {
      DataNovedadesUdga data=await _eleccionesNovedadesApiImpl.verificarNovedadesRegistradasByProcElect(
        idGenPersona:user.idGenPersona,
        idDgoProcElec:selectProcesosOperativo.value.idDgoProcElec,
      );

      if(data.session==false){
        puedeContinuar=false;

        String msj=data.motivo.replaceAll("No Puede iniciar Session","");

        DialogosAwesome.getError(
          title:"Acción no permitida",
          descripcion:msj,
          btnOkOnPress:(){
            Get.back();
            Get.back();
          },
        );
      }
    });

    return puedeContinuar;
  }
}
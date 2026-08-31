part of '../controllers.dart';

class MenuAppController extends GetxController {
  final loginController = Get.find<LoginController>();

  final  GetMenuAppUseCase getMenuAppUseCase=Get.find();


  final EleccionesNovedadesApiImpl _eleccionesNovedadesApiImpl =
  Get.find<EleccionesNovedadesApiImpl>();


  late UserEntities  user;


  Rx<DataMenu> dataMenuApp = DataMenu.empty().obs;
  RxBool showMenuCenso = false.obs;
  RxBool showMenuElecciones = false.obs;


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


            if(dataMenuApp.value.siipneElecciones){
              showMenuElecciones.value=true;
              showMenuCenso.value=false;

            }
            else  {
              showMenuElecciones.value=false;
              showMenuCenso.value=true;
              Get.offAllNamed(AppCensoRoutes.MENU_APP);

            }

            //todo: Comentado para mostra los dos menus

            //cambiar borara estas lineas
            //showMenuElecciones.value=true;
            //showMenuCenso.value=true;
      },
    );
    peticionServerState(false);
  }



  Future<void> verificarNovedadesUdgaPolicialRegistradas() async {
    peticionServerState(true);


    await ExceptionDialogos.manejarErroresShowDialogo(() async {

      DataNovedadesUdga data =
      await _eleccionesNovedadesApiImpl.verificarNovedadesUdgaPolicialRegistradas(idGenPersona: user.idGenPersona,);

      if (data.session == false) {
        String msj=data.motivo.replaceAll("No Puede iniciar Session", "");
        msj="No puede continuar, ya que tiene registrado lo siguiente:\n${msj}";
        DialogosAwesome.getError(
         title: "Acción no permitida",
            descripcion: msj);
        return;
      }


      Get.toNamed(AppCensoRoutes.MENU_APP);



    });
    peticionServerState(false);
  }








}

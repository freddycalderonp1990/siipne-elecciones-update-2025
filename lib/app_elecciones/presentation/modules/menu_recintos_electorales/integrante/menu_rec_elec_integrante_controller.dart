part of '../../controllers.dart';

class MenuRecElecIntegranteController extends GetxController {
  final loginController = Get.find<LoginController>();
  final EleccionesRecintosApiImpl _eleccionesRecintosApiImpl =
      Get.find<EleccionesRecintosApiImpl>();

  RxList<DatosProcesoImg> listDatosProcesoImg = <DatosProcesoImg>[].obs;

  RecintosElectoralesAbiertos recintosElectoralesAbiertos =
      RecintosElectoralesAbiertos.empty();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late UserEntities user;

  RxBool peticionServerState = false.obs;
  @override
  void onInit() async {
    user = loginController.user.value;
    getDataToPage();
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

  getDataToPage() async {
    // Recibe los argumentos
    final arguments = Get.arguments as Map<String, dynamic>?;

    // Verifica que los argumentos no sean nulos y que contengan la clave 'data'
    if (arguments != null &&
        arguments.containsKey('recintosElectoralesAbiertos')) {
      try {
        recintosElectoralesAbiertos = arguments['recintosElectoralesAbiertos']
            as RecintosElectoralesAbiertos;
      } catch (e) {
        DialogosAwesome.getError(descripcion: "No existe data valida");
      }
    } else {
      DialogosAwesome.getError(descripcion: "No existe data valida");
    }
  }

  Future<void> removePersonalOperativo() async {
    peticionServerState(true);

    await ExceptionHelper.manejarErroresShowDialogo(() async {
      String ip = await DeviceInfo.getIp;
      final locationBloc = BlocProvider.of<LocationBloc>(Get.context!);
      LatLng position = await locationBloc.getCurrentPosition();


      AbandonarRecintoRequest request= AbandonarRecintoRequest(
          idDgoPerAsigOpe: recintosElectoralesAbiertos.idDgoPerAsigOpe,
          usuario: user.idGenUsuario,
          latitud: position.latitude,
          longitud: position.longitude,
          idDgoProcElec: recintosElectoralesAbiertos.idDgoProcElec,
          idDgoReciElect: recintosElectoralesAbiertos.idDgoReciElect,
          ip: ip, idGenPersona: user.idGenPersona);

      bool result = await _eleccionesRecintosApiImpl.abandonarRecintoElectoral(
          request: request);

      if (result) {
        DialogosAwesome.getSucess(
            descripcion: "Proceso realizado con éxito!", btnOkOnPress: () {

          Get.offAllNamed(SiipneRoutes.MENU_APP);
        });

        return;
      }

      DialogosAwesome.getWarning(
          descripcion: "Ocurrio un error vuelva a intentar",
          btnOkOnPress: () {});
    });
    peticionServerState(false);
  }




  cerrarSession() {
    Get.toNamed(AppRoutes.SPLASH_APP);
  }


}

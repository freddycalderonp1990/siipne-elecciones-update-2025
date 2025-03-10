part of '../controllers.dart';

class MenuRecintosElectoralesController extends GetxController {
  final loginController = Get.find<LoginController>();
  final EleccionesRecintosApiImpl _eleccionesRecintosApiImpl =
      Get.find<EleccionesRecintosApiImpl>();

  RxList<DatosProcesoImg> listDatosProcesoImg = <DatosProcesoImg>[].obs;

  RecintosElectoralesAbiertos recintosElectoralesAbiertos =
      RecintosElectoralesAbiertos.empty();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late DataUser user;

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

  Future<void> eliminarCodigoRecinto() async {
    peticionServerState(true);
    String ip = await DeviceInfo.getIp;
    await ExceptionHelper.manejarErroresShowDialogo(() async {
      EliminarRecintoRequest request = EliminarRecintoRequest(
          usuario: user.idGenUsuario,
          ip: ip,
          idDgoCreaOpReci: recintosElectoralesAbiertos.idDgoCreaOpReci,
          idDgoProcElec: recintosElectoralesAbiertos.idDgoProcElec,
          idDgoReciElect: recintosElectoralesAbiertos.idDgoReciElect);

      String msjResponse= await _eleccionesRecintosApiImpl
          .eliminarRecintoElectoralAbierto(request: request);

      if (msjResponse== ApiConstantes.varTrue) {
        DialogosAwesome.getSucess(
            descripcion: "El código fue eliminado con éxito!");
        return;
      }

      DialogosAwesome.getWarning(descripcion: msjResponse,btnOkOnPress: (){});


    });

     peticionServerState(false);
  }

  cerrarSession() {
    Get.toNamed(AppRoutes.SPLASH_APP);
  }
}

part of '../../controllers.dart';

class MenuRecElecJefeController extends GetxController {
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


  Future<void> finalizarRecinto() async {
    peticionServerState(true);
    String ip = await DeviceInfo.getIp;

    int codigo=recintosElectoralesAbiertos.idDgoCreaOpReci;
    await ExceptionHelper.manejarErroresShowDialogo(() async {
      FinalizarRecintoRequest request = FinalizarRecintoRequest(
          usuario: user.idGenUsuario,
          ip: ip,
          idDgoCreaOpReci: codigo,
          idDgoProcElec: recintosElectoralesAbiertos.idDgoProcElec,
          idDgoReciElect: recintosElectoralesAbiertos.idDgoReciElect,
          idDgoPerAsigOpe: recintosElectoralesAbiertos.idDgoPerAsigOpe,
          idDgoTipoEje: recintosElectoralesAbiertos.idDgoTipoEje);

      datosFinalizarProceso dataResponse= await _eleccionesRecintosApiImpl
          .finalizarRecintoElectoral(request: request);

      if (dataResponse.insert) {
        DialogosAwesome.getSucess(
            descripcion: "El código ${codigo} fue finalizado con éxito!",btnOkOnPress: (){
          Get.offAllNamed(SiipneRoutes.MENU_APP );
        });
        return;
      }

      String msj="No se pudo finalizar el código ${codigo}."
          "\n\nLa Hora para finalizar es ${dataResponse.horaValidate}.";


      DialogosAwesome.getWarning(descripcion: msj,btnOkOnPress: (){

      });


    });

    peticionServerState(false);
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
      int codigo=recintosElectoralesAbiertos.idDgoCreaOpReci;
      if (msjResponse== ApiConstantes.varTrue) {

        DialogosAwesome.getSucess(
            descripcion: "El código ${codigo} fue eliminado con éxito!",btnOkOnPress: (){
          Get.offAllNamed(SiipneRoutes.MENU_APP );
        });
        return;
      }

      String msj="el código ${codigo}, no se pudo eliminar."

          "${msjResponse}"
          "\n\nVuelva a intentarlo, o consulte con el administrador del sistema";


      DialogosAwesome.getWarning(descripcion: msj,btnOkOnPress: (){
        goToPageReportePersonal();
      });


    });

     peticionServerState(false);
  }

  cerrarSession() {
    Get.toNamed(AppRoutes.SPLASH_APP);
  }

  goToPageReportePersonal() {
    Get.toNamed(SiipneRoutes.REPORT_PERSONAL, arguments: {
      "recintosElectoralesAbiertos": recintosElectoralesAbiertos
    });
  }
}

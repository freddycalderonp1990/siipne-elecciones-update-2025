part of '../../controllers.dart';

class ReportNovedadesController extends GetxController {
  final loginController = Get.find<LoginController>();

  RecintosElectoralesAbiertos recintosElectoralesAbiertos =
      RecintosElectoralesAbiertos.empty();

  final EleccionesNovedadesApiImpl _eleccionesNovedadesApiImpl =
      Get.find<EleccionesNovedadesApiImpl>();

  RxList<NovedadesElectoralesDetalle> listNovedadesElectorales =
      <NovedadesElectoralesDetalle>[].obs;

  late DataUser user;

  RxBool peticionServerState = false.obs;

  @override
  void onInit() async {
    user = loginController.user.value;

    getDataToPage();

    reportNovedadesa();

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


  Future<void> reportNovedadesa() async {
    peticionServerState(true);
    listNovedadesElectorales.clear();

    await ExceptionHelper.manejarErroresShowDialogo(() async {

      GetNovedadesRegistradasdRequest request=GetNovedadesRegistradasdRequest(
        idDgoReciElect: recintosElectoralesAbiertos.idDgoReciElect,
        idDgoProcElec: recintosElectoralesAbiertos.idDgoProcElec,
        idDgoCreaOpReci: recintosElectoralesAbiertos.idDgoCreaOpReci,
      );
      List<NovedadesElectoralesDetalle> datos =
          await _eleccionesNovedadesApiImpl.getDetalleNovedadesPorRecinto(request: request);

      if (datos.length == 0) {
        DialogosAwesome.getInformation(
            descripcion: "No existen datos que mostrar", btnOkOnPress: () {});
        return;
      }

      listNovedadesElectorales.value=datos;


    });
    peticionServerState(false);
  }
}

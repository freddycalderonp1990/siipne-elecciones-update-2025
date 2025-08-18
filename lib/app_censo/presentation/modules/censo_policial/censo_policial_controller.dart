part of '../controllers.dart';

class CensoPolicialController extends GetxController {
  final loginController = Get.find<LoginController>();

  final TotpCensoController totpCensoController =
      Get.find<TotpCensoController>();

  final FetchActiveProcessesByCensusPersonUseCase
  getDatosProcesosActivosByCensado = Get.find();



  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late UserEntities user;

  RxBool peticionServerState = false.obs;
  @override
  void onInit() async {
    user = loginController.user.value;

    super.onInit();
  }

  @override
  void onReady() async {

    // TODO: Donde la vista ya se presento
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose

    super.onClose();
  }

 /* Future<void> getDatosProcesoByCensado() async {
    peticionServerState(true);
    await ExceptionDialogos.manejarErroresShowDialogo(
      msjNoData:
          "No existen procesos activos o no está asignado a una mesa. 204",
      () async {
        GetDatosProcesosActivosRequest request = GetDatosProcesosActivosRequest(
          idGenPersonaCensado: user.idGenPersona,
        );
        dataCensado.value = await getDatosProcesosActivosByCensado(
          request: request,
        );
      },
    );

    if (dataCensado.length > 0) {
      DataCensado data = dataCensado[0];

      bool finalizado = data.estadoCenso.toLowerCase() == "finalizado";

      if (finalizado) {
        DialogosAwesome.getIconPolicia(
          title: "INFORMACIÓN",
          descripcion: "${user.nombres}\n\n USTED YA FUE CENSADO",
          btnOkOnPress: () {
            Get.back();
            Get.back();
          },
          titleBtnSi: "ACEPTAR",
          mostrarSegungoBtn: false,
        );
      } else {
        DialogosDesingWidget.getDialogo(
          contenido: DesingDatosCenso(
            dataCensado: dataCensado,
            onPressed: () {
              Get.back();
            },
          ),
          barrierDismissible: false,
        );
      }
    } else {
      Get.back(); //este cierra el mensaje que se muestra en manejarErroresShowDialogo y permite mostrar el siguinete dialogo
      DialogosAwesome.getInformation(
        descripcion:
            "No existen procesos activos o no está asignado a una mesa.",
        btnOkOnPress: () {
          Get.back();
          Get.back();
        },
      );
    }

    peticionServerState(false);
  }
*/
  cerrarSession() {
    Get.back();
  }
}

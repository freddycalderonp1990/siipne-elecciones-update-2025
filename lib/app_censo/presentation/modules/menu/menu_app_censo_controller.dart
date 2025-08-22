part of '../controllers.dart';

class MenuAppCensoController extends GetxController {
  final loginController = Get.find<LoginController>();
  final FetchActiveProcessesByCensusPersonUseCase
  getDatosProcesosActivosByCensado = Get.find();

  RxList<DataProceso> dataProcesos = <DataProceso>[].obs;

  GetMesasByIdusuarioUseCase getMesasByIdusuarioUseCase = Get.find();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late UserEntities user;

  RxBool peticionServerState = false.obs;
  RxList<DataMesa> dataMesasList = <DataMesa>[].obs;

  RxBool finalizaCenso = true.obs;

  RxBool showBtnIniciarCenso = false.obs;
  RxBool showBtnQuieroSerCensado = false.obs;
  RxBool isCensista = false.obs;

  @override
  void onInit() async {
    user = loginController.user.value;

     await  getDatosProcesoByCensado();
    await getDatosMesas();

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

  Future<void> getDatosMesas() async {
    peticionServerState(true);
    await ExceptionDialogos.manejarErroresShowDialogo(
      showMsjNodata: false,
      () async {
        GetMesasByIdusuarioRequest request = GetMesasByIdusuarioRequest(
          idGenUsuario: user.idGenUsuario,
        );
        dataMesasList.value = await getMesasByIdusuarioUseCase(
          request: request,
        );

        if(dataMesasList.length>0){
          isCensista.value=true;
          showBtnIniciarCenso.value=true;

        }
      },
    );

    peticionServerState(false);
  }

  cerrarSession() {
    Get.back();
  }

  Future<void> getDatosProcesoByCensado() async {
    peticionServerState(true);
    await ExceptionDialogos.manejarErroresShowDialogo(
      showMsjNodata: false,
      msjNoData:
          "No existen procesos activos o no está asignado a una mesa.",
      () async {
        GetDatosProcesosActivosRequest request = GetDatosProcesosActivosRequest(
          idGenPersonaCensado: user.idGenPersona,
        );
        dataProcesos.value = await getDatosProcesosActivosByCensado(
          request: request,
        );
      },
    );

    for (int i = 0; i < dataProcesos.length; i++) {
      DataProceso data = dataProcesos[i];
      bool finalizado = data.estadoCenso.toLowerCase() == "asignado";

      if (finalizado) {
        showBtnIniciarCenso.value=true;
        showBtnQuieroSerCensado.value=true;

        finalizaCenso.value = false;

        DialogosDesingWidget.getDialogoX(
          contenido: DesingDatosCenso(
            dataProcesos: dataProcesos,
            onPressed: () {
              Get.back();
              goToPageIniciarCenso();
            },
          ),
        );

        break;
      }
    }

    peticionServerState(false);
  }

  Future<bool> validarMesasCenso(List<DataMesa> dataMesasList) async {
   await getDatosMesas();

    bool mesasvalidadas = true;
    for (int i = 0; i < dataMesasList.length; i++) {
      DataMesa data = dataMesasList[i];
      if (data.latitud == 0 || data.longitud == 0) {
        mesasvalidadas = false;
        //Muestra cuando no tiene latitud ni longitud la mesa
        DialogosAwesome.getWarning(
          descripcion:
              "Para continuar, debe configurar las coordenadas de la ubicación de su mesa.\n[${data.descMesa}]"
              "\nAsegúrese de estar en el lugar exacto donde se realizará el censo para evitar inconvenientes.",
          btnOkOnPress: () {
            Get.toNamed(AppCensoRoutes.VALIDATE_MESA,arguments:{"mesa": data}  );
          },
        );
        break;
      }
    }
    if(mesasvalidadas){
      Get.toNamed(AppCensoRoutes.CENSISTA);
    }
    return mesasvalidadas;
  }

  goToPageIniciarCenso() {
    Get.toNamed(AppCensoRoutes.CENSO_POLICIAL );
  }
}

part of '../controllers.dart';

class MenuAppCensoController extends GetxController {
  final loginController = Get.find<LoginController>();
  final FetchActiveProcessesByCensusPersonUseCase
  getDatosProcesosActivosByCensado = Get.find();

  final DateTimeController clockController = Get.find();

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

  bool isCensoTodos=false;
  DataMesaResponse dataMesaResponse=DataMesaResponse.empty();
  @override
  void onInit() async {
    user = loginController.user.value;

     await  getDatosProcesoByCensado();
    await getDatosMesas();

    super.onInit();
  }

  @override
  void onReady() async {
    // TODO: Donde la vista ya se presento
    await clockController.getTimeServer();
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
         dataMesaResponse= await getMesasByIdusuarioUseCase(
          request: request,
        );

        dataMesasList.value = dataMesaResponse.mesas;
        if(dataMesasList.length>0){
          isCensista.value=true;
          showBtnIniciarCenso.value=true;
          isCensoTodos=dataMesaResponse.isCensoTodos;
        }
      },
    );

    peticionServerState(false);
  }

  cerrarSession() {
    Get.toNamed(AppRoutes.SPLASH_APP);
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
      Get.toNamed(AppCensoRoutes.CENSISTA,arguments:{"isCensoTodos": isCensoTodos,"DataMesaResponse": dataMesaResponse}  );
    }
    return mesasvalidadas;
  }

  goToPageIniciarCenso() {
    Get.toNamed(AppCensoRoutes.CENSO_POLICIAL  );
  }
}

part of '../controllers.dart';

class HistorialCensoController extends GetxController {
  final loginController = Get.find<LoginController>();
  final FetchDataHistoryCensusUseCase fetchDataHistoryCensusUseCase =
      Get.find();

  final DownloadPdfCensoUseCase downloadPdfCensoUseCase = Get.find();

  RxList<DataHistoryCenso> listHistoryCenso = <DataHistoryCenso>[].obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late UserEntities user;

  RxBool peticionServerState = false.obs;
  @override
  void onInit() async {
    user = loginController.user.value;

    super.onInit();
  }

  @override
  void onReady() {
    fetchDataHistoryCensus();
    // TODO: Donde la vista ya se presento
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose

    super.onClose();
  }

  Future<void> fetchDataHistoryCensus() async {
    peticionServerState(true);
    await ExceptionDialogos.manejarErroresShowDialogo(
      showMsjNodata: false,
      () async {
        GetMesasByIdusuarioRequest request = GetMesasByIdusuarioRequest(
          idGenUsuario: user.idGenUsuario,
        );
        listHistoryCenso.value = await fetchDataHistoryCensusUseCase(
          idPerCensado: user.idGenPersona,
        );

        if (listHistoryCenso.length == 0) {
          DialogosAwesome.getWarning(
            title: "Censos",
            descripcion: "No existen censos que mostrar",
          );
        }
      },
    );

    peticionServerState(false);
  }

  cerrarSession() {
    Get.back();
  }

  descargarPdfCenso({required DownloadPdfCensoRequest request}) async {
    peticionServerState(true);

    await ExceptionDialogos.manejarErroresShowDialogo(() async {
      String ruta = await downloadPdfCensoUseCase(request: request);

      peticionServerState(false);
      if (ruta == "") {
        DialogosAwesome.getError(descripcion: "Error al descargar el PDF");
      } else {
        Get.toNamed(AppRoutes.PDFVIEW, arguments: {'pathPdf': ruta});
      }
    });

    peticionServerState(false);
  }
}

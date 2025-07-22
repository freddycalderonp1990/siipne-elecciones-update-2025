part of '../controllers.dart';

class CensistaController extends GetxController {
  final loginController = Get.find<LoginController>();
  final SaveFileImgUseCase _saveFileImgUseCase = Get.find();

  final GetDatosPersonaCenso getDatosPersonaCenso = Get.find();

  Rx<DataCensado> dataCensado = DataCensado.empty().obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var controllerCodigoCenso = new TextEditingController();

  late UserEntities user;

  RxBool peticionServerState = false.obs;
  Rx<GaleryCameraModel?> mGaleryCameraModel = Rx<GaleryCameraModel?>(null);

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() async {
    controllerCodigoCenso.text = "93489";
    user = loginController.user.value;
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

  Future<void> consultarDatosSegunCodigo() async {
    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    String text = controllerCodigoCenso.text;
    int? codigoCenso = int.tryParse(text);

    int idDgpPerCenso = 0;
    if (codigoCenso != null) {
      idDgpPerCenso = codigoCenso;
    }
    peticionServerState(true);

    await ExceptionDialogos.manejarErroresShowDialogo(
      msjNoData: "No existen datos que mostrar...",
      () async {
        GetDatosPersonaCensoRequest request = GetDatosPersonaCensoRequest(
          idDgpPerCenso: idDgpPerCenso,
          idGenUsuarioCensista: user.idGenUsuario,
        );
        dataCensado.value = await getDatosPersonaCenso(request: request);
      },
    );

    peticionServerState(false);
  }

  Future<DataFile> featureGuardarFoto() async {
    DataFile dataFile = DataFile.empty();
    await ExceptionDialogos.manejarErroresShowDialogo(() async {
      String path = dotenv.env['PATH_IMG_APP_CENSO'] ?? '';
      // path=path+"${dataCensado.value.idGenProcesoCenso}/";

      String nameFile =
          "Censo_${dataCensado.value.idGenProcesoCenso}_idPer_${dataCensado.value.idGenPersona}_idDgpPerCenso_" +
          dataCensado.value.idDgpPerCenso.toString() +
          "_";
      FileRequest request = FileRequest(
        file: mGaleryCameraModel.value!.imageFile,
        path: path,
        nameFile: nameFile,
      );

      peticionServerState(true);
      dataFile = await _saveFileImgUseCase(request: request);

      peticionServerState(false);

      if (!dataFile.result) {
        DialogosAwesome.getIconPolicia(
          title: "Guardar Imagen",
          descripcion: "No se pudo guardar la Imagen",
          btnOkOnPress: () {
            Get.back();
          },
          mostrarSegungoBtn: false,
        );
      }
    });
    peticionServerState(false);

    return dataFile;
  }
}

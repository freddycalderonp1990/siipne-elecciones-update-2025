part of '../controllers.dart';

class CensistaController extends GetxController {
  final loginController = Get.find<LoginController>();
  final SaveFileImgUseCase _saveFileImgUseCase = Get.find();
  final GetFotoDgpByDocumentoUseCase _getFotoDgpByDocumentoUseCase= Get.find();
  final SaveCensusPersonPhotoUseCase _SaveCensusPersonPhotoUseCase = Get.find();

  final FetchCensusPersonDataUseCase getDatosPersonaCenso = Get.find();

  RxList<DataCensado> dataCensadoList = <DataCensado>[].obs;
  Rx<DataCensado> dataCensado = DataCensado.empty().obs;

  Rx<DataFoto> dataFotoDgp=DataFoto.empty().obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var controllerCodigoCenso = new TextEditingController();

  late UserEntities user;

  RxBool peticionServerState = false.obs;
  Rx<GaleryCameraModel?> mGaleryCameraModel = Rx<GaleryCameraModel?>(null);

  final ScrollController scrollController = ScrollController();

  int idDgpPerCenso = 0;

  RxBool showBtnValidarFoto=false.obs;

  @override
  void onInit() async {
    controllerCodigoCenso.text = "93498";
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
        dataCensadoList.value = await getDatosPersonaCenso(request: request);
        dataCensado.value = dataCensadoList[0];
        if (dataCensado.value.censado) {
          String name =
              "${dataCensado.value.siglas}. ${dataCensado.value.apenom}";
          DialogosAwesome.getInformation(
            descripcion: "${name}\n\nYA SE ENCUENTRA CENSADO",
          );
          dataCensadoList.clear();
          dataCensado.value = DataCensado.empty();
        }
      },
    );

    peticionServerState(false);
  }


  Future<void> getFotoDgpByDocumento() async {

    peticionServerState(true);

    await ExceptionDialogos.manejarErroresShowDialogo(
      msjNoData: "No existen datos que mostrar...",
          () async {
        dataFotoDgp.value = await _getFotoDgpByDocumentoUseCase(documento: dataCensado.value.documento);


      },
    );

    peticionServerState(false);
  }

  Future<DataFile> featureGuardarFoto() async {
    DataFile dataFile = DataFile.empty();
    await ExceptionDialogos.manejarErroresShowDialogo(() async {
      String path = dotenv.env['PATH_IMG_APP_CENSO'] ?? '';

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
        DialogosAwesome.getError(
          title: "Guardar Imagen",
          descripcion:
              "No se pudo guardar la Imagen. Intente de nuevo o contacte al administrador.",
        );
      }
    });
    peticionServerState(false);
    return dataFile;
  }

  Future<void> SaveCensusPersonPhotoUseCaseServer() async {
    DataFile dataFile = await featureGuardarFoto();
    if (!dataFile.result) {
      return;
    }

    peticionServerState(true);

    await ExceptionDialogos.manejarErroresShowDialogo(() async {
      String ip = await DeviceInfoApp.getIp;
      final locationBloc = BlocProvider.of<LocationBloc>(Get.context!);
      LatLng position = await locationBloc.getCurrentPosition();

      UpdateFotoPerCensoRequest request = UpdateFotoPerCensoRequest(
        idGenUsuario: user.idGenUsuario,
        idDgpPerCenso: idDgpPerCenso,
        nameFotografia: dataFile.nameFile,
        latitud: position.latitude,
        longitud: position.longitude,
        ip: ip,
      );

      bool result = await _SaveCensusPersonPhotoUseCase(request: request);
      if (!result) {
        DialogosAwesome.getWarning(
          descripcion: "No se pudo completar el registro",
        );
        return;
      }

      DialogosAwesome.getInformation(
        descripcion: "La fotografia fue guardada con éxito.",
        btnOkOnPress: () {
          Get.back();
        },
      );
    });

    peticionServerState(false);
  }

  validarFoto() async{
    await getFotoDgpByDocumento();
      showBtnValidarFoto.value = true;

  }
}

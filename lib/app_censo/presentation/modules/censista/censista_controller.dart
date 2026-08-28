part of '../controllers.dart';

class CensistaController extends GetxController {
  final loginController = Get.find<LoginController>();
  final SaveFileImgUseCase _saveFileImgUseCase = Get.find();
  final GetFotoDgpByDocumentoUseCase _getFotoDgpByDocumentoUseCase = Get.find();
  final SaveCensusPersonPhotoUseCase _SaveCensusPersonPhotoUseCase = Get.find();
  final RxBool validacionFacialCompleta=false.obs;
  final FetchCensusPersonDataUseCase getDatosPersonaCenso = Get.find();

  RxList<DataPerCenso> dataPerCensoList = <DataPerCenso>[].obs;
  Rx<DataPerCenso> dataPerCenso = DataPerCenso.empty().obs;

  Rx<DataFoto> dataFotoDgp = DataFoto.empty().obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var controllerCodigoCenso = new TextEditingController();

  late UserEntities user;

  RxBool peticionServerState = false.obs;
  Rx<GaleryCameraModel?> mGaleryCameraModel = Rx<GaleryCameraModel?>(null);

  final ScrollController scrollController = ScrollController();

  int idDgpPerCenso = 0;

  RxBool showBtnValidarFoto = false.obs;

  DataMesaResponse dataMesaResponse=DataMesaResponse.empty();

  @override
  void onInit() async {
    user = loginController.user.value;
    super.onInit();
  }

  @override
  void onReady() async {
    await getDataToPage();
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


    if (arguments != null && arguments.containsKey('DataMesaResponse')) {
      try {
        dataMesaResponse = arguments['DataMesaResponse'] as DataMesaResponse;

      } catch (e) {
        // DialogosAwesome.getError(descripcion: "1 No existe datos valido para la mesa ");
      }
    } else {
      /*
      DialogosAwesome.getError(descripcion: "No existe datos valido para la mesa ",btnOkOnPress: (){
        Future.delayed(Duration.zero, () {
          Navigator.pop(Get.context!);
        });
      });*/
    }
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
          isCensoTodos: dataMesaResponse.isCensoTodos,
        );
        dataPerCensoList.value = await getDatosPersonaCenso(request: request);
        dataPerCenso.value = dataPerCensoList[0];
        if (dataPerCenso.value.censado) {
          DialogosAwesome.getInformation(
            descripcion:
                "${dataPerCenso.value.nameCensado}\n\nYA SE ENCUENTRA CENSADO",
          );
          dataPerCensoList.clear();
          dataPerCenso.value = DataPerCenso.empty();
        }
      },
    );

    peticionServerState(false);
  }

  Future<void> getFotoDgpByDocumento() async {
    peticionServerState(true);

    await ExceptionDialogos.manejarErroresShowDialogo(
      msjNoData: "No se encontro una fotografia que mostrar...",
      () async {
        dataFotoDgp.value = await _getFotoDgpByDocumentoUseCase(
          documento: dataPerCenso.value.documentoCensado,
        );
      },
    );

    peticionServerState(false);
  }

  Future<DataFile> featureGuardarFoto() async {
    DataFile dataFile = DataFile.empty();
    await ExceptionDialogos.manejarErroresShowDialogo(() async {
      String path = dotenv.env['PATH_IMG_APP_CENSO'] ?? '';

      String nameFile =
          "Censo_${dataPerCenso.value.idProceso}_C.C_${dataPerCenso.value.documentoCensado}_idDgpPerCenso_" +
          dataPerCenso.value.idDgpPerCenso.toString() +
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
    if (dataPerCenso.value.idGenUsuarioCensado == 0) {
      DialogosAwesome.getWarning(
        descripcion: "El usuario del censado no puedo ser 0",
      );
      return;
    }

    await ExceptionDialogos.manejarErroresShowDialogo(() async {
      String ip = await DeviceInfoApp.getIp;
      final locationBloc = BlocProvider.of<LocationBloc>(Get.context!);
      LatLng position = await locationBloc.getCurrentPosition();

      UpdateFotoPerCensoRequest request = UpdateFotoPerCensoRequest(
        idUsuarioCensado: dataPerCenso.value.idGenUsuarioCensado,
        idUsuarioCensista: user.idGenUsuario,
        idDgpPerCenso: dataPerCenso.value.idDgpPerCenso,
        nameFotografia: dataFile.nameFile,
        latitud: position.latitude,
        longitud: position.longitude,
        ip: ip,
        gradoCensista: user.gradoSiglas,
      );

      bool result = await _SaveCensusPersonPhotoUseCase(request: request);
      if (!result) {
        DialogosAwesome.getWarning(
          descripcion: "No se pudo completar el registro",
        );
        return;
      }

      DialogosAwesome.getSucess(
        descripcion: "El censo ha finalizado correctamente.",
        btnOkOnPress: () {
          Get.back();
        },
      );
    });

    peticionServerState(false);
  }

  validarFoto() async {
    await getFotoDgpByDocumento();
    showBtnValidarFoto.value = true;
  }
}

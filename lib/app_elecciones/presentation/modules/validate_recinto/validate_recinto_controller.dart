part of '../controllers.dart';

class ValidateRecintoController extends GetxController {
  final loginController = Get.find<LoginController>();

  final EleccionesRecintosApiImpl _eleccionesRecintosApiImpl =
      Get.find<EleccionesRecintosApiImpl>();

  RxList<RecintosElectoral> listRecintosElectorales = <RecintosElectoral>[].obs;
  Rx<RecintosElectoral> selectRecintosElectoral = RecintosElectoral().obs;

  ProcesosOperativo selectProcesosOperativo = ProcesosOperativo.empty();

  RxBool peticionServerState = false.obs;
  late UserEntities user;

  Rx<LatLng> ubicacion = new LatLng(-0.2143, -78.50179).obs;
  MapController mapController = new MapController();

  var controllerTelefono = TextEditingController();
  final formKey = GlobalKey<FormState>();



  // late DataMesa dataMesa;

  @override
  void onInit() async {
    user = loginController.user.value;
    await getRecintosElectorales();
    super.onInit();
  }

  @override
  void onReady() async {
    await getDataToPage();
    await getUbicacionActual();
    // TODO: Donde la vista ya se presento
    super.onReady();
  }

  getDataToPage() async {
    // Recibe los argumentos
    final arguments = Get.arguments as Map<String, dynamic>?;

    if (arguments != null && arguments.containsKey('selectProcesosOperativo')) {
      try {
        selectProcesosOperativo =
            arguments['selectProcesosOperativo'] as ProcesosOperativo;
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

  @override
  void onClose() {
    // TODO: implement onClose

    super.onClose();
  }

  getUbicacionActual() async {
    peticionServerState(true);
    final locationBloc = BlocProvider.of<LocationBloc>(Get.context!);
    ubicacion.value = await locationBloc.getCurrentPosition();

    mapController.move(ubicacion.value, 18);
    peticionServerState(false);

    await getRecintosElectorales();
  }

  Future<void> getRecintosElectorales() async {
    peticionServerState(true);
    await ExceptionDialogos.manejarErroresShowDialogo(() async {
      final locationBloc = BlocProvider.of<LocationBloc>(Get.context!);
      LatLng pos = await locationBloc.getCurrentPosition();

      RecintoCercanosRequest req = RecintoCercanosRequest(
        onlyValidados: false,
        latitud: pos.latitude,
        longitud: pos.longitude,
        idDgoProcElec: selectProcesosOperativo.idDgoProcElec,
        idDgoTipoEje: 1,
      );
      listRecintosElectorales.value = await _eleccionesRecintosApiImpl
          .getRecintosElectoralesCercanos(request: req);
    });
    peticionServerState(false);
  }

  Future<void> updateRecintoCoordinates() async {
    bool isValid = formKey.currentState!.validate();

    if (!isValid) return;

    peticionServerState(true);

    await ExceptionDialogos.manejarErroresShowDialogo(() async {
      String ip = await DeviceInfoApp.getIp;

      var tipoValidacion = GetPlatform.isAndroid
          ? TipoValidacionRecinto.movilAndroid
          : GetPlatform.isIOS
          ? TipoValidacionRecinto.movilIos
          : TipoValidacionRecinto.web;

      ValidarRecintoRequest request = ValidarRecintoRequest(
        usuario: user.idGenUsuario,
        latitudValidacion: ubicacion.value.latitude,
        longitudValidacion: ubicacion.value.longitude,
        telefono: controllerTelefono.text,
        ip: ip,
        idDgoComisios: selectRecintosElectoral.value.idDgoComisios,
        tipoValidacion: tipoValidacion,
      );

      bool result = await _eleccionesRecintosApiImpl.validarRecinto(
        request: request,
      );
      if (!result) {
        DialogosAwesome.getWarning(
          descripcion: "No se pudo completar el registro",
        );
        return;
      }

      DialogosAwesome.getInformation(
        descripcion: "Las coordenadas fueron registradas con éxito.",
        btnOkOnPress: () {
          controllerTelefono.clear();
          Get.back();
        },
      );
    });

    peticionServerState(false);
  }
}

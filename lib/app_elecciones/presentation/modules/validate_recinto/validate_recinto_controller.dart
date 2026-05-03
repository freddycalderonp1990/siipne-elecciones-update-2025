part of '../controllers.dart';

class ValidateRecintoController extends GetxController {
  final loginController = Get.find<LoginController>();
  final selectProcesoOperativoController = Get.find<SelectProcesoOperativoController>();
  final EleccionesRecintosApiImpl _eleccionesRecintosApiImpl =
  Get.find<EleccionesRecintosApiImpl>();

  RxList<RecintosElectoral> listRecintosElectorales = <RecintosElectoral>[].obs;
  Rx<RecintosElectoral> selectRecintosElectoral = RecintosElectoral().obs;


  RxBool peticionServerState = false.obs;
  late UserEntities user;

  Rx<LatLng> ubicacion = new LatLng(-0.2143, -78.50179).obs;
  MapController mapController = new MapController();

 // late DataMesa dataMesa;

  @override
  void onInit() async {
    user = loginController.user.value;
    await getRecintosElectorales();
    super.onInit();
  }

  @override
  void onReady() async {
   // await getDataToPage();
    await getUbicacionActual();
    // TODO: Donde la vista ya se presento
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose

    super.onClose();
  }


  getUbicacionActual() async{
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
        onlyValidados: selectProcesoOperativoController.selectProcesosOperativo.value.mostrarValidado,
        latitud: pos.latitude,
        longitud: pos.longitude,
        idDgoProcElec:
        selectProcesoOperativoController.selectProcesosOperativo.value.idDgoProcElec,
        idDgoTipoEje: 1,
      );
      listRecintosElectorales.value =
      await _eleccionesRecintosApiImpl.getRecintosElectoralesCercanos(request: req);
    });
    peticionServerState(false);
  }

  Future<void> updateRecintoCoordinates() async {

   peticionServerState(true);

    await ExceptionDialogos.manejarErroresShowDialogo(() async {
      String ip = await DeviceInfoApp.getIp;


      ValidarRecintoRequest request = ValidarRecintoRequest(
        usuario: user.idGenUsuario,
        latitudValidacion: ubicacion.value.latitude,
        longitudValidacion: ubicacion.value.longitude,
        ip: ip, idDgoComisios: selectRecintosElectoral.value.idDgoComisios
        
      );

      bool result = await _eleccionesRecintosApiImpl.validarRecinto(request: request);
      if (!result) {
        DialogosAwesome.getWarning(
          descripcion: "No se pudo completar el registro",
        );
        return;
      }

      DialogosAwesome.getInformation(
        descripcion: "Las coordenadas fueron registradas con éxito.",
        btnOkOnPress: () {
          Get.back();
        },
      );
    });

    peticionServerState(false);
  }


}

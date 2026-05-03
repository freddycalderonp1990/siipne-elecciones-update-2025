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

 /* getDataToPage() async {
    // Recibe los argumentos
    final arguments = Get.arguments as Map<String, dynamic>?;

    // Verifica que los argumentos no sean nulos y que contengan la clave 'data'
    if (arguments != null &&
        arguments.containsKey('mesa')) {
      try {
        dataMesa = arguments['mesa']
        as DataMesa;
      } catch (e) {
        DialogosAwesome.getError(descripcion: "1 No existe datos valido para la mesa ");
      }
    } else {
      DialogosAwesome.getError(descripcion: "No existe datos valido para la mesa ",btnOkOnPress: (){

        Future.delayed(Duration.zero, () {
          Navigator.pop(Get.context!);
        });
      });
    }
  }
*/
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

  Future<void> updateMesaCoordinates() async {

   /* peticionServerState(true);

    await ExceptionDialogos.manejarErroresShowDialogo(() async {
      String ip = await DeviceInfoApp.getIp;


      UpdateCoordenadasMesaRequest request = UpdateCoordenadasMesaRequest(
        usuario: user.idGenUsuario,
        latitud: ubicacion.value.latitude,
        longitud: ubicacion.value.longitude,
        ip: ip, idDgpMesa: dataMesa.idDgpMesa,
      );

      bool result = await updateMesaCoordinatesUseCase(request: request);
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

    peticionServerState(false);*/
  }


}

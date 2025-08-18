part of '../../controllers.dart';

class ValidateMesaController extends GetxController {
  final loginController = Get.find<LoginController>();
  RxBool peticionServerState = false.obs;
  late UserEntities user;

  Rx<LatLng> ubicacion = new LatLng(-0.2143, -78.50179).obs;
  MapController mapController = new MapController();

  late DataMesa dataMesa;

  @override
  void onInit() async {
    user = loginController.user.value;

    super.onInit();
  }

  @override
  void onReady() async {
    await getDataToPage();
    await getUbicacionActual();
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

    // Verifica que los argumentos no sean nulos y que contengan la clave 'data'
    if (arguments != null &&
        arguments.containsKey('mesa')) {
      try {
        dataMesa = arguments['mesa']
        as DataMesa;
      } catch (e) {
        DialogosAwesome.getError(descripcion: "1 No existe datos valido para la mesa ",btnOkOnPress: (){
          Get.back();
        });
      }
    } else {
      DialogosAwesome.getError(descripcion: "No existe datos valido para la mesa ",btnOkOnPress: (){

        Future.delayed(Duration.zero, () {
          Navigator.pop(Get.context!);
        });
      });
    }
  }

  getUbicacionActual() async{
    peticionServerState(true);
    final locationBloc = BlocProvider.of<LocationBloc>(Get.context!);
    ubicacion.value = await locationBloc.getCurrentPosition();

    mapController.move(ubicacion.value, 18);
    peticionServerState(false);
  }


}

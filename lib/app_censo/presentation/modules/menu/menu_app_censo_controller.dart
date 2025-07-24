part of '../controllers.dart';

class MenuAppCensoController extends GetxController {
  final loginController = Get.find<LoginController>();

  GetMesesByIdusuario getMesesByIdusuario = Get.find();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late UserEntities user;

  RxBool peticionServerState = false.obs;
  RxList<DataCensado> dataMesasList = <DataCensado>[].obs;

  @override
  void onInit() async {
    user = loginController.user.value;
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
      dataMesasList.value = await getMesesByIdusuario(request: request);
    });

    peticionServerState(false);
  }

  cerrarSession() {
    Get.back();
  }
}

part of '../controllers.dart';

class HomeController extends GetxController {
  final LocalStoreImpl _localStoreImpl = Get.find<LocalStoreImpl>();

  RxList<ApsQr> listApsQr = <ApsQr>[].obs;
  var controllerAppName = new TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    // TODO: el contolloler se ha creado pero la vista no se ha renderizado

    super.onInit();
  }

  @override
  void onReady() {
    // TODO: Donde la vista ya se presento

    _init();
  }

  @override
  void onClose() {
    // TODO: implement onClose

    super.onClose();
  }

  _init() async {

  }

  setAppPageSelect(PageAppsSelect value) async {
    await _localStoreImpl.setAppPageSelect(value.toString());
    print("holalalalalala");

    Get.offAllNamed(AppRoutes.SPLASH_APP);
  }

  static const maxSeconds = 30;
  RxInt seconds = maxSeconds.obs;
  RxInt seconds2 = 0.obs;
  RxDouble valueRadio = 100.0.obs;
  Timer? timer;
  RxBool generarCodes = true.obs;





}

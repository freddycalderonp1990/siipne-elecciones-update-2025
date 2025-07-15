part of '../controllers.dart';

class HomeController extends GetxController {
  final LocalStoreUseCase _localStoreImpl = Get.find<LocalStoreUseCase>();


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


}

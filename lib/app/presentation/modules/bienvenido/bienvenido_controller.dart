part of '../controllers.dart';

class BienvenidoController extends GetxController {
  final LocalStoreImpl _localStoreImpl =
      Get.find<LocalStoreImpl>();

  @override
  void onInit() {
    // TODO: el contolloler se ha creado pero la vista no se ha renderizado
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: Donde la vista ya se presento

  }



  setAppSiipne(PageAppsSelect value) async{

   await _localStoreImpl.setAppPageSelect(value.toString());

     Get.offAllNamed(AppRoutes.SPLASH_APP);

  }






}

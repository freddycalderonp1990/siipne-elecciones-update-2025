part of '../controllers.dart';

class MenuAppController extends GetxController {
  final LocalStoreImpl _localStoreImpl = Get.find<LocalStoreImpl>();
  final BeneficiosApiImpl _beneficiosApiImpl = Get.find<BeneficiosApiImpl>();
  final EmpresaApiImpl _empresaApiImpl = Get.find<EmpresaApiImpl>();

  RxList<DataCatBeneficio> listCatBeneficio = <DataCatBeneficio>[].obs;
  RxList<DataBanner> listBanners = <DataBanner>[].obs;
  RxBool activarCargandobanner=false.obs;


  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxBool peticionServerState = false.obs;
  @override
  void onInit() async {
    // TODO: el contolloler se ha creado pero la vista no se ha renderizado
   await getAllBanners();
    getCategoriaBeneficios();
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

  Future<void> getCategoriaBeneficios() async {
    try {
      peticionServerState(true);
      listCatBeneficio.value =
          await _beneficiosApiImpl.getCategoriaBeneficios();
      if (listCatBeneficio.length == 0) {
        DialogosAwesome.getInformation(
            descripcion: "No existen datos que mostrar");
      }
      peticionServerState(false);
    } on ServerException catch (e) {
      peticionServerState(false);
      DialogosAwesome.getError(descripcion: e.cause);
    } catch (e) {
      peticionServerState(false);
      throw ExceptionHelper.captureError(e);
    }
  }


  Future<void> getAllBanners() async {
    try {

      activarCargandobanner(true);
      peticionServerState(true);
      listBanners.value =
      await _empresaApiImpl.getAllBanners(limit: 5);
      activarCargandobanner(false);

    if(listBanners.length>0){
    await  timerMostrarBenner();
    }

      peticionServerState(false);


    } on ServerException catch (e) {
      peticionServerState(false);
      activarCargandobanner(false);
     //DialogosAwesome.getError(descripcion: e.cause);
    } catch (e) {
      peticionServerState(false);
      activarCargandobanner(false);
     // DialogosAwesome.getError(descripcion: e.toString());
     // peticionServerState(false);
      //throw ExceptionHelper.captureError(e);
    }
  }

  timerMostrarBenner() async{
    activarCargandobanner(true);

    await Future.delayed(Duration(seconds: 1));

    activarCargandobanner(false);

  }

  gotoToPage(DataCatBeneficio data) {
    Get.toNamed(SiipneRoutes.CATALOGO, arguments: {'data': data});
  }
}

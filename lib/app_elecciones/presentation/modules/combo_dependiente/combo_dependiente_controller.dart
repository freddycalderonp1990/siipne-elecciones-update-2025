part of '../controllers.dart';

class ComboDependienteController extends GetxController {
  final EleccionesTipoEjesApiImpl _eleccionesTipoEjesApiImpl =
      Get.find<EleccionesTipoEjesApiImpl>();

  RxList<UnidadesPoliciale> listSubsistema = <UnidadesPoliciale>[].obs;
  Rx<UnidadesPoliciale> selectSubsistema = UnidadesPoliciale.empty().obs;

  RxList<UnidadesPoliciale> listDireccionesPoliciales =
      <UnidadesPoliciale>[].obs;
  Rx<UnidadesPoliciale> selectDireccionPoliciales =
      UnidadesPoliciale.empty().obs;

  RxList<UnidadesPoliciale> listUnidadesPoliciales = <UnidadesPoliciale>[].obs;
  Rx<UnidadesPoliciale> selectUnidadPolicial = UnidadesPoliciale.empty().obs;

  RxBool peticionServerState = false.obs;

  @override
  void onInit() async {
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

  Future<void> getSubsistemas({required int idGenUsuario}) async {
    print("consultando getSubsistemas");
    // peticionServerState(true);
    await ExceptionHelper.manejarErroresShowDialogo(() async {
      listSubsistema.value = await _eleccionesTipoEjesApiImpl
          .getUnidadesPoliciales(usuario: idGenUsuario);
      if (listSubsistema.length == 0) {
        DialogosAwesome.getInformation(
          descripcion: "No existen Unidades Policiales",
        );
        return;
      }
    });
    // peticionServerState(false);
  }

  Future<List<UnidadesPoliciale>> getTipoEjesPoridDgoTipoEje({
    required int idDgoTipoEje,
    required int idGenUsuario,
    required String descripcion,
  }) async {
    print("consultando");
    peticionServerState(true);
    List<UnidadesPoliciale> list = [];
    bool result = await ExceptionHelper.manejarErroresShowDialogo(() async {
      list = await _eleccionesTipoEjesApiImpl.getTipoEjePorIdPadre(
        usuario: idGenUsuario,
        idDgoTipoEje: idDgoTipoEje,
      );
    });
    peticionServerState(false);


    if (result && list.length == 0) {
      DialogosAwesome.getIconPolicia(
        title: "Sin Datos",
        descripcion: descripcion,
        titleBtnSi: "Aceptar",
        btnOkOnPress: () {
          Get.back();
        },
        mostrarSegungoBtn: false,
      );
    }
    return list;
  }

  Future<void> getEjesDireccionesPoliciales({
    required int idDgoTipoEje,
    required int idGenUsuario,
  }) async {
    listDireccionesPoliciales.value = await getTipoEjesPoridDgoTipoEje(
      idDgoTipoEje: idDgoTipoEje,
      idGenUsuario: idGenUsuario,
      descripcion: "No existen Direcciones Policiales",
    );
  }

  Future<void> getEjesUnidadesPoliciales({
    required int idDgoTipoEje,
    required int idGenUsuario,
  }) async {
    listUnidadesPoliciales.value = await getTipoEjesPoridDgoTipoEje(
      descripcion: "No existen Unidades Policiales",
      idDgoTipoEje: idDgoTipoEje,
      idGenUsuario: idGenUsuario,
    );
  }
}

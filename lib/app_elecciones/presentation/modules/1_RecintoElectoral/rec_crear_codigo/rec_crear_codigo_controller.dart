part of '../../controllers.dart';

class RecintosCrearCodigoController extends GetxController {
  final loginController = Get.find<LoginController>();

  final selectProcesoOperativoController =
      Get.find<SelectProcesoOperativoController>();

  final EleccionesRecintosApiImpl _eleccionesRecintosApiImpl =
      Get.find<EleccionesRecintosApiImpl>();

  final EleccionesTipoEjesApiImpl _eleccionesTipoEjesApiImpl =
  Get.find<EleccionesTipoEjesApiImpl>();

  RxList<UnidadesPoliciale> listSubsistema=<UnidadesPoliciale>[].obs;
  Rx<UnidadesPoliciale> selectSubsistema=UnidadesPoliciale.empty().obs;

  RxList<UnidadesPoliciale> listDirecciones=<UnidadesPoliciale>[].obs;
  Rx<UnidadesPoliciale> selectDireccion=UnidadesPoliciale.empty().obs;


  RxList<UnidadesPoliciale> listUnidadesPoliciales=<UnidadesPoliciale>[].obs;
  Rx<UnidadesPoliciale> selectUnidadePolicial=UnidadesPoliciale.empty().obs;


  RxList<RecintosElectoral> listRecintosElectorales=<RecintosElectoral>[].obs;
  Rx<RecintosElectoral> selectRecintosElectoral=RecintosElectoral().obs;


  Rx<TipoEjesActivos> tipoEjesActivos = TipoEjesActivos.empty().obs;

  late DataUser user;
  RxBool cargaInicial = false.obs;

  RxBool peticionServerState = false.obs;
  @override
  void onInit() async {
    user = loginController.user.value;

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

  Future<void> getRecintosElectorales() async {
    print("consultando");

   // peticionServerState(true);
    cargaInicial.value = true;

    await ExceptionHelper.manejarErrores(() async {
      final locationBloc = BlocProvider.of<LocationBloc>(Get.context!);
      LatLng position = await locationBloc.getCurrentPosition();

      //le asigno 1 porque es el id que le corresponde a recintos electorales
      //para solo mostrar los recintos electorales
      int idDgoTipoEje = 1;

      listRecintosElectorales.value=   await _eleccionesRecintosApiImpl.getRecintosElectoralesCercanos(
          latitud: position.latitude,
          longitud: position.longitude,
          idDgoProcElec:
              selectProcesoOperativoController.procesosOperativo.idDgoProcElec,
          idDgoTipoEje: idDgoTipoEje);

      if (listRecintosElectorales.length == 0) {
        DialogosAwesome.getInformation(
            descripcion:
                "No existen Recintos Electorales Cercanos");
        return;
      }

    });

   // peticionServerState(false);
  }

  Future<void> getSubsistemas() async {
    print("consultando");
   // peticionServerState(true);
    await ExceptionHelper.manejarErrores(() async {
      listSubsistema.value=   await _eleccionesTipoEjesApiImpl.getUnidadesPoliciales(usuario: user.idGenUsuario);
      if (listSubsistema.length == 0) {
        DialogosAwesome.getInformation(
            descripcion:
            "No existen Unidades Policiales");
        return;
      }
    });
   // peticionServerState(false);
  }


  Future<List<UnidadesPoliciale>> getTipoEjesPoridDgoTipoEje(int idDgoTipoEje) async {
    print("consultando");
     peticionServerState(true);
    List<UnidadesPoliciale> list=[];
    await ExceptionHelper.manejarErrores(() async {
     list=   await _eleccionesTipoEjesApiImpl.getTipoEjePorIdPadre(usuario: user.idGenUsuario, idDgoTipoEje: idDgoTipoEje);
    });
    peticionServerState(false);
    return list;

  }

  Future<void> getEjesDireccionesPoliciales(int idDgoTipoEje) async {
     listDirecciones.value=await  getTipoEjesPoridDgoTipoEje(idDgoTipoEje);
     if(listDirecciones.length==0){
       DialogosAwesome.getInformation(
           descripcion:
           "No existen Direcciones Policiales");
     }
  }

  Future<void> getEjesUnidadesPoliciales(int idDgoTipoEje) async {
    listUnidadesPoliciales.value=await  getTipoEjesPoridDgoTipoEje(idDgoTipoEje);
    if(listUnidadesPoliciales.length==0){
      DialogosAwesome.getInformation(
          descripcion:
          "No existen Unidades Policiales");
    }
  }


  Future<void> getDatos() async {
    peticionServerState(true);
    List<dynamic> resultados = await Future.wait([
      getRecintosElectorales(),
      getSubsistemas(),
    ]);
    peticionServerState(false);

    /* // Usa los resultados de ambas funciones
    int resultado1 = resultados[0];
    String resultado2 = resultados[1];

    print('Función 3 completada con resultados: $resultado1 y $resultado2');*/
  }

  goToPage(String name) {
    Get.offNamed(name);
  }

  cerrarSession() {
    Get.toNamed(AppRoutes.SPLASH_APP);
  }
}

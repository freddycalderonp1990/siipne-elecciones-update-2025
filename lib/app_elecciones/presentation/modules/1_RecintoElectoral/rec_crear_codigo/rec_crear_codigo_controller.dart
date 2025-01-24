part of '../../controllers.dart';

class RecintosCrearCodigoController extends GetxController {
  final loginController = Get.find<LoginController>();

  final selectProcesoOperativoController =
      Get.find<SelectProcesoOperativoController>();

  final EleccionesRecintosApiImpl _eleccionesRecintosApiImpl =
      Get.find<EleccionesRecintosApiImpl>();

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

  RxList<RecintosElectoral> listRecintosElectorales = <RecintosElectoral>[].obs;
  Rx<RecintosElectoral> selectRecintosElectoral = RecintosElectoral().obs;

  late DataUser user;
  RxBool cargaInicial = false.obs;

  RxBool peticionServerState = false.obs;

  var controllerTelefono = new TextEditingController();
  final formKey = GlobalKey<FormState>();

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

      listRecintosElectorales.value =
          await _eleccionesRecintosApiImpl.getRecintosElectoralesCercanos(
              latitud: position.latitude,
              longitud: position.longitude,
              idDgoProcElec: selectProcesoOperativoController
                  .selectProcesosOperativo.value.idDgoProcElec,
              idDgoTipoEje: idDgoTipoEje);

      if (listRecintosElectorales.length == 0) {
        DialogosAwesome.getInformation(
            descripcion: "No existen Recintos Electorales Cercanos");
        return;
      }
    });

    // peticionServerState(false);
  }

  Future<void> getSubsistemas() async {
    print("consultando");
    // peticionServerState(true);
    await ExceptionHelper.manejarErrores(() async {
      listSubsistema.value = await _eleccionesTipoEjesApiImpl
          .getUnidadesPoliciales(usuario: user.idGenUsuario);
      if (listSubsistema.length == 0) {
        DialogosAwesome.getInformation(
            descripcion: "No existen Unidades Policiales");
        return;
      }
    });
    // peticionServerState(false);
  }

  Future<List<UnidadesPoliciale>> getTipoEjesPoridDgoTipoEje(
      int idDgoTipoEje) async {
    print("consultando");
    peticionServerState(true);
    List<UnidadesPoliciale> list = [];
    await ExceptionHelper.manejarErrores(() async {
      list = await _eleccionesTipoEjesApiImpl.getTipoEjePorIdPadre(
          usuario: user.idGenUsuario, idDgoTipoEje: idDgoTipoEje);
    });
    peticionServerState(false);
    return list;
  }

  Future<void> getEjesDireccionesPoliciales(int idDgoTipoEje) async {
    listDireccionesPoliciales.value =
        await getTipoEjesPoridDgoTipoEje(idDgoTipoEje);
    if (listDireccionesPoliciales.length == 0) {
      DialogosAwesome.getInformation(
          descripcion: "No existen Direcciones Policiales");
    }
  }

  Future<void> getEjesUnidadesPoliciales(int idDgoTipoEje) async {
    listUnidadesPoliciales.value =
        await getTipoEjesPoridDgoTipoEje(idDgoTipoEje);
    if (listUnidadesPoliciales.length == 0) {
      DialogosAwesome.getInformation(
          descripcion: "No existen Unidades Policiales");
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

  Future<void> crearCodigo() async {
    bool isValid = formKey.currentState!.validate();
    if (!isValid) return;
    peticionServerState(true);

   late  AbrirRecintoElectoral _abrirRecintoElectoral;

    await ExceptionHelper.manejarErrores(() async {
      final locationBloc = BlocProvider.of<LocationBloc>(Get.context!);
      LatLng position = await locationBloc.getCurrentPosition();

      String ip=await DeviceInfo.getIp;

      _abrirRecintoElectoral=await  _eleccionesRecintosApiImpl.crearCodigo(
          usuario: user.idGenUsuario,
          idGenPersona: user.idGenPersona,
          idDgoReciElect: selectRecintosElectoral.value.idDgoReciElect,
          latitud: position.latitude,
          longitud: position.longitude,
          idDgoProcElec:selectProcesoOperativoController.selectProcesosOperativo.value. idDgoProcElec,
          idDgoReciUnidadPolicial: selectRecintosElectoral.value.idDgoReciElect,
          telefono: controllerTelefono.text,
          ip: ip,
          idDgoTipoEje: selectUnidadPolicial.value.idDgoTipoEje);
    });



    if (_abrirRecintoElectoral.estado == "A") {
      String msj= _abrirRecintoElectoral.apenom +
          "\nYa existe un Código asignado ${_abrirRecintoElectoral.idDgoCreaOpReci} a esta Unidad Policial \n\n" +
          selectRecintosElectoral.value.nomRecintoElec +
          "\nFECHA INICIO: " +
          _abrirRecintoElectoral.fechaIni +
          "\n\nSi usted necesita abrir la misma Unidad Policial el encargado [${_abrirRecintoElectoral.apenom}] debe eliminarla o finalizarlo.";

          DialogosAwesome.getWarning(descripcion: msj,);

      } else {

      DialogosWidget.alert(context,
          title: "CÓDIGO",
          message: "El Código para que el personal se anexe es: " +
              _abrirRecintoElectoral.idDgoCreaOpReci, onTap: () {
            UtilidadesUtil.pantallasAbrirNuevaCerrarTodas(
                context: context,
                pantalla: AppConfig.pantallaVerificarOperativoRecintoAbierto);

            /* Navigator.pushReplacementNamed(
              context, AppConfig.pantallaMenuRecintoElectoral);*/
          });
    }
    peticionServerState(false);
  }

  goToPage(String name) {
    Get.offNamed(name);
  }

  cerrarSession() {
    Get.toNamed(AppRoutes.SPLASH_APP);
  }
}

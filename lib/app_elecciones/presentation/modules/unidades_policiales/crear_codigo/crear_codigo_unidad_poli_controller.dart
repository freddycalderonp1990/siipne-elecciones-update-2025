part of '../../controllers.dart';

class CrearCodigoUnidadPoliController extends GetxController {
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

  late UserEntities user;
  RxBool cargaInicial = false.obs;

  RxBool peticionServerState = false.obs;

  var controllerTelefono = new TextEditingController();
  final formKey = GlobalKey<FormState>();

  //para mostrar los recintos
  RxBool continuar = false.obs;

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


  Future<void> getSubsistemas() async {
    print("consultando");
     peticionServerState(true);
    await ExceptionHelper.manejarErroresShowDialogo(() async {
      listSubsistema.value = await _eleccionesTipoEjesApiImpl
          .getUnidadesPoliciales(usuario: user.idGenUsuario);
      if (listSubsistema.length == 0) {
        DialogosAwesome.getInformation(
            descripcion: "No existen Unidades Policiales");
        return;
      }
    });
    peticionServerState(false);
  }

  Future<List<UnidadesPoliciale>> getTipoEjesPoridDgoTipoEje(
      int idDgoTipoEje) async {
    print("consultando");
    peticionServerState(true);
    List<UnidadesPoliciale> list = [];
    await ExceptionHelper.manejarErroresShowDialogo(() async {
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


  Future<void> getRecintosElectorales(int idDgoTipoEje) async {
    peticionServerState(true);
    cargaInicial.value = true;

    await ExceptionHelper.manejarErroresShowDialogo(() async {
      final locationBloc = BlocProvider.of<LocationBloc>(Get.context!);
      LatLng position = await locationBloc.getCurrentPosition();

      //le asigno 1 porque es el id que le corresponde a recintos electorales
      //para solo mostrar los recintos electorales


      RecintoCercanosRequest request = RecintoCercanosRequest(
          latitud: position.latitude,
          longitud: position.longitude,
          idDgoProcElec: selectProcesoOperativoController
              .selectProcesosOperativo.value.idDgoProcElec,
          idDgoTipoEje: idDgoTipoEje);

      listRecintosElectorales.value = await _eleccionesRecintosApiImpl
          .getRecintosElectoralesCercanos(request: request);

      if (listRecintosElectorales.length == 0) {
        continuar.value=false;
        DialogosAwesome.getInformation(
            descripcion: "No existen Unidades Policiales Cercanas",btnOkOnPress: (){

        });
        return;
      }
      continuar.value = true;
    });

    peticionServerState(false);
  }




  msjCrearCodigo({required VoidCallback onPressed}) {
    bool isValid = formKey.currentState!.validate();

    if (!isValid) return;
    String unidad=selectRecintosElectoral.value.nomRecintoElecOnly;

    String  msj="¿Usted va a generar el código para la ${unidad}?"
        "\n\nAsegúrese de estar de servicio en la Unidad y de ser la persona encargada o la persona designada como jefe/a."
        "\n\n Utilice la aplicación con responsabilidad, ya que toda actividad sera registrada y auditada."
        "\n\n¿Desea Continuar?";


    DialogosAwesome.getIconPolicia(
        title: "Crear Código", btnOkOnPress: onPressed, descripcion: msj);
  }

  Future<void> crearCodigo() async {
    bool isValid = formKey.currentState!.validate();
    if (!isValid) return;

    peticionServerState(true);

    late AbrirRecintoElectoral _abrirRecintoElectoral;

    await ExceptionHelper.manejarErroresShowDialogo(() async {
      final locationBloc = BlocProvider.of<LocationBloc>(Get.context!);
      LatLng position = await locationBloc.getCurrentPosition();

      String ip = await DeviceInfo.getIp;

      CreateCodeRecintoRequest request = CreateCodeRecintoRequest(
          usuario: user.idGenUsuario,
          idGenPersona: user.idGenPersona,
          idDgoReciElect: selectRecintosElectoral.value.idDgoReciElect,
          latitud: position.latitude,
          longitud: position.longitude,
          idDgoProcElec: selectProcesoOperativoController
              .selectProcesosOperativo.value.idDgoProcElec,
          idDgoReciUnidadPolicial: selectRecintosElectoral.value.idDgoReciElect,
          telefono: controllerTelefono.text,
          ip: ip,
          idDgpGrado: user.idDgpGrado,
          idDgoTipoEje: selectDireccionPoliciales.value.idDgoTipoEje);

      _abrirRecintoElectoral =
          await _eleccionesRecintosApiImpl.crearCodigo(request: request);
    });
    peticionServerState(false);

    if (_abrirRecintoElectoral.idDgoCreaOpReci == 0) {
      DialogosAwesome.getWarning(
          descripcion:
              "No se pudo completar la acción. Por favor, inténtelo nuevamente.",
          btnOkOnPress: () {});
      return;
    }

    if (_abrirRecintoElectoral.estado == "A") {
      String msj = user.nombres +
          "\n\nYa existe un código (${_abrirRecintoElectoral.idDgoCreaOpReci}) asignado a:\n" +
          selectRecintosElectoral.value.nomRecintoElec +
          "\nFECHA DE INICIO: " +
          _abrirRecintoElectoral.fechaIni +
          "\n\nSi usted necesita abrir el código en este Recinto, comuníquese con: \n[${_abrirRecintoElectoral.apenom}] para que lo elimine o finalice.";

      DialogosAwesome.getIconPolicia(
        colorBtnSi: AppColors.colorVerde_80,
        mostrarSegungoBtn: false,
        title: "Información",
        btnOkOnPress: () {
          Get.back();
          UtilidadesUtil.lanzarLlamada(_abrirRecintoElectoral.telefono);
        },
        descripcion: msj,
        titleBtnSi: "Llamar",
        iconBtnSi: Icons.call,
      );
    } else {
      return Get.dialog(
        PopScope(
          canPop: false, // Evita que se cierre con el botón de retroceso
          child: AlertDialog(
            content: SingleChildScrollView(
              // Permite que el contenido se ajuste automáticamente
              child: getDesingCompartirCodigo(
                  _abrirRecintoElectoral.idDgoCreaOpReci),
            ),
          ),
        ),
        barrierDismissible:
            false, // Evita que se cierre al tocar fuera del diálogo
      );
    }
  }

  getDesingCompartirCodigo(int idDgoCreaOpReci) {
    final responsive = ResponsiveUtil();
    return Column(
      mainAxisSize:
          MainAxisSize.min, // Ajusta el tamaño del diálogo al contenido
      children: [
        TextLineasWidget(
            title: "INFORMACIÓN",
            sizeTxt: responsive.diagonalP(AppConfig.tamTextoTitulo)),
        Container(
          height: 100,
          width: 100,
          child: Image.asset(SiipneImages.imgIconD),
        ),
        DetalleTextWidget(
          todoElAncho: true,
          detalle: "El Código para que el personal se anexe es:",
        ),
        TextLineasWidget(
          title: "${idDgoCreaOpReci}",
          sizeTxt: responsive.diagonalP(AppConfig.tamTextoTitulo + 1.5),
        ),
        SizedBox(
          height: responsive.altoP(2),
        ),
        BtnIconWidget(
            icon: Icons.check_circle,
            titulo: "Aceptar",
            onPressed: () {
              Get.offAllNamed(SiipneRoutes.MENU_APP);
            })
      ],
    );
  }

  goToPage(String name) {
    Get.offNamed(name);
  }

  cerrarSession() {
    Get.toNamed(AppRoutes.SPLASH_APP);
  }
}

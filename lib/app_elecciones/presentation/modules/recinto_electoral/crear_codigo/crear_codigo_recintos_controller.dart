part of '../../controllers.dart';

class CrearCodigoRecintosController extends GetxController {
  final loginController = Get.find<LoginController>();


  final comboDependienteController=Get.find<ComboDependienteController>();

  final selectProcesoOperativoController =
      Get.find<SelectProcesoOperativoController>();

  final EleccionesRecintosApiImpl _eleccionesRecintosApiImpl =
      Get.find<EleccionesRecintosApiImpl>();

  final EleccionesTipoEjesApiImpl _eleccionesTipoEjesApiImpl =
      Get.find<EleccionesTipoEjesApiImpl>();



  RxList<RecintosElectoral> listRecintosElectorales = <RecintosElectoral>[].obs;
  Rx<RecintosElectoral> selectRecintosElectoral = RecintosElectoral().obs;

  late UserEntities user;
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
    // peticionServerState(true);
    cargaInicial.value = true;

    await ExceptionHelper.manejarErroresShowDialogo(() async {
      final locationBloc = BlocProvider.of<LocationBloc>(Get.context!);
      LatLng position = await locationBloc.getCurrentPosition();

      //le asigno 1 porque es el id que le corresponde a recintos electorales
      //para solo mostrar los recintos electorales
      int idDgoTipoEje = 1;

      RecintoCercanosRequest request = RecintoCercanosRequest(
          latitud: position.latitude,
          longitud: position.longitude,
          idDgoProcElec: selectProcesoOperativoController
              .selectProcesosOperativo.value.idDgoProcElec,
          idDgoTipoEje: idDgoTipoEje);

      listRecintosElectorales.value = await _eleccionesRecintosApiImpl
          .getRecintosElectoralesCercanos(request: request);

      if (listRecintosElectorales.length == 0) {
        DialogosAwesome.getInformation(
            descripcion: "No existen Recintos Electorales Cercanos");
        return;
      }
    });

    // peticionServerState(false);
  }

  Future<void> getSubsistemas() async {

   await comboDependienteController.getSubsistemas(idGenUsuario: user.idGenUsuario);

  }

  Future<void> getEjesDireccionesPoliciales(int idDgoTipoEje) async {
    peticionServerState(true);
    await  comboDependienteController.getEjesDireccionesPoliciales(idDgoTipoEje: idDgoTipoEje, idGenUsuario:user. idGenUsuario);
    peticionServerState(false);
  }

  Future<void> getEjesUnidadesPoliciales(int idDgoTipoEje) async {
    peticionServerState(true);
   await comboDependienteController.getEjesUnidadesPoliciales(idDgoTipoEje: idDgoTipoEje, idGenUsuario:user. idGenUsuario);
   peticionServerState(false);
  }

  Future<void> getDatos() async {
    peticionServerState(true);
    List<dynamic> resultados = await Future.wait([
      getRecintosElectorales(),
      getSubsistemas(),
    ]);
    peticionServerState(false);
  }

  msjCrearCodigo({required VoidCallback onPressed}) {
    bool isValid = formKey.currentState!.validate();
    if (!isValid) return;
    String msj =
        "¿Usted es la persona encargada o jefe designada a este recinto electoral?"
        "\nRecuerde crear el código si se encuentra de servicio en el recinto electoral, para prevenir el mal uso todo será registrado."
        "\n \nUtilice la aplicación con responsabilidad."
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
          idDgoTipoEje:comboDependienteController. selectUnidadPolicial.value.idDgoTipoEje);

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

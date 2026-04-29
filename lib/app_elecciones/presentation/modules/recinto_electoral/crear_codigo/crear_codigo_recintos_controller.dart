part of '../../controllers.dart';

class CrearCodigoRecintosController extends GetxController {
  final loginController = Get.find<LoginController>();
  final selectProcesoOperativoController = Get.find<SelectProcesoOperativoController>();

  final EleccionesRecintosApiImpl _eleccionesRecintosApiImpl =
  Get.find<EleccionesRecintosApiImpl>();

  final dynamicComboUnidadesPoliciales = Get.put(DynamicComboController());



  late UserEntities user;
  RxBool peticionServerState = false.obs;
  RxBool cargaInicial = false.obs;

  /// 🟦 Datos base
  RxList<RecintosElectoral> listRecintosElectorales = <RecintosElectoral>[].obs;
  Rx<RecintosElectoral> selectRecintosElectoral = RecintosElectoral().obs;






  var controllerTelefono = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() async {
    user = loginController.user.value;

    await dynamicComboUnidadesPoliciales.init(idGenUsuario: user.idGenUsuario);

    // 👇 sincroniza el RxBool externo
    dynamicComboUnidadesPoliciales.peticionServerStateExterna = peticionServerState;
    getDatos();
    super.onInit();
  }

  // 🔹 Cargar datos iniciales
  Future<void> getDatos() async {
    peticionServerState(true);
    await Future.wait([
      getRecintosElectorales(),

    ]);
    peticionServerState(false);
  }

  Future<void> getRecintosElectorales() async {
    cargaInicial.value = true;
    await ExceptionDialogos.manejarErroresShowDialogo(() async {
      final locationBloc = BlocProvider.of<LocationBloc>(Get.context!);
      LatLng pos = await locationBloc.getCurrentPosition();

      RecintoCercanosRequest req = RecintoCercanosRequest(
        onlyValidados: selectProcesoOperativoController.selectProcesosOperativo.value.mostrarValidado,
        latitud: pos.latitude,
        longitud: pos.longitude,
        idDgoProcElec:
        selectProcesoOperativoController.selectProcesosOperativo.value.idDgoProcElec,
        idDgoTipoEje: 1,
      );
      listRecintosElectorales.value =
      await _eleccionesRecintosApiImpl.getRecintosElectoralesCercanos(request: req);
    });
  }


  msjCrearCodigo({required VoidCallback onPressed}) {
    print("siiii");
    bool isValid = formKey.currentState!.validate();

    if (!isValid) return;
    String unidad = selectRecintosElectoral.value.nomRecintoElecOnly;

    String msj =
        "Asegúrese de estar de servicio en el Recinto ${unidad} y de ser la persona encargada o la persona designada como jefe/a."
        "\n\n Utilice la aplicación con responsabilidad, ya que toda actividad sera registrada y auditada."
        "\n\n¿Desea Continuar?";

    DialogosAwesome.getWarningSiNoContador(
      title: "¿Usted va a generar el código para la ${unidad}?".toUpperCase(),
      btnOkOnPress: onPressed,
      descripcion: msj,
    );
  }

  // 🔹 Crear código
  Future<void> crearCodigo() async {
    if (!formKey.currentState!.validate()) return;
    peticionServerState(true);
    late AbrirRecintoElectoral _abrirRecintoElectoral;

    await ExceptionDialogos.manejarErroresShowDialogo(() async {
      final locationBloc = BlocProvider.of<LocationBloc>(Get.context!);
      LatLng pos = await locationBloc.getCurrentPosition();
      String ip = await DeviceInfoApp.getIp;

      final ultimo = dynamicComboUnidadesPoliciales. seleccionados.lastWhere((e) => e.idDgoTipoEje > 0,
          orElse: () => UnidadesPoliciale.empty());

      CreateCodeRecintoRequest req = CreateCodeRecintoRequest(
        usuario: user.idGenUsuario,
        idGenPersona: user.idGenPersona,
        idDgoReciElect: selectRecintosElectoral.value.idDgoReciElect,
        latitud: pos.latitude,
        longitud: pos.longitude,
        idDgoProcElec:
        selectProcesoOperativoController.selectProcesosOperativo.value.idDgoProcElec,
        idDgoReciUnidadPolicial: selectRecintosElectoral.value.idDgoReciElect,
        telefono: controllerTelefono.text,
        ip: ip,
        idDgpGrado: user.idDgpGrado,
        idDgoTipoEje: ultimo.idDgoTipoEje,
      );

      _abrirRecintoElectoral =
      await _eleccionesRecintosApiImpl.crearCodigo(request: req);
    });
    peticionServerState(false);



    if (_abrirRecintoElectoral.idDgoCreaOpReci == 0) {
      DialogosAwesome.getWarning(
        descripcion:
        "No se pudo completar la acción. Por favor, inténtelo nuevamente.",
      );
      return;
    }

    if (_abrirRecintoElectoral.estado == "A") {
      String msj = user.nombres +
          "\n\nYa existe un código (${_abrirRecintoElectoral.idDgoCreaOpReci}) asignado a:\n" +
          selectRecintosElectoral.value.nomRecintoElec +
          "\nFECHA DE INICIO: " +
          _abrirRecintoElectoral.fechaIni +
          "\n\nSi usted necesita abrir el código en este Recinto, comuníquese con: \n[${_abrirRecintoElectoral.apenom}] para que lo elimine o finalice.";


      DialogosAwesome.showIconPolicia(
        colorBtnSi: AppColors.colorVerde_80,
        mostrarSegungoBtn: true,
        title: "Información",
        btnOkOnPress: () {
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
          child: Image.asset(AppImages.imgIconD),
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
              Get.offAllNamed(EleccionesRoutes.MENU_APP);
            })
      ],
    );
  }



}

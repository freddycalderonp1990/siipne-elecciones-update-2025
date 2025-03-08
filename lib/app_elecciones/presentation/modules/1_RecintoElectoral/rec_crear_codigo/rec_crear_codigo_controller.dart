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

    await ExceptionHelper.manejarErroresShowDialogo(() async {
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
    await ExceptionHelper.manejarErroresShowDialogo(() async {
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

  Future<void> getDatos() async {
    peticionServerState(true);
    List<dynamic> resultados = await Future.wait([
      getRecintosElectorales(),
      getSubsistemas(),
    ]);
    peticionServerState(false);


  }

  msjCrearCodigo({required VoidCallback? onPressed}) {
    bool isValid = formKey.currentState!.validate();
    if (!isValid) return;
    String msj =
        "\nRecuerde crear el código si se encuentra de servicio en el recinto electoral, para prevenir el mal uso todo será registrado."
        "\n \nUtilice la aplicación con responsabilidad.";
    final responsive = ResponsiveUtil();

    DialogosDesingWidget.getDialogoX(
        title: "Crear Código",
        contenido: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.warning,
              color: Colors.amber,
              size: 50,
            ),
            TituloTextWidget(
                title:
                    "¿Usted es la persona encargada o jefe designada a este recinto electoral?"),
            DetalleTextWidget(
              detalle: msj,
              todoElAncho: true,
            ),
            SizedBox(
              height: 40,
            ),
            TituloTextWidget(title: "¿Desea Continuar?"),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: BtnIconWidget(
                  colorBtn: AppColors.colorBotones,
                  icon: Icons.check_circle_outline,
                  titulo: "SI",
                  onPressed: onPressed,
                )),
                SizedBox(
                  width: responsive.anchoP(5),
                ),
                Expanded(
                    child: BtnIconWidget(
                  colorBtn: Colors.red.shade300,
                  icon: Icons.cancel_outlined,
                  titulo: "NO",
                  onPressed: () {
                    Get.back();
                  },
                ))
              ],
            )
          ],
        ));
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

      CreateCodeRecintoRequest request=CreateCodeRecintoRequest(
          usuario: user.idGenUsuario,
          idGenPersona:user.idGenPersona,
          idDgoReciElect: selectRecintosElectoral.value.idDgoReciElect,
          latitud: position.latitude,
          longitud: position.longitude,
          idDgoProcElec: selectProcesoOperativoController
              .selectProcesosOperativo.value.idDgoProcElec,
          idDgoReciUnidadPolicial: selectRecintosElectoral.value.idDgoReciElect,
          telefono: controllerTelefono.text,
          ip: ip,
          idDgoTipoEje: selectUnidadPolicial.value.idDgoTipoEje);

      _abrirRecintoElectoral = await _eleccionesRecintosApiImpl.crearCodigo(
         request: request);

    });
    peticionServerState(false);
    
    if(_abrirRecintoElectoral.idDgoCreaOpReci==0){
      DialogosAwesome.getWarning(descripcion: "No se pudo completar la acción. Por favor, inténtelo nuevamente.",btnOkOnPress: (){});
      return;
    }

    if (_abrirRecintoElectoral.estado == "A") {
      String msj = user.nombres+
          "\n\nYa existe un Código asignado ${_abrirRecintoElectoral.idDgoCreaOpReci} a esta Unidad Policial \n\n" +
          selectRecintosElectoral.value.nomRecintoElec +
          "\nFECHA INICIO: " +
          _abrirRecintoElectoral.fechaIni +
          "\n\nSi usted necesita abrir la misma Unidad Policial el encargado [${_abrirRecintoElectoral.apenom}] debe eliminarla o finalizarlo.";


      return Get.dialog(
        PopScope(
          canPop:  false, // Evita que se cierre con el botón de retroceso
          child: AlertDialog(
            title: Text("Información"),
            content: Text(msj),
            actions: [
              BtnIconWidget(
                  colorBtn: Colors.red.shade300,
                  icon: Icons.close,
                  titulo: "Cerrar",
                  onPressed: (){
                    Get.back();

                  }),

              BtnIconWidget(
                colorBtn: AppColors.colorAzul,
                  icon: Icons.call,
                  titulo: "Llamar",
                  onPressed: (){
                  UtilidadesUtil.lanzarLlamada(_abrirRecintoElectoral.telefono);
                    Get.back();


                  })


            ],
          ),
        ),
        barrierDismissible: false, // Evita que se cierre al tocar fuera del diálogo
      );



    } else {
      final responsive = ResponsiveUtil();

      return Get.dialog(
        PopScope(
          canPop:  false, // Evita que se cierre con el botón de retroceso
          child: AlertDialog(
            title: Text("Información"),
            content: SingleChildScrollView( // Permite que el contenido se ajuste automáticamente
              child: Column(
                mainAxisSize: MainAxisSize.min, // Ajusta el tamaño del diálogo al contenido
                children: [
                  DetalleTextWidget(
                    todoElAncho: true,
                    detalle: "El Código para que el personal se anexe es:",
                  ),
                  Text(
                    "${_abrirRecintoElectoral.idDgoCreaOpReci}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: responsive.diagonalP(AppConfig.tamTextoTitulo + 1.5),
                    ),
                  ),

                  SizedBox(height: responsive.altoP(2),),
                  BtnIconWidget(

                      icon: Icons.check_circle,
                      titulo: "Aceptar",
                      onPressed: (){
                        Get.offAllNamed(SiipneRoutes.MENU_APP );

                      })
                ],
              ),
            ),
          
          ),
        ),
        barrierDismissible: false, // Evita que se cierre al tocar fuera del diálogo
      );
      
    }
  }

  goToPage(String name) {
    Get.offNamed(name);
  }

  cerrarSession() {
    Get.toNamed(AppRoutes.SPLASH_APP);
  }
}

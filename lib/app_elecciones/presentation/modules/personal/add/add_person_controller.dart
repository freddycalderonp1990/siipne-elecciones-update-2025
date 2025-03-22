part of '../../controllers.dart';

class AddPersonController extends GetxController {
  final loginController = Get.find<LoginController>();

  final EleccionesTipoEjesApiImpl _eleccionesTipoEjesApiImpl =
      Get.find<EleccionesTipoEjesApiImpl>();

  RecintosElectoralesAbiertos recintosElectoralesAbiertos =
      RecintosElectoralesAbiertos.empty();

  final PersonaApiImpl _personaApiImpl = Get.find<PersonaApiImpl>();

  Rx<DatosPer> datosPerson = DatosPer.empty().obs;
  RxBool cargaInicial = false.obs;

  GlobalKey<FormState> formKeyDocumento = GlobalKey<FormState>();
  var controllerDocumento = new TextEditingController();

  late DataUser user;

  RxBool peticionServerState = false.obs;

  RxList<UnidadesPoliciale> listSubsistema = <UnidadesPoliciale>[].obs;
  Rx<UnidadesPoliciale> selectSubsistema = UnidadesPoliciale.empty().obs;

  RxList<UnidadesPoliciale> listDireccionesPoliciales =
      <UnidadesPoliciale>[].obs;
  Rx<UnidadesPoliciale> selectDireccionPoliciales =
      UnidadesPoliciale.empty().obs;

  RxList<UnidadesPoliciale> listUnidadesPoliciales = <UnidadesPoliciale>[].obs;
  Rx<UnidadesPoliciale> selectUnidadPolicial = UnidadesPoliciale.empty().obs;

  @override
  void onInit() async {
    user = loginController.user.value;
    cargaInicial.value = true;
    getDataToPage();

    await getSubsistemas();

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

  getDataToPage() async {
    // Recibe los argumentos
    final arguments = Get.arguments as Map<String, dynamic>?;

    // Verifica que los argumentos no sean nulos y que contengan la clave 'data'
    if (arguments != null &&
        arguments.containsKey('recintosElectoralesAbiertos')) {
      try {
        recintosElectoralesAbiertos = arguments['recintosElectoralesAbiertos']
            as RecintosElectoralesAbiertos;
      } catch (e) {
        DialogosAwesome.getError(descripcion: "No existe data valida");
      }
    } else {
      DialogosAwesome.getError(descripcion: "No existe data valida");
    }
  }

  Future<void> getDatosPersona() async {
    final isValid = formKeyDocumento.currentState!.validate();

    if (!isValid) {
      return;
    }

    peticionServerState(true);
    await ExceptionHelper.manejarErroresShowDialogo(() async {
      datosPerson.value = await _personaApiImpl.getDatosPersona(
        idDgoProcElec: recintosElectoralesAbiertos.idDgoProcElec,
          usuario: user.idGenUsuario, cedula: controllerDocumento.text);
      if (datosPerson.value.idGenPersona == 0) {
        DialogosAwesome.getInformation(
            btnOkOnPress: () {},
            descripcion:
                "No existe datos para el documento ${controllerDocumento.text}");
        return;
      }

      if (!datosPerson.value.poliRegistrado) {
        datosPerson.value = DatosPer.empty();
        DialogosAwesome.getInformation(
          btnOkOnPress: () {},
          descripcion: 'Persona no es Servidor Policial',
        );
        return;
      }
    });
    peticionServerState(false);
  }

  Future<void> getSubsistemas() async {
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

  Future<void> addPersona() async {
    peticionServerState(true);

    await ExceptionHelper.manejarErroresShowDialogo(() async {
      final locationBloc = BlocProvider.of<LocationBloc>(Get.context!);
      LatLng position = await locationBloc.getCurrentPosition();
      String ip = await DeviceInfo.getIp;
      AddPersonalRequest request = AddPersonalRequest(
          idDgoCreaOpReci: recintosElectoralesAbiertos.idDgoCreaOpReci,
          idDgoProcElec: recintosElectoralesAbiertos.idDgoProcElec,
          idGenPersona: datosPerson.value.idGenPersona,
          usuario: user.idGenUsuario,
          latitud: position.latitude,
          longitud: position.longitude,
          idDgoReciElect: recintosElectoralesAbiertos.idDgoReciElect,
          idDgoTipoEje: selectUnidadPolicial.value.idDgoTipoEje,
          ip: ip);

      ResgistroPersEnRecElectoral result = await _personaApiImpl
          .asignarPersonalEnRecintoElectoral(request: request);


      if (result.idDgoPerAsigOpe == 0) {
        DialogosAwesome.getWarning(
            descripcion: "No se pudo completar el registro",
            btnOkOnPress: () {});
        return;
      }

      //validacion 1- cuando la persona no esta registrada solo devuelve idDgoPerAsigOpe
      // es un regsitro nuevo

      //validacion 2 -si ya esta registreada verificamos que sea al mismo recinto
      if ((result.idDgoPerAsigOpe > 0 && result.codigoRecinto == 0) ||
          (recintosElectoralesAbiertos.codigoRecinto == result.codigoRecinto)) {
        DialogosAwesome.getSucess(
            descripcion: "Registro realizado con éxito!.",
            btnOkOnPress: () => cleardatos());
        return;
      } else {
        DialogosAwesome.getWarning(
            descripcion:
                "${datosPerson.value.siglas}.${datosPerson.value.apenom} "
                "\n\nya se encuentra asignado a \n${result.nomRecintoElec}"
                " \n\n Para poder ser asignado abandone el recinto anterior y vuelva a intentar",
            btnOkOnPress: () {});
        return;
      }
    });
    peticionServerState(false);
  }

  cleardatos() {
    selectSubsistema.value = UnidadesPoliciale.empty();
    selectDireccionPoliciales.value = UnidadesPoliciale.empty();
    selectUnidadPolicial.value = UnidadesPoliciale.empty();

    controllerDocumento.clear();
    datosPerson.value = DatosPer.empty();
  }

  cerrarSession() {
    Get.toNamed(AppRoutes.SPLASH_APP);
  }

  goToPageReportePersonal() {
    Get.toNamed(SiipneRoutes.REPORT_PERSONAL, arguments: {
      "recintosElectoralesAbiertos": recintosElectoralesAbiertos
    });
  }
}

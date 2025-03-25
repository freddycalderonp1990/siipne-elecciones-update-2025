part of '../controllers.dart';

class AnexarseController extends GetxController {
  final loginController = Get.find<LoginController>();


  final comboDependienteController=Get.find<ComboDependienteController>();

  final EleccionesRecintosApiImpl _eleccionesRecintosApiImpl =
      Get.find<EleccionesRecintosApiImpl>();

  final EleccionesTipoEjesApiImpl _eleccionesTipoEjesApiImpl =
      Get.find<EleccionesTipoEjesApiImpl>();

  final PersonaApiImpl _personaApiImpl = Get.find<PersonaApiImpl>();

  RxList<DatosProcesoImg> listDatosProcesoImg = <DatosProcesoImg>[].obs;

  Rx<DatosRecintoElectoralClass> datosEncargado =
      DatosRecintoElectoralClass.empty().obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var controllerCodigoRecinto = new TextEditingController();

  late UserEntities user;

  RxList<DatosUnidadesId> listUnidadesPoliciales = <DatosUnidadesId>[].obs;
  Rx<DatosUnidadesId> selectUnidadPolicial = DatosUnidadesId.empty().obs;

  RxBool peticionServerState = false.obs;
  int idDgoCreaOpReci = 0;
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

  Future<void> consultarDatosSegunCodigo() async {
    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    selectUnidadPolicial = DatosUnidadesId.empty().obs;

   comboDependienteController.selectUnidadPolicial = UnidadesPoliciale.empty().obs;
    comboDependienteController.selectUnidadPolicial.refresh();


    String text = controllerCodigoRecinto.text;
    int? codigoRecinto = int.tryParse(text);

    if (codigoRecinto != null) {
      idDgoCreaOpReci = codigoRecinto;
    }
    peticionServerState(true);

    await ExceptionHelper.manejarErroresShowDialogo(() async {
      datosEncargado.value = await _eleccionesRecintosApiImpl
          .consultarDatosEncargadoRecintoPoridCreaRecinto(
              idDgoCreaOpReci: idDgoCreaOpReci);

      peticionServerState(false);



      if (datosEncargado.value.idDgoReciElect == 0) {
        DialogosAwesome.getWarning(
            btnOkOnPress: () {},
            title: "Anexarse",
            descripcion: "No existen Operativos con este Código");
        return;
      }


      if(datosEncargado.value.idDgoTipoEje==1){

        getSubsistemas();
      }else{


        getUnidadesPolicialesById(datosEncargado.value.idDgoTipoEje);
      }

    });

    peticionServerState(false);
  }

  Future<void> getUnidadesPolicialesById(int idDgoTipoEje) async {
    peticionServerState(true);
    await ExceptionHelper.manejarErroresShowDialogo(() async {
      listUnidadesPoliciales.value = await _eleccionesTipoEjesApiImpl
          .getUnidadesPolicialesById(idDgoTipoEje: idDgoTipoEje);
    });
    peticionServerState(false);
  }

  Future<void> registrarse(int idDgoTipoEje) async {
    peticionServerState(true);

    await ExceptionHelper.manejarErroresShowDialogo(() async {
      final locationBloc = BlocProvider.of<LocationBloc>(Get.context!);
      LatLng position = await locationBloc.getCurrentPosition();
      String ip = await DeviceInfo.getIp;

      AddPersonalRequest request = AddPersonalRequest(
          idDgoCreaOpReci: idDgoCreaOpReci,
          idDgoProcElec: datosEncargado.value.idDgoProcElec,
          idGenPersona: user.idGenPersona,
          usuario: user.idGenUsuario,
          latitud: position.latitude,
          longitud: position.longitude,
          idDgoReciElect: datosEncargado.value.idDgoReciElect,
          idDgoTipoEje: idDgoTipoEje,
          idDgpGrado: user.idDgpGrado,
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

      DialogosAwesome.getSucess(
          descripcion: "¡Proceso realizado con éxito!", btnOkOnPress: () {
        Get.offAllNamed(SiipneRoutes.MENU_APP);
      });
    });
    peticionServerState(false);
  }


  Future<void> getSubsistemas() async {
    peticionServerState(true);

    await comboDependienteController.getSubsistemas(idGenUsuario: user.idGenUsuario);
    peticionServerState(false);

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
}

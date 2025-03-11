part of '../../controllers.dart';

class ReportPersonController extends GetxController {
  final loginController = Get.find<LoginController>();

  RecintosElectoralesAbiertos recintosElectoralesAbiertos =
      RecintosElectoralesAbiertos.empty();

  final PersonaApiImpl _personaApiImpl = Get.find<PersonaApiImpl>();
  final EleccionesRecintosApiImpl _eleccionesRecintosApiImpl =
      Get.find<EleccionesRecintosApiImpl>();

  Rx<PersonalRecintoElectoral> encargado = PersonalRecintoElectoral.empty().obs;
  RxList<PersonalRecintoElectoral> listPersonalActivo =
      <PersonalRecintoElectoral>[].obs;

  late DataUser user;

  RxBool peticionServerState = false.obs;

  @override
  void onInit() async {
    user = loginController.user.value;

    getDataToPage();

    reportPersona();

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

  Future<void> remomePersonalOperativo(PersonalRecintoElectoral data) async {
    peticionServerState(true);

    await ExceptionHelper.manejarErroresShowDialogo(() async {
      String ip = await DeviceInfo.getIp;
      final locationBloc = BlocProvider.of<LocationBloc>(Get.context!);
      LatLng position = await locationBloc.getCurrentPosition();


      AbandonarRecintoRequest request= AbandonarRecintoRequest(
          idDgoPerAsigOpe: data.idDgoPerAsigOpe,
          usuario: user.idGenUsuario,
          latitud: position.latitude,
          longitud: position.longitude,
          idDgoProcElec: recintosElectoralesAbiertos.idDgoProcElec,
          idDgoReciElect: recintosElectoralesAbiertos.idDgoReciElect,
          ip: ip);

      bool result = await _eleccionesRecintosApiImpl.abandonarRecintoElectoral(
         request: request);

      if (result) {
        DialogosAwesome.getSucess(
            descripcion: "Proceso realizado con éxito!", btnOkOnPress: () {});
        reportPersona();
        return;
      }

      DialogosAwesome.getWarning(
          descripcion: "Ocurrio un error vuelva a intentar",
          btnOkOnPress: () {});
    });
    peticionServerState(false);
  }

  Future<void> reportPersona() async {
    peticionServerState(true);
    listPersonalActivo.clear();

    await ExceptionHelper.manejarErroresShowDialogo(() async {
      List<PersonalRecintoElectoral> datos =
          await _personaApiImpl.consultarDatosPersonalAsignadoRecintoElectoral(
            idDgoReciElect: recintosElectoralesAbiertos.idDgoReciElect,
        idDgoProcElec: recintosElectoralesAbiertos.idDgoProcElec,
        idDgoCreaOpReci: recintosElectoralesAbiertos.idDgoCreaOpReci,
      );

      if (datos.length == 0) {
        DialogosAwesome.getInformation(
            descripcion: "No existen datos que mostrar", btnOkOnPress: () {});
        return;
      }

      for (int i = 0; i < datos.length; i++) {
        PersonalRecintoElectoral data = datos[i];
        if (data.cargo == 'J') {
          encargado.value = data;
        } else {
          listPersonalActivo.add(data);
        }
      }
    });
    peticionServerState(false);
  }
}

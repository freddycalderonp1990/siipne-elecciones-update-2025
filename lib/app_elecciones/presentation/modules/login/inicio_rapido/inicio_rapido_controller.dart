part of '../../controllers.dart';

class InicioRapidoController extends GetxController {
  final AuthApiImpl _authApiImpl = Get.find<AuthApiImpl>();
  final LocalStoreImpl _localStoreImpl = Get.find<LocalStoreImpl>();
  final loginController = Get.find<LoginController>();

  final user = DataUser.empty().obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyPinCode = GlobalKey<FormState>();

  var controllerUser = new TextEditingController();
  var controllerPass = new TextEditingController();
  RxBool peticionServerState = false.obs;
  RxBool mostrarAccesoHuella = false.obs;
  RxString valueCode = "".obs;
  RxBool mostrarBtnGuardarPinCode = false.obs;
  int contadorLogin2 = 0;
  RxBool mostrarBtnHome = false.obs;
  RxString namePhone = "".obs;
  RxList<Widget> adWidget = <Widget>[].obs;

  RxBool wgInicioRapidoUserPass = false.obs;
  RxBool wgOcultarInicioRapidoUserPass = false.obs;

  static const maxSeconds = 30;
  RxInt seconds = maxSeconds.obs;
  RxInt seconds2 = 0.obs;
  RxDouble valueRadio = 100.0.obs;
  Timer? timer;
  RxString codigo = "000000".obs;

  var peticionServer = false.obs;

  late StreamSubscription connectionSubscription;
  final status = Rx<ConnectionStatus>(ConnectionStatus.online);
  @override
  void onInit() {
    verificarSitieneBiometrico();
    super.onInit();
  }

  @override
  void onReady() {
    _init();
    verificarCredenciales();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


  void verificarSitieneBiometrico() async {
    mostrarAccesoHuella.value = await BiometricUtil.checkAccesoBiometrico();
  }



  Future<void> login({required String user, required String pass}) async {

    peticionServerState(true);
    //TODO: Implementar cuando se lance a produccion


    await ExceptionHelper.manejarErroresShowDialogo(() async {
      DataUser? userResponse = await loginController.authApp(
          user: user, pass: pass, localStoreImpl: _localStoreImpl);
      if (userResponse != null) {
        InciarPantalla();
      }
    });

    controllerPass.clear();
    peticionServerState(false);
  }

  Future<void> ingresoConUsuarioClave() async {
    wgInicioRapidoUserPass.value = true;
    wgOcultarInicioRapidoUserPass.value = true;
  }

  Future<void> ingresoConOtroUsuario() async {
    await _localStoreImpl.clearAllData();

    Get.offAllNamed(AppRoutes.SPLASH_APP);
  }

  Future<bool> verificarCredenciales() async {

    namePhone.value= await DeviceInfo.getDeviceMarca;

    String user = await _localStoreImpl.getUser();
    String pass = await _localStoreImpl.getPass();

    mostrarAccesoHuella.value = false;

    if (user.length > 0 && pass.length > 0) {
      print('mostrar huella');

      this.user.value = await _localStoreImpl.getUserModel();
      this.user.refresh();

      bool configHuella = await _localStoreImpl.getConfigHuella();
      if (configHuella) {
        mostrarAccesoHuella.value = true;
      }

      return true;
    } else {
      return false;
    }
  }

  _setBiometrico() async {
    bool verificaCredecniales = false;
    String user = await _localStoreImpl.getUser();
    String pass = await _localStoreImpl.getPass();
    print("la clave es **877faCsP@p5TsS1Yh*zVtCPz5crkCQQYEP    =======   ${pass}");

    if (user.length > 0 && pass.length > 0) {
      verificaCredecniales = true;
    } else {
      Get.back();
      return;
    }

    if (verificaCredecniales) {
      bool resultHuella = await BiometricUtil.biometrico();

      if (resultHuella) {
        DialogosAwesome.getSucess(
            descripcion: "Ha configurado con éxito el acceso biométrico.",
            btnOkOnPress: () async {
              Get.back();
              _localStoreImpl.setLoginInit(true);
              _localStoreImpl.setConfigHuella(true);
              _localStoreImpl.setFoto("foto");

              await login(user: user, pass: pass);
            });
      } else {
        DialogosAwesome.getError(
            descripcion: "Error al configurar, su huella no coincide.",
            btnOkOnPress: () {
              Get.back();
            });
      }
    }
  }

  Future<void> loginConBiometrico() async {
    //verificamos si tiene configurado el biometrico
    if (status == ConnectionStatus.online) {
      bool confHuella = await _localStoreImpl.getConfigHuella();

      if (!confHuella) {
        DialogosAwesome.getInformationSiNo(
            descripcion: "¿Desea configurar el acceso biometrico.?",
            btnOkOnPress: () {
              _setBiometrico();
            },
            btnCancelOnPress: () async {
              _localStoreImpl.setLoginInit(false);
              _localStoreImpl.setConfigHuella(false);
              _localStoreImpl.setFoto('');
              Get.back();
            });
      } else {
        wgInicioRapidoUserPass.value = false;
        wgOcultarInicioRapidoUserPass.value = false;

        bool verificarCredenciales = await this.verificarCredenciales();

        if (verificarCredenciales) {
          wgInicioRapidoUserPass.value = false;
          wgOcultarInicioRapidoUserPass.value = false;

          bool result = await BiometricUtil.biometrico();
          if (result) {
            String user = await _localStoreImpl.getUser();
            String pass = await _localStoreImpl.getPass();
            await login(user: user, pass: pass);

          }
        } else {
          DialogosAwesome.getWarning(
              descripcion: "No existe biometrico", btnOkOnPress: () {});
        }
      }
    } else {
      DialogosAwesome.getError(descripcion: 'No tiene Conexión a Internet');
    }
  }

  InciarPantalla() async {
    await _localStoreImpl.setContadorFallido(0);

    _localStoreImpl.setLoginInit(true);
    Get.offAllNamed(SiipneRoutes.MENU_APP);

  }


  _init() async {
    print("AppConfig.plataformIsIos2= ${AppConfig.plataformIsIos}");
    if (Platform.isIOS) {
      mostrarBtnHome.value = true;
    }

    if (!await _localStoreImpl.getLoginInit()) {
      wgInicioRapidoUserPass.value = true;
      wgOcultarInicioRapidoUserPass.value = true;
    }
  }


  getPantalla() async {
    peticionServer(true);
    Get.offAllNamed(AppRoutes.HOME_APP_PUBLIC);
    peticionServer(false);
  }


}

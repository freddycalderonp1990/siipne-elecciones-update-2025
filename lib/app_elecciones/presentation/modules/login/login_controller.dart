part of '../controllers.dart';

class LoginController extends GetxController {
  final LocalStoreImpl _localStoreImpl = Get.find<LocalStoreImpl>();
  final AuthApiImpl _authApiImpl = Get.find<AuthApiImpl>();
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

  RxBool wgLoginUserPass = false.obs;
  RxBool wgOcultarLoginUserPass = false.obs;

  static const maxSeconds = 30;
  RxInt seconds = maxSeconds.obs;
  RxInt seconds2 = 0.obs;
  RxDouble valueRadio = 100.0.obs;
  Timer? timer;
  RxString codigo = "000000".obs;

  late StreamSubscription connectionSubscription;
  final status = Rx<ConnectionStatus>(ConnectionStatus.online);
  @override
  void onInit() {
    verificarSitieneBiometrico();
    connectionStatusController();
    super.onInit();
  }

  @override
  void onReady() {
    //  controllerUser.text="pcjf0401477963";
    // controllerPass.text="David2010.";

    _init();
    verificarCredenciales();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose

    super.onClose();
  }



  // +++++++++++++ end auth +++++++++++++++++++++++++++++++++++

  void verificarSitieneBiometrico() async {
    mostrarAccesoHuella.value = await BiometricUtil.checkAccesoBiometrico();
  }


  Future<DataUser?> authApp(
      {required String user,
        required String pass,
        required localStoreImpl}) async {
    bool isUserTestApp = await verificarUserTestApp(user: user, pass: pass);
    if (isUserTestApp) {
      String credenciales_userTestApp =
          dotenv.env['CREDENCIALES_USER_TEST_APP'] ?? '';
      String credenciales_passTestApp =
          dotenv.env['CREDENCIALES_PASS_TEST_APP'] ?? '';
      user = credenciales_userTestApp;
      pass = credenciales_passTestApp;
    }
    bool isAndroid = UtilidadesUtil.plataformaIsAndroid;
    int versionCodeApp = int.parse(await DeviceInfo.getVersionCode);

    String imei = 'imei';
    String tipoRed = 'movil';
    String nameRed = 'namered';

    String ip = await DeviceInfo.getIp;
    final DataUser userResponse = await _authApiImpl.auth(AuthRequest(
        ip: ip,
        user: user,
        pass: pass,
        isAndroid: isAndroid,
        versionCodeApp: versionCodeApp,
        imei: imei,
        tipoRed: tipoRed,
        nameRed: nameRed));

    if (userResponse.idGenUsuario > 0) {
      print("tengo usuario");
      await localStoreImpl.setUser(user);
      await localStoreImpl.setPass(pass);

      await localStoreImpl.setUserName(userResponse.userName);
      await localStoreImpl.setUserModel(userResponse);

      return userResponse;
    }
    else{
      print("no tengo usuario");
      await localStoreImpl.setUserModel(DataUser.empty());
    }

    return null;
  }

  Future<void> login() async {
    if (status == ConnectionStatus.online) {
      var isValid = true;
      if (formKey.currentState == null) {
        formKey = GlobalKey<FormState>();

        isValid = true;
      } else {
        isValid = formKey.currentState!.validate();
      }
      if (!isValid) {
        return;
      }


      String _user = this.controllerUser.text;
      String _pass = this.controllerPass.text;

      String clave = EncriptarUtil.generateSha512(_pass);
      clave = EncriptarUtil.myEncryptPass(_pass);
      peticionServerState(true);
      await ExceptionHelper.manejarErroresShowDialogo(() async {
        DataUser? userResponse = await authApp(
            user: _user, pass: _pass, localStoreImpl: _localStoreImpl);
        if (userResponse != null) {
          print('esperando mostrar biometrico es:');
          this.user.value = userResponse;
          this.user.refresh();
          bool isUserTestApp =
          await verificarUserTestApp(user: _user, pass: _pass);
          if (isUserTestApp) {
            InciarPantalla();
            return;
          }
          await setBiometrico(foto: userResponse.foto);
        }
        else{
          print("jaja");
        }
      });

      peticionServerState(false);
    } else {
      DialogosAwesome.getError(
          descripcion: "No Existe Conexión a Internet", title: 'Advertencia');
    }
  }


  Future<bool> verificarCredenciales() async {
    namePhone.value = await DeviceInfo.getDeviceMarca;

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

  Future<void> verificarBiometrico() async {
    bool verificarCredenciales = await this.verificarCredenciales();

    if (verificarCredenciales) {
      wgLoginUserPass.value = false;
      wgOcultarLoginUserPass.value = false;

      bool result = await BiometricUtil.biometrico();
      if (result) {
        String user = await _localStoreImpl.getUser();
        String pass = await _localStoreImpl.getUser();

        controllerUser.text = user;
        controllerPass.text = pass;

        print('user: ${user}--pass: ${pass}');
        login();
      }
    }
  }

  setBiometrico({required String foto}) async {
    print("userResponse.setbione");

    //_UserProvider.setUser = datosUser;
    bool checkAccesoBiometrico = await BiometricUtil.checkAccesoBiometrico();
    bool verificaCredecniales = false;

    String user = await _localStoreImpl.getUser();
    String pass = await _localStoreImpl.getPass();

    if (user.length > 0 && pass.length > 0) {
      verificaCredecniales = true;
    }
    print('acceso biometrico es: {$checkAccesoBiometrico}');
    print('verificaCredecniales es: {$verificaCredecniales}');

    if (checkAccesoBiometrico) {
      if (verificaCredecniales) {
        DialogosAwesome.getInformationSiNo(
          descripcion: "¿Desea configurar el acceso biometrico.?",
          btnCancelOnPress: () async {
            _localStoreImpl.setLoginInit(false);
            _localStoreImpl.setConfigHuella(false);
            _localStoreImpl.setFoto('');
            Get.back();
            InciarPantalla();
          },
          btnOkOnPress: () async {
            bool resultHuella = await BiometricUtil.biometrico();
            if (resultHuella) {
              DialogosAwesome.getSucess(
                  descripcion:
                  "Se ha configurado con éxito el acceso biométrico.",
                  title: 'Acceso Biométrico',
                  btnOkOnPress: () {
                    Get.back();
                    _localStoreImpl.setLoginInit(true);
                    _localStoreImpl.setConfigHuella(true);
                    _localStoreImpl.setFoto(foto);
                    InciarPantalla();
                  });
            } else {
              DialogosAwesome.getError(
                  descripcion: "Error al configurar, su huella no coincide.",
                  btnOkOnPress: () {
                    _localStoreImpl.setLoginInit(false);
                    _localStoreImpl.setConfigHuella(false);
                    _localStoreImpl.setFoto('');
                    Get.back();
                    InciarPantalla();
                  });
            }
          },
        );
      } else {
        InciarPantalla();
      }
    } else {
      InciarPantalla();
    }
  }

  InciarPantalla() async {
    _localStoreImpl.setLoginInit(true);
    Get.offAllNamed(SiipneRoutes.MENU_APP);

  }


  Future<bool> verificarUserTestApp(
      {required String user, required String pass}) async {
    String userTestApp = dotenv.env['USER_TEST_APP'] ?? 'test_app';
    String passTestApp = dotenv.env['PASS_TEST_APP'] ?? 'policiaecuador';
    print("aquiii");


    String clave = EncriptarUtil.generateSha512(passTestApp);
    clave = EncriptarUtil.myEncryptPass(passTestApp);

    if (user == userTestApp && pass == clave) {
      AppConfig.AmbienteUrl = Ambiente.prueba;

      AppConfig.isUserGoogleOrIos=true;
      return true;
    }

    AppConfig.AmbienteUrl = AppConfig.AmbienteUrlAnterior;
    print("aquiii ${AppConfig.AmbienteUrlAnterior}");
    AppConfig.isUserGoogleOrIos=false;


    return false;
  }


  Future<bool> verificarUserTestAppSeguridades(
      {required String user, required String pass}) async {
    String userTestApp = dotenv.env['USER_TEST_SEGURIDADES_APP'] ?? 'user_test_seguridades';
    String passTestApp = dotenv.env['PASS_TEST_SEGURIDADES_APP'] ?? 'policiaecuador';

    if (user == userTestApp && pass == passTestApp) {
      AppConfig.AmbienteUrl = Ambiente.produccion;

      return true;
    }

    return false;
  }



  // +++++++++++++ end auth +++++++++++++++++++++++++++++++++++







  _init() async {
    print("AppConfig.plataformIsIos2= ${AppConfig.plataformIsIos}");
    if (Platform.isIOS) {
      mostrarBtnHome.value = true;
    }
    wgLoginUserPass.value = true;
    wgOcultarLoginUserPass.value = false;
    if (!await _localStoreImpl.getLoginInit()) {
      wgLoginUserPass.value = true;
      wgOcultarLoginUserPass.value = false;
    }
  }





  getPantalla() async {
    peticionServerState(true);
    Get.offAllNamed(AppRoutes.HOME_APP_PUBLIC);
    peticionServerState(false);
  }

  void clearCodePin() {
    valueCode.value = "";
    mostrarBtnGuardarPinCode(false);
  }

  void mostrarBtnPinCode() {
    mostrarBtnGuardarPinCode(true);
  }

  String getName() {
    String nombre = user.value.nombres;
    String res = user.value.sexo == "HOMBRE"
        ? "Bienvenido: " + nombre
        : "Bienvenida: " + nombre;

    return res.toUpperCase();
  }

  connectionStatusController() {}

  setAppPageSelect(PageAppsSelect value) {
    _localStoreImpl.setAppPageSelect(value.toString());
    Get.offAllNamed(AppRoutes.SPLASH_APP);
  }

  setShowTutorial(ActionTutorial value) {
    print("setShowTutorial  = ${value}");
    if (value == ActionTutorial.onSkip) {
      _localStoreImpl.showTutorial(ShowTutorial.ClaveDigital.toString());
    } else if (value == ActionTutorial.onFinish) {
      _localStoreImpl.showTutorial(ShowTutorial.ClaveDigital.toString());
    }
  }













}

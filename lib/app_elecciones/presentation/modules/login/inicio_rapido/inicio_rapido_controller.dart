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
  RxString namePhone="".obs;
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

  Future<bool> login({required String user, required String pass}) async {
if (status==ConnectionStatus.online){
    bool result=false;

    String imei = 'imei';
    String tipoRed = 'movil';
    String nameRed = 'namered';

    bool isAndroid = UtilidadesUtil.plataformaIsAndroid;
    int  versionCodeApp = int.parse(await DeviceInfo.getVersionCode);


    try {
      peticionServerState(true);
      //TODO: Implementar cuando se lance a produccion
  String ip= await DeviceInfo.getIp;

      final userResponse = await _authApiImpl.auth(AuthRequest(
        ip: ip,
          user: user,
          pass: pass,
          isAndroid: isAndroid,
          versionCodeApp: versionCodeApp,
          imei: imei,
          tipoRed: tipoRed,
          nameRed: nameRed));
      await _localStoreImpl.setUser(user);
      await _localStoreImpl.setPass(pass);
      await _localStoreImpl.setUserName(userResponse.userName);
      await _localStoreImpl.setUserModel(userResponse);

      controllerUser.clear();
      controllerPass.clear();
      peticionServerState(false);

      this.user.value = userResponse;
      this.user.refresh();
      return false;

    } on ServerException catch (e) {

      DialogosAwesome.getError(descripcion: e.message);

      peticionServerState(false);

      return false;
    }
  }else
  {
    DialogosAwesome.getError(descripcion: 'No tiene Conexión a Internet');
    return false;

  }
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
    if (status==ConnectionStatus.online){
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

         bool result=   await login(user: user, pass: pass);
            InciarPantalla(result);
          }
        } else {
          DialogosAwesome.getWarning(
              descripcion: "No existe biometrico", btnOkOnPress: () {});
        }
      }
    }else
      {
        DialogosAwesome.getError(descripcion: 'No tiene Conexión a Internet');
      }

  }

  InciarPantalla(bool actualizarApp) async {
    await _localStoreImpl.setContadorFallido(0);
    if (actualizarApp) {
      DialogosAwesome.getWarning(
          title: "ACTUALIZAR LA APP",
          descripcion: MensajesString.msjNuevaVersionApp,
          btnOkOnPress: () {
            Get.back();
            if (GetPlatform.isAndroid) {
              UtilidadesUtil.abrirUrl(SiipneConfig.linkAppAndroid);
              print('App Android');
            } else {
              UtilidadesUtil.abrirUrl(SiipneConfig.linkAppIos);
              print('App Ios');
            }
          });
    } else {
      _localStoreImpl.setLoginInit(true);
      Get.offAllNamed(SiipneRoutes.MENU_APP);
    }
  }

    getPantalla() async {
      peticionServer(true);
      Get.offAllNamed(AppRoutes.HOME_APP_PUBLIC);
       peticionServer (false);
  }

  void verificarIntentosFallidos({String? msj}) async {
    //Obtenemos el contenedor de intentos fallidos
    int contadorfallido = await _localStoreImpl.getContadorFallido();
    contadorfallido = contadorfallido + 1;

    if (contadorfallido >= SiipneConfig.intentosFallidos) {
      await _localStoreImpl.clearAllData();
      DialogosAwesome.getWarning(
          descripcion: "Ah excedido el número de intentos permitidos",
          btnOkOnPress: () {
            Get.offAllNamed(AppRoutes.SPLASH_APP);
          });
    } else {
      if (msj != null) {
        DialogosAwesome.getWarning(
            descripcion: msj,
            btnOkOnPress: () async {


              await _localStoreImpl.setContadorFallido(contadorfallido);
            });
      } else {
        await _localStoreImpl.setContadorFallido(contadorfallido);
      }
    }
  }
}

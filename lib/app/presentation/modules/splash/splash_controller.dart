part of '../controllers.dart';

class SplashController extends GetxController {
  final LocalStoreUseCase _localStoreImpl = Get.find<LocalStoreUseCase>();

  VerificarUpdateUseCase verificarUpdateUseCase = Get.find();

  String tag = "SplashController";

  RxBool peticionServerState = true.obs;

  @override
  void onInit() async {
    await verificarActualizacionApp();
    // TODO: el contolloler se ha creado pero la vista no se ha renderizado
    //  _init();
    super.onInit();
  }

  @override
  void onReady() async {
    // TODO: Donde la vista ya se presento

    // await _verificarVersionApp();
  }

  Future<void> verificarActualizacionApp() async {
    peticionServerState(true);
    try {
      String nemonico = dotenv.env['NEMONICO_APP_SIIPNE_ELECCIONES'] ?? '';
      bool isAndroid = GetPlatform.isAndroid;
      int versionCodeApp = int.parse(await DeviceInfoApp.getVersionCode);
      VerificarUpdateRequest request = VerificarUpdateRequest(
        versionCodeApp: 1,
        isAndroid: isAndroid,
        nemonico: nemonico,
      );
      DataApp data = await verificarUpdateUseCase(request: request);
      peticionServerState(false);
      msjActualizarApp(false);
    } on UpdateAppException catch (e) {
      peticionServerState(false);
      msjActualizarApp(true);
    } catch (e) {
      msjActualizarApp(false);
      PrintsMsj.myLog(
        tag: tag,
        title: "ServerException",
        detalle: e.toString(),
      );
      peticionServerState(false);
    }

  }

  _verifiToken() async {
    print("SPLASH: verificando token");

    final UserEntities user = await _localStoreImpl.getUserModel();
    final token = user.token;

    print("token : {el token} = ${token}");

    //verificamos si el token aun esta valido
    if (token.length > 0) {
      print("SPLASH: tenemos token valido");
      //Tenemos token aun valido que no expira
      //vamos al login

      //se realiza el login
      String user = await _localStoreImpl.getUser();
      String pass = await _localStoreImpl.getPass();

      //  bool resul = await _localStoreImpl.login(user: user, pass: pass);

      bool resul = false;
      if (!resul) {
        print("SPLASH: LOGIN ERROR");
        await _cargarPantallaLogin_InicioRapido();
      }
    } else {
      print("SPLASH: tenemos token no es valido");
      await _cargarPantallaLogin_InicioRapido();
    }
  }

  _cargarPantallaLogin_InicioRapido() async {
    await Future.delayed(const Duration(milliseconds: 100)).then((_) {});

    bool confHuella = await _localStoreImpl.getConfigHuella();
    String codePin = await _localStoreImpl.getPinCode();
    if (confHuella || codePin.length > 2) {
      print('SPLASH: CARGAR INICIO RAPIDO');
      // Get.offAllNamed(AppRoutes.LOGIN_RAPIDO);
      Get.offAllNamed(UserRoutes.LOGIN_RAPIDO);
    } else {
      print('SPLASH: CARGAR LOGIN');
      Get.offAllNamed(UserRoutes.LOGIN);
    }
  }

  verificarPlataformaIos() {
    if (UtilidadesUtil.plataformaIsIos) {
      AppConfig.plataformIsIos = true;
    }
  }

  msjActualizarApp(bool actualizarApp) async {
    if (actualizarApp) {
      DialogosAwesome.getWarning(
        title: "ACTUALIZAR LA APP",
        descripcion: MensajesString.msjNuevaVersionApp,
        btnOkOnPress: () async {
          String url = AppConfig.linkAppIos;
          if (GetPlatform.isAndroid) {
            url = AppConfig.linkAppAndroid;
          }

          await UtilidadesUtil.abrirUrl(url);

          exit(0);
        },
      );
    } else {
      await vericarIdAppPublic();
    }
  }

  vericarIdAppPublic() async {
    verificarPlataformaIos();
    String pageAppsSelect = await _localStoreImpl.getAppPagePublic();
    print("AppConfig.plataformIsIos= ${AppConfig.plataformIsIos}");
    print("pageAppsSelect= ${pageAppsSelect}");
    //Verificar si es IOS

    if (AppConfig.plataformIsIos) {
      if (pageAppsSelect == PageAppsSelect.Bienvenida.toString()) {
        print("unooo");
        Get.offAllNamed(AppRoutes.BIENVENIDO);
      } else if (pageAppsSelect == PageAppsSelect.Public.toString()) {
        print("dosss");
        Get.offAllNamed(AppRoutes.HOME_APP_PUBLIC);
      } else {
        print("tress");
        _verifiToken();
      }
    } else {
      print("cuatroo");
      _verifiToken();
    }
  }
}

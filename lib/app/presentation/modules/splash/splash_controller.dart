part of '../controllers.dart';

class SplashController extends GetxController {



  final AuthApiImpl _authApiImpl = Get.find<AuthApiImpl>();
  final LocalStoreImpl _localStoreImpl = Get.find<LocalStoreImpl>();


  String tag = "SplashController";
  final LoginController _loginController = Get.find<LoginController>();

  RxBool peticionServerState = false.obs;

  @override
  void onInit() {
    // TODO: el contolloler se ha creado pero la vista no se ha renderizado
  //  _init();
    super.onInit();
  }

  @override
  void onReady() async {
    // TODO: Donde la vista ya se presento
    await _verificarVersionApp();
  }

  _init() async {
    print(Get.deviceLocale.toString());
    _verifiToken();
  }





  _verifiToken() async {
    print("SPLASH: verificando token");

    DataUser dataUser=await _localStoreImpl.getUserModel();
    final token = dataUser.token;

    print("token : {el token} = ${token}");

    //verificamos si el token aun esta valido
    if (token != null) {
      print("SPLASH: tenemos token valido");
      //Tenemos token aun valido que no expira
      //vamos al login

      //se realiza el login
      String user = await _localStoreImpl.getUser();
      String pass = await _localStoreImpl.getPass();

      //  bool resul = await _localStoreImpl.login(user: user, pass: pass);

      bool resul=false;
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
    await Future.delayed(const Duration(seconds: 2)).then((_) {});

    bool confHuella = await _localStoreImpl.getConfigHuella();
    String codePin = await _localStoreImpl.getPinCode();
    if (confHuella || codePin.length > 2) {
      print('SPLASH: CARGAR INICIO RAPIDO');
      // Get.offAllNamed(AppRoutes.LOGIN_RAPIDO);
      Get.offAllNamed(SiipneRoutes.LOGIN_RAPIDO);
    } else {
      print('SPLASH: CARGAR LOGIN');
      Get.offAllNamed(SiipneRoutes.LOGIN);
    }
  }






    verificarPlataformaIos() {
      //AppConfig.plataformIsIos = true;
      if (UtilidadesUtil.plataformaIsIos) {
        AppConfig.plataformIsIos = true;
      }
    }

    Future<void> _verificarVersionApp() async {

      try {

        bool isAndroid = GetPlatform.isAndroid;
        int versionCodeApp = 0;

        versionCodeApp = int.parse(await DeviceInfo.getVersionCode);
        PrintsMsj.myLog(tag: tag, title: "verificarVersionApp", detalle: "iniciarConsulta");
        peticionServerState(true);



        msjActualizarApp(false);
        PrintsMsj.myLog(tag: tag, title: "verificarVersionApp", detalle: "terminaconsulta");

        peticionServerState(false);
      } on ServerException catch (e) {
        PrintsMsj.myLog(tag: tag, title: "ServerException", detalle: e.cause);

        peticionServerState(false);
        await vericarIdAppPublic();
      }
      catch (e) {
        PrintsMsj.myLog(tag: tag, title: "ServerException", detalle: e.toString());
        peticionServerState(false);
        await vericarIdAppPublic();
      }

    }



    msjActualizarApp(bool actualizarApp) async {
      if (actualizarApp) {
        DialogosAwesome.getWarning(
            title: "ACTUALIZAR LA APP",
            descripcion: MensajesString.msjNuevaVersionApp,
            btnOkOnPress: () async {
              String url = SiipneConfig.linkAppIos;
              if (GetPlatform.isAndroid) {
                url = SiipneConfig.linkAppAndroid;
              }

              await UtilidadesUtil.abrirUrl(url);

              exit(0);
            });
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

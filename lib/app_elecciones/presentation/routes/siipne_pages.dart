import 'package:get/get.dart';
import '../../../app/presentation/routes/app_pages.dart';


import '../modules/bindings.dart';
import '../modules/pages.dart';
import '../routes/siipne_routes.dart';

class SiipnePages {
  static final List<GetPage> pages = [
    

     AppPages.getPageConfig(
        name: SiipneRoutes.LOGIN,
        page: () => LoginPage(),
        binding: LoginBinding()),
     AppPages.getPageConfig(
        name: SiipneRoutes.LOGIN_RAPIDO,
        page: () => InicioRapidoPage(),
        binding: InicioRapidoBinding()),

    AppPages.getPageConfig(
        name: SiipneRoutes.MENU_APP,
        page: () => MenuAppPage(),
        binding: MenuAppBinding()),

    AppPages.getPageConfig(
        name: SiipneRoutes.MENU_RECINTOS_ELECTORALES,
        page: () => MenuRecintosElectoralesPage(),
        binding: MenuRecintosElectoralesBinding()),


    AppPages.getPageConfig(
        name: SiipneRoutes.MENU_UNIDADES_POLICIALES,
        page: () => MenuUnidadesPolicialesPage(),
        binding: MenuUnidadesPolicialesBinding()),

  ];
}

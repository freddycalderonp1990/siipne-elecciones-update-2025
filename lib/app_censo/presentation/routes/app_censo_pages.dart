import 'package:get/get.dart';
import '../../../app/presentation/routes/app_pages.dart';

import '../modules/bindings.dart';
import '../modules/pages.dart';
import 'app_censo_routes.dart';


class AppCensoPages {
  static final List<GetPage> pages = [


    AppPages.getPageConfig(
        name: AppCensoRoutes.MENU_APP,
        page: () => MenuAppCensoPage(),
        binding: MenuAppCensoBinding()),

    AppPages.getPageConfig(
        name: AppCensoRoutes.HISTORIAL_CENSO,
        page: () => HistorialCensoPage(),
        binding: HistorialCensoBinding()),

    AppPages.getPageConfig(
        name: AppCensoRoutes.CENSO_POLICIAL,
        page: () => CensoPolicialPage(),
        binding: CensoPolicialBinding()),


  ];
}

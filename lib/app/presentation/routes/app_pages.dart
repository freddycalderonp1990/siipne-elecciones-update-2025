import 'package:app_mi_upc/app_mi_upc.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:siipnemovil2/app_censo/presentation/routes/app_censo_pages.dart';

import '../../../app_elecciones/presentation/routes/elecciones_pages.dart';
import '../../../feactures/user/presentation/routes/user_pages.dart';
import '../modules/bindings.dart';
import '../modules/pages.dart';
import 'app_routes.dart';

class AppPages {


  static List<GetPage> _pages = [];

  static GetPage getPageConfig(
      {
        required String name,
      required GetPageBuilder page,
      required Bindings binding,

        Transition transition = Transition.rightToLeft,
        Duration transitionDuration = const Duration(milliseconds: 400),
        Curve curve = Curves.fastOutSlowIn,

      }) {
    return GetPage(
        transition: transition,
        transitionDuration: transitionDuration,
        curve: curve,
        name: name,
        page: page,
        binding: binding);
  }

  static List<GetPage> getPages() {
    _pages = [

      getPageConfig(
          name: AppRoutes.SPLASH_APP,
          page: () => SplashPage(),
          binding: SplashBinding()),

      getPageConfig(
          name: AppRoutes.BIENVENIDO,
          page: () => BienvenidoPage(),
          binding: BienvenidoBinding()),

      AppPages.getPageConfig(
          name: AppRoutes.MENU_APP,
          page: () => MenuAppPage(),
          binding: MenuAppBinding()),

      getPageConfig(
          name: AppRoutes.HOME_APP_PUBLIC,
          page: () => HomePage(),
          binding: HomeBinding()),

      getPageConfig(
          name: AppRoutes.PDFVIEW,
          page: () => PdfViewPage(),
          binding: PdfViewBinding()),

      getPageConfig(
          name: AppRoutes.SHOW_NOTIFICATION,
          page: () => ShowNotificationPage(),
          binding: ShowNotificationBinding()),

    ];

    //agregamos las paguinas de cada app
   _pages.addAll(UserPages.pages);
    _pages.addAll(MiUpc.getPages);
    _pages.addAll(EleccionesPages.pages);
    _pages.addAll(AppCensoPages.pages);
   // _pages.addAll(AppPagesConfigApps.pages);
    return _pages;
  }
}

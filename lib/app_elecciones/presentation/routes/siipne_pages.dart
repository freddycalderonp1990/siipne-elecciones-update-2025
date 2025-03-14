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
        name: SiipneRoutes.SELECT_PROCESO_OPERATIVOS,
        page: () => SelectProcesoOperativoPage(),
        binding: SelectProcesoOperativoBinding()),


    AppPages.getPageConfig(
        name: SiipneRoutes.TIPOS_SERVICIOS_EJES,
        page: () => TiposServiciosEjesPage(),
        binding: TiposServiciosEjesBinding()),

    AppPages.getPageConfig(
        name: SiipneRoutes.RECINTOS_CREAR_CODIGO,
        page: () => RecintosCrearCodigoPage(),
        binding: RecintosCrearCodigoBinding()),

    AppPages.getPageConfig(
        name: SiipneRoutes.MENU_RECINTOS_ELECTORALES,
        page: () => MenuRecintosElectoralesPage(),
        binding: MenuRecintosElectoralesBinding()),


    AppPages.getPageConfig(
        name: SiipneRoutes.MENU_UNIDADES_POLICIALES,
        page: () => MenuUnidadesPolicialesPage(),
        binding: MenuUnidadesPolicialesBinding()),


    AppPages.getPageConfig(
        name: SiipneRoutes.ADD_PERSONAL,
        page: () => AddPersonPage(),
        binding: AddPersonBinding()),

    AppPages.getPageConfig(
        name: SiipneRoutes.REPORT_PERSONAL,
        page: () => ReportPersonPage(),
        binding: ReportPersonBinding()),


    AppPages.getPageConfig(
        name: SiipneRoutes.ADD_NOVEDADES,
        page: () => AddNovedadesPage(),
        binding: AddNovedadesBinding()),

    AppPages.getPageConfig(
        name: SiipneRoutes.REPORT_NOVEDADES,
        page: () => ReportNovedadesPage(),
        binding: ReportNovedadesBinding()),

  ];
}

import 'package:get/get.dart';
import '../../../app/presentation/routes/app_pages.dart';

import '../modules/bindings.dart';
import '../modules/pages.dart';
import '../routes/elecciones_routes.dart';

class EleccionesPages {
  static final List<GetPage> pages = [


    AppPages.getPageConfig(
        name: EleccionesRoutes.MENU_APP,
        page: () => MenuAppEleccionesPage(),
        binding: MenuAppEleccionesBinding()),
    AppPages.getPageConfig(
        name: EleccionesRoutes.SELECT_PROCESO_OPERATIVOS,
        page: () => SelectProcesoOperativoPage(),
        binding: SelectProcesoOperativoBinding()),
    AppPages.getPageConfig(
        name: EleccionesRoutes.TIPOS_SERVICIOS_EJES,
        page: () => TiposServiciosEjesPage(),
        binding: TiposServiciosEjesBinding()),
    AppPages.getPageConfig(
        name: EleccionesRoutes.CREAR_CODIGO_RECINTOS,
        page: () => CrearCodigoRecintosPage(),
        binding: CrearCodigoRecintosBinding()),
    AppPages.getPageConfig(
        name: EleccionesRoutes.CREAR_CODIGO_UNIDADES_POLI,
        page: () => CrearCodigoUnidadPoliPage(),
        binding: CrearCodigoUnidadPoliBinding()),
    AppPages.getPageConfig(
        name: EleccionesRoutes.MENU_RECINTOS_ELECTORALES_JEFE,
        page: () => MenuRecElecJefePage(),
        binding: MenuRecElecJefeBinding()),
    AppPages.getPageConfig(
        name: EleccionesRoutes.MENU_RECINTOS_ELECTORALES_INTEGRANTE,
        page: () => MenuRecElecIntegrantePage(),
        binding: MenuRecElecIntegranteBinding()),
    AppPages.getPageConfig(
        name: EleccionesRoutes.ANEXARSE,
        page: () => AnexarsePage(),
        binding: AnexarseBinding()),
    AppPages.getPageConfig(
        name: EleccionesRoutes.ADD_PERSONAL,
        page: () => AddPersonPage(),
        binding: AddPersonBinding()),
    AppPages.getPageConfig(
        name: EleccionesRoutes.REPORT_PERSONAL,
        page: () => ReportPersonPage(),
        binding: ReportPersonBinding()),
    AppPages.getPageConfig(
        name: EleccionesRoutes.ADD_NOVEDADES,
        page: () => AddNovedadesPage(),
        binding: AddNovedadesBinding()),
    AppPages.getPageConfig(
        name: EleccionesRoutes.REPORT_NOVEDADES,
        page: () => ReportNovedadesPage(),
        binding: ReportNovedadesBinding()),

    AppPages.getPageConfig(
        name: EleccionesRoutes.VALIDAR_RECINTO,
        page: () => ValidateRecintoPage(),
        binding: ValidateRecintoBinding()),
  ];
}

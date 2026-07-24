part of '../pages.dart';

class MenuAppEleccionesPage extends GetView<MenuAppEleccionesController> {
  const MenuAppEleccionesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //aqui obtenemos el token
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationsBloc>().requestPermission(
        appName: NamApps.Elecciones,
        idGenUsuario: controller.user.idGenUsuario,
      );
    });
    return WorkAreaPageWidget(
      showBtnNotificacione: true,
      showGps: true,
      mostrarBtnAtras: true,
      title: "MENÚ ELECCIONES",
      contenido: getContenido(),
      peticionServer: controller.peticionServerState,
    );
  }

  Widget getContenido() {
    final responsive = ResponsiveUtil();

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DesingFotoNameWidget(
            img: controller.user.foto,
            sexo: controller.user.sexo,
            nombres: controller.user.nombres,
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: responsive.altoP(2)),
                _getMenu(responsive),

                SizedBox(height: responsive.altoP(4)),
                BtnIconWidget(
                  icon: Icons.exit_to_app,
                  titulo: "SALIR",
                  onPressed: () => controller.cerrarSession(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getMenu(ResponsiveUtil responsive) {
    Widget btnCrearAndAnexarse = Row(
      children: [
        Flexible(
          child: BtnMenuWidget(
            horizontal: true,
            colorFondo: Colors.white,
            img: SiipneEleccionesImages.icon_abrir_rec_elec,
            title: SiipneStrings.CREARCODIGO,
            onTap: () =>
                Get.toNamed(EleccionesRoutes.SELECT_PROCESO_OPERATIVOS),
          ),
        ),
        SizedBox(width: responsive.anchoP(2)),
        Flexible(
          child: BtnMenuWidget(
            horizontal: true,
            colorFondo: Colors.white,
            img: SiipneEleccionesImages.icon_anexarse_rec_elec,
            title: SiipneStrings.ANEXARSE,
            onTap: () => Get.toNamed(EleccionesRoutes.ANEXARSE),
          ),
        ),
      ],
    );

    return Column(
      children: [
        Obx(
          () => controller.selectProcesosOperativo.value.permitirCrearCodigos
              ? btnCrearAndAnexarse
              : Container(),
        ),

        Obx(
          () => controller.selectProcesosOperativo.value.validarRecinto
              ? Column(
                  children: [
                    SizedBox(height: 10),
                    BtnMenuWidget(
                      horizontal: true,
                      colorFondo: Colors.white,
                      img: SiipneEleccionesImages.ic_validar_recinto,
                      title: SiipneStrings.VALIDAR_RECINTO,
                      onTap: () => Get.toNamed(
                        EleccionesRoutes.VALIDAR_RECINTO,
                        arguments: {
                          "selectProcesosOperativo":
                              controller.selectProcesosOperativo.value,
                        },
                      ),
                    ),
                  ],
                )
              : Container(),
        ),
      ],
    );
  }
}

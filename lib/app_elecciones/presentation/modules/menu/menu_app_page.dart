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
    Widget btn1 = Row(
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
            img: SiipneEleccionesImages.icon_registrarse_rec_elect,
            title: SiipneStrings.ANEXARSE,
            onTap: () => Get.toNamed(EleccionesRoutes.ANEXARSE),
          ),
        ),
      ],
    );

    return btn1;
  }
}

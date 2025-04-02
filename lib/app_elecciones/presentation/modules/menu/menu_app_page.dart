part of '../pages.dart';

class MenuAppPage extends GetView<MenuAppController> {
  const MenuAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(
      title: "MENÚ PRINCIPAL",
      contenido:  getContenido(),

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
          SizedBox(height: responsive.altoP(2)),
          imgPerfilRedonda(size: 27, img: controller.user.foto),
          SizedBox(height: responsive.altoP(2)),
          DesingTextNameUser(
            sexo: controller.user.sexo,
            text: controller.user.nombres,
          ),
          SizedBox(height: responsive.altoP(2)),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: responsive.altoP(2)),
                _getMenu(responsive),
              ],
            ),
          ),

          SizedBox(height: responsive.altoP(3)),
          BtnIconWidget(
            icon: Icons.exit_to_app,
            titulo: "SALIR",
            onPressed: () => controller.cerrarSession(),
          ),
        ],
      ),
    );
  }

  _getMenu(ResponsiveUtil responsive) {
    double separacionBtnMenu = 1.5;

    return Row(
      children: [
        Flexible(
          child: BtnMenuWidget(
            horizontal: true,
            colorFondo: Colors.white,
            img: SiipneImages.icon_abrir_rec_elec,
            title: SiipneStrings.CREARCODIGO,
            onTap: () => Get.toNamed(SiipneRoutes.SELECT_PROCESO_OPERATIVOS),
          ),
        ),
        SizedBox(width: responsive.anchoP(2)),
        Flexible(
          child: BtnMenuWidget(
            horizontal: true,
            colorFondo: Colors.white,
            img: SiipneImages.icon_registrarse_rec_elect,
            title: SiipneStrings.ANEXARSE,
            onTap: () => Get.toNamed(SiipneRoutes.ANEXARSE),
          ),
        ),
      ],
    );
  }
}

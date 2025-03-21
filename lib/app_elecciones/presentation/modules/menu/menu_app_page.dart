part of '../pages.dart';

class MenuAppPage extends GetView<MenuAppController> {
  const MenuAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(
      title: "MENÚ PRINCIPAL",
      contenido: Container(child: Center(child: getContenido())),
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
          imgPerfilRedonda(
            size: 25,
            img: controller.user.foto,
          ),

          DesingTextNameUser(
              sexo:controller.user.sexo ,
              text:  controller.user.nombres),
          Container(
            padding: EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: responsive.altoP(2),
                ),
                _getMenu(responsive),
              ],
            ),
          ),
         BtnIconWidget(
              icon: Icons.exit_to_app,
              titulo: "SALIR",
              onPressed: () => controller.cerrarSession(),
            ),

          SizedBox(
            height: responsive.altoP(3.5),
          ),
        ],
      ),
    );
  }

  _getMenu(ResponsiveUtil responsive) {
    double separacionBtnMenu = 1.5;
    return Column(
      children: [
        BtnMenuWidget(
            horizontal: false,
            colorFondo: Colors.white,
            img: SiipneImages.icon_abrir_rec_elec,
            title: SiipneStrings.CREARCODIGO,
            onTap: () => Get.toNamed(SiipneRoutes.SELECT_PROCESO_OPERATIVOS)),
        SizedBox(
          height: responsive.altoP(separacionBtnMenu),
        ),
        BtnMenuWidget(
            horizontal: false,
            colorFondo: Colors.white,
            img: SiipneImages.icon_registrarse_rec_elect,
            title: SiipneStrings.ANEXARSE,
            onTap: () => Get.toNamed(SiipneRoutes.ANEXARSE)),
        SizedBox(
          height: responsive.altoP(separacionBtnMenu),
        ),
      ],
    );
  }
}



part of '../pages.dart';

class MenuAppPage extends GetView<MenuAppController> {
  const MenuAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(
      title: "MENÚ PRINCIPAL",
      contenido: _getContenidoConRefresh(),

      peticionServer: controller.peticionServerState,
    );
  }


  Widget _getContenidoConRefresh() {
    final responsive = ResponsiveUtil();

    return RefreshIndicator(
      onRefresh: () async {
        await controller.getDatosMenuApp();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(), // Importante para que funcione aunque no haya scroll
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
            _getMenu(responsive),
            SizedBox(height: responsive.altoP(3)),
            BtnIconWidget(
              icon: Icons.exit_to_app,
              titulo: "SALIR",
              onPressed: () => controller.cerrarSession(),
            ),
          ],
        ),
      ),
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
              children: <Widget>[SizedBox(height: responsive.altoP(2))],
            ),
          ),
          _getMenu(responsive),
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
    return Column(
      children: [
        Obx(

          () =>
              controller.dataMenuApp.value.siipneElecciones
                  ? BtnMenuWidget(
                    horizontal: true,
                    img: SiipneEleccionesImages.ic_elecciones,
                    title: "ELECCIONES",
                    onTap: () => controller.verificarNovedadesUdgaPolicialRegistradas(),
                  )
                  : const SizedBox.shrink(),
        ),

        SizedBox(height: responsive.altoP(2)),
        Obx(
          () =>
              controller.dataMenuApp.value.siipneCenso
                  ? BtnMenuWidget(
                    horizontal: true,
                    img: AppCensoImages.ic_censo,
                    title: "CENSO POLICIAL",
                    onTap: () {
                      Get.toNamed(AppCensoRoutes.MENU_APP);
                    },
                  )
                  : const SizedBox.shrink(),
        ),

        SizedBox(height: responsive.altoP(2)),

        SizedBox(height: responsive.altoP(separacionBtnMenu)),
      ],
    );
  }
}

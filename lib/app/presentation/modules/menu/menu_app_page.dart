part of '../pages.dart';

class MenuAppPage extends GetView<MenuAppController> {
  const MenuAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(
      title: "MENÚ PRINCIPAL ",
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
        physics:
            const AlwaysScrollableScrollPhysics(), // Importante para que funcione aunque no haya scroll
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DesingFotoNameWidget(
              img: controller.user.foto,
              sexo: controller.user.sexo,
              nombres: controller.user.nombres,
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
      ),
    );
  }

  _getMenu(ResponsiveUtil responsive) {
    double separacionBtnMenu = 1.5;
    return Column(
      children: [
        Obx(
          () =>
              controller.showMenuElecciones.value
                  ? BtnMenuWidget(
                    horizontal: true,
                    img: SiipneEleccionesImages.ic_elecciones,
                    title: "ELECCIONES",
                    onTap:
                        () {
                          Get.toNamed(EleccionesRoutes.MENU_APP);
                        }


                  )
                  : const SizedBox.shrink(),
        ),

        SizedBox(height: responsive.altoP(2)),
        Obx(
          () =>

              controller.showMenuCenso.value
                  ? BtnMenuWidget(
                    horizontal: true,
                    img: AppCensoImages.ic_censo,
                    title: "CENSO POLICIAL",

                onTap:
                    () =>
                    controller
                        .verificarNovedadesUdgaPolicialRegistradas(),
                  )
                  : const SizedBox.shrink(),
        ),

        SizedBox(height: responsive.altoP(2)),

        SizedBox(height: responsive.altoP(separacionBtnMenu)),
      ],
    );
  }
}

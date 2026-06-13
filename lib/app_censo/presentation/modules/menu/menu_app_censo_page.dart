part of '../pages.dart';

class MenuAppCensoPage extends GetView<MenuAppCensoController> {
  const MenuAppCensoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //aqui obtenemos el token
    context.read<NotificationsBloc>().requestPermission("app_censo");

    return WorkAreaPageCensoWidget(
      showGps: true,
      mostrarBtnAtras: true,
      title: "MENÚ CENSO",
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getMenu(ResponsiveUtil responsive) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            children: [
              Obx(
                () =>
                    controller.showBtnIniciarCenso.value
                        ? Expanded(
                          child: BtnMenuWidget(
                            horizontal: true,
                            colorFondo: Colors.white,
                            img: AppCensoImages.ic_iniciar_censo,
                            title: "INICIAR CENSO",
                            onTap: () {
                              if (controller.isCensista.value) {
                                DialogosDesingWidget.getDialogoX(
                                  title: "Iniciar Censo",
                                  contenido: _getOpcionesParaCensista(
                                    responsive,
                                  ),
                                );
                              } else {
                                controller.goToPageIniciarCenso();
                              }
                            },
                          ),
                        )
                        : SizedBox.shrink(),
              ),
              Obx(
                () =>
                    controller.showBtnIniciarCenso.value
                        ? SizedBox(width: responsive.anchoP(2))
                        : SizedBox.shrink(),
              ),
              Expanded(
                child: BtnMenuWidget(
                  horizontal: true,
                  colorFondo: Colors.white,
                  img: AppCensoImages.ic_historial_censo,
                  title: "HISTORIAL CENSOS",
                  onTap: () => Get.toNamed(AppCensoRoutes.HISTORIAL_CENSO),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _getOpcionesParaCensista(ResponsiveUtil responsive) {
    return Container(
      child: Column(
        children: [
          TextSombrasWidget(
            title: "Seleccione cómo desea participar en el censo",
          ),

          BtnMenuWidget(
            horizontal: true,
            colorFondo: Colors.white,
            img: AppCensoImages.ic_censista,
            title: "Quiero censar",
            onTap: () {
              Get.back();
              controller.validarMesasCenso(controller.dataMesasList);
            },
          ),

          SizedBox(height: 8),


          controller.showBtnQuieroSerCensado.value
              ? BtnMenuWidget(
                horizontal: true,
                colorFondo: Colors.white,
                img: AppCensoImages.ic_censo,
                title: "Quiero ser censado",
                onTap: () {
                  Get.back();
                  controller.goToPageIniciarCenso();
                },
              )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}

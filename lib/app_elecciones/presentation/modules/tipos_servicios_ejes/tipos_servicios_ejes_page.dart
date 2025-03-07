part of '../pages.dart';

class TiposServiciosEjesPage extends GetView<TiposServiciosEjesController> {
  const TiposServiciosEjesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(
      title:
          "OPERATIVO: \n ${controller.selectProcesoOperativoController.selectProcesosOperativo.value.descProcElecc}",
      mostrarBtnAtras: true,
      contenido: getContenido(),
      peticionServer: controller.peticionServerState,
    );
  }

  Widget getContenido() {
    String Bienvenido =
    controller.user.sexo == 'HOMBRE' ? "BIENVENIDO: " : "BIENVENIDA: ";
    final responsive = ResponsiveUtil();
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: responsive.altoP(2),
          ),
          DesingTextNameUser(data:  Bienvenido + controller.user.nombres),
          SizedBox(
            height: responsive.altoP(2),
          ),

          TextSombrasWidget(
            title: "Seleccione el servicio al que fue designado. ",
            size: responsive.diagonalP(AppConfig.tamTexto),
            colorSombra: Colors.white,
            colorTexto: Colors.black,
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: responsive.altoP(2),
                ),
                _getMenu(responsive)
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getMenu(ResponsiveUtil responsive) {
    double separacionBtnMenu = 1.5;
    return Obx(() => Column(
          children: [
            controller.tipoEjesActivos.value.tipoEjeRecintos
                ? BtnMenuWidget(
                    horizontal: false,
                    colorFondo: Colors.white,
                    img: SiipneImages.icon_abrir_rec_elec,
                    title: 'SERVICIO EN RECINTOS',
                    onTap: () {
                      Get.toNamed(SiipneRoutes.RECINTOS_CREAR_CODIGO);
                    })
                : Container(),
            SizedBox(
              height: responsive.altoP(separacionBtnMenu),
            ),
            controller.tipoEjesActivos.value.tipoEjeUnidadesPoliciales
                ? BtnMenuWidget(
                    horizontal: false,
                    img: SiipneImages.icon_agregar_personal,
                    title: SiipneStrings.UNIDADESPOLICIALES,
                    onTap: () {},
                  )
                : Container(),
            SizedBox(
              height: responsive.altoP(separacionBtnMenu),
            ),
            controller.tipoEjesActivos.value.tipoEjeOtros
                ? BtnMenuWidget(
                    img: SiipneImages.icon_registrar_novedades_rec_elec,
                    title: 'OTROS',
                    onTap: () {},
                  )
                : Container(),
            SizedBox(
              height: responsive.altoP(separacionBtnMenu),
            ),
          ],
        ));
  }
}

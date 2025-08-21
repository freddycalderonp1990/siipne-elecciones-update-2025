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

    final responsive = ResponsiveUtil();
    return SingleChildScrollView(
      child: Column(
        children: [
          DesingFotoNameWidget(
            img: controller.user.foto,
            sexo: controller.user.sexo,
            nombres: controller.user.nombres,
          ),

          TextLineasWidget(
            grosorLinea: 1.5,
            title: "Seleccione el servicio al que fue designado. ",
            sizeTxt: responsive.diagonalP(AppConfig.tamTexto),

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
    Widget wg= Obx(() => Row(
          children: [
            controller.tipoEjesActivos.value.tipoEjeRecintos
                ? Flexible(child: BtnMenuWidget(
                horizontal: true,
                colorFondo: Colors.white,
                img: SiipneEleccionesImages.icon_abrir_rec_elec,
                title: 'SERVICIO EN RECINTOS',
                onTap: () {
                  Get.toNamed(EleccionesRoutes.CREAR_CODIGO_RECINTOS);
                }))
                : Container(),
            SizedBox(
              width: responsive.anchoP(2),
            ),
            controller.tipoEjesActivos.value.tipoEjeUnidadesPoliciales
                ? Flexible(child: BtnMenuWidget(
              horizontal: true,
              img: SiipneEleccionesImages.icon_agregar_personal,
              title: SiipneStrings.UNIDADESPOLICIALES,
              onTap: () {

                Get.toNamed(EleccionesRoutes.CREAR_CODIGO_UNIDADES_POLI);

              },
            ))
                : Container(),


          ],
        ));


    return Obx(() => Column(
      children: [

        wg,


        controller.tipoEjesActivos.value.tipoEjeOtros
            ? BtnMenuWidget(
          img: SiipneEleccionesImages.icon_registrar_novedades_rec_elec,
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

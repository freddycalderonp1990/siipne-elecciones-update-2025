part of '../../pages.dart';

class RecintosCrearCodigoPage extends GetView<RecintosCrearCodigoController> {
  const RecintosCrearCodigoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(
      title: SiipneStrings.recElecAbrir,
      mostrarBtnAtras: true,
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
          SizedBox(
            height: 20,
          ),
          TextSombrasWidget(
            colorTexto: Colors.white,
            colorSombra: Colors.black,
            title:
                "OPERATIVO: \n ${controller.selectProcesoOperativoController.procesosOperativo.descProcElecc}",
            size: responsive.diagonalP(AppConfig.tamTextoTitulo - 0.5),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: responsive.altoP(0.5),
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
    double separacionBtnMenu = 5;
    return Column(
      children: [
        Obx(
          () => controller.cargaInicial == false
              ? MyUbicacionWidget(
                  callback: (_) {
                    print("ingresoo jajajaja");

                    controller.getDatos();
                  },
                )
              : Container(),
        ),
        getComboRecintosElectorales(),
        SizedBox(
          height: responsive.altoP(0.4),
        ),
        getComboSubsistema(),
        SizedBox(
          height: responsive.altoP(0.4),
        ),
        getComboDireccionesPoliciales(),
        SizedBox(
          height: responsive.altoP(0.4),
        ),
        getComboEjesUnidadesPoliciales(),

        controller.tipoEjesActivos.value.tipoEjeUnidadesPoliciales
            ? BtnMenuWidget(
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
    );
  }



  Widget getComboRecintosElectorales() {

    return ContenedorDesingWidget(
        paddin: EdgeInsets.all(5),
        child: Obx(()=>ComboBusqueda(
          icon: Icons.select_all_sharp,

          showClearButton: false,
          datos: controller.listRecintosElectorales.value,
          displayField: (item) =>
          item.nomRecintoElec, // Aquí decides mostrar "nombres"
          searchHint: "Recinto Electoral",
          complete: (value) {
            controller.selectRecintosElectoral.value = value;
          },
          textSeleccioneUndato: "Seleccione un Recinto",
        )));
  }

  Widget getComboSubsistema() {
    return Obx(() => controller.selectRecintosElectoral.value.idDgoReciElect > 0
        ? ContenedorDesingWidget(
            paddin: EdgeInsets.all(5),
            child: ComboBusqueda(
              icon: Icons.select_all_sharp,
              showClearButton: false,
              datos: controller.listSubsistema,
              displayField: (item) =>
                  item.descripcion, // Aquí decides mostrar "nombres"
              searchHint: "Subsistema",
              complete: (value) {
                controller.selectSubsistema.value = value;

                controller.getEjesDireccionesPoliciales(value.idDgoTipoEje);
              },
              textSeleccioneUndato: "Seleccione un Subsistema",
            ))
        : Container());
  }

  Widget getComboDireccionesPoliciales() {
    return Obx(() => controller.selectSubsistema.value.idDgoTipoEje > 0
        ? ContenedorDesingWidget(

        paddin: EdgeInsets.all(5),
        child: ComboBusqueda(

          icon: Icons.select_all_sharp,


          showClearButton: false,
          datos: controller.listDirecciones,
          displayField: (item) =>
          item.descripcion, // Aquí decides mostrar "nombres"
          searchHint: "Dirección",

          complete: (value) {
            controller.selectDireccion.value = value;
          },
          textSeleccioneUndato: "Seleccione una Dirección",
        ))
        : Container());
  }

  Widget getComboEjesUnidadesPoliciales() {
    return Obx(() => controller.selectDireccion.value.idDgoTipoEje > 0
        ? ContenedorDesingWidget(
        paddin: EdgeInsets.all(5),
        child: ComboBusqueda(
          icon: Icons.select_all_sharp,
          showClearButton: false,
          datos: controller.listUnidadesPoliciales,
          displayField: (item) =>
          item.descripcion, // Aquí decides mostrar "nombres"
          searchHint: "Unidad Policial",
          complete: (value) {
            controller.selectUnidadePolicial.value = value;
          },
          textSeleccioneUndato: "Seleccione una Unidad",
        ))
        : Container());
  }
}

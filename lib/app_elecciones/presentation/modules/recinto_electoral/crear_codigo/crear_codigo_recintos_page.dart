part of '../../pages.dart';

class CrearCodigoRecintosPage extends GetView<CrearCodigoRecintosController> {
  const CrearCodigoRecintosPage({Key? key}) : super(key: key);

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
          SizedBox(height: 20),
          TextSombrasWidget(
            colorTexto: Colors.white,
            colorSombra: Colors.black,
            title:
                "OPERATIVO: \n ${controller.selectProcesoOperativoController.selectProcesosOperativo.value.descProcElecc}",
            size: responsive.diagonalP(AppConfig.tamTextoTitulo - 0.5),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: responsive.altoP(0.5)),
                _getMenu(responsive),
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
          () =>
              controller.cargaInicial == false
                  ? MyUbicacionWidget(
                    callback: (_) {
                      controller.getDatos();
                    },
                  )
                  : Container(),
        ),
        getComboRecintosElectorales(),
        SizedBox(height: responsive.altoP(0.4)),

        getDesingCombosPolicial(),

        SizedBox(height: responsive.altoP(1)),
        wgTxtTelefono(responsive),
        SizedBox(height: responsive.altoP(0.4)),
        btnCrear(),
        SizedBox(height: responsive.altoP(separacionBtnMenu)),
      ],
    );
  }

  Widget getComboRecintosElectorales() {
    return ContenedorDesingWidget(
      paddin: EdgeInsets.all(5),
      child: Obx(
        () => ComboBusqueda(
          selectValue: controller.selectRecintosElectoral.value,

          showClearButton: false,
          datos: controller.listRecintosElectorales.value,
          displayField:
              (item) => item.nomRecintoElec, // Aquí decides mostrar "nombres"
          searchHint: "Recinto Electoral",
          complete: (value) {
            controller.selectRecintosElectoral.value = RecintosElectoral();

            if (value != null) {
              controller.selectRecintosElectoral.value = value;
            }
          },
          textSeleccioneUndato: "Seleccione un Recinto",
        ),
      ),
    );
  }

  Widget getDesingCombosPolicial() {
    final responsive = ResponsiveUtil();
    return Obx(
      () =>
          controller.selectRecintosElectoral.value.idDgoTipoEje > 0
              ? ContenedorDesingWidget(
                paddin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    getComboSubsistema(),
                    SizedBox(height: responsive.altoP(0.4)),
                    getComboDireccionesPoliciales(),
                    SizedBox(height: responsive.altoP(0.4)),
                    getComboEjesUnidadesPoliciales(),
                  ],
                ),
              )
              : Container(),
    );
  }

  Widget getComboSubsistema() {
    return ComboBusqueda(
      selectValue: controller.comboDependienteController.selectSubsistema.value,

      showClearButton: false,
      datos: controller.comboDependienteController.listSubsistema,
      displayField:
          (item) => item.descripcion, // Aquí decides mostrar "nombres"
      searchHint: "Subsistema",
      complete: (value) {
        controller.comboDependienteController.selectSubsistema.value =
            UnidadesPoliciale.empty();
        controller.comboDependienteController.selectDireccionPoliciales.value =
            UnidadesPoliciale.empty();
        controller.comboDependienteController.selectUnidadPolicial.value =
            UnidadesPoliciale.empty();

        if (value != null) {
          controller.comboDependienteController.selectSubsistema.value = value;

          controller.getEjesDireccionesPoliciales(value.idDgoTipoEje);
          return;
        }
      },
      textSeleccioneUndato: "Seleccione un Subsistema",
    );
  }

  Widget getComboDireccionesPoliciales() {
    return Obx(
      () =>
          controller
                      .comboDependienteController
                      .selectSubsistema
                      .value
                      .idDgoTipoEje >
                  0
              ? ComboBusqueda(
                selectValue:
                    controller
                        .comboDependienteController
                        .selectDireccionPoliciales
                        .value,

                showClearButton: false,
                datos:
                    controller
                        .comboDependienteController
                        .listDireccionesPoliciales,
                displayField:
                    (item) =>
                        item.descripcion, // Aquí decides mostrar "nombres"
                searchHint: "Dirección",
                complete: (value) {
                  controller
                      .comboDependienteController
                      .selectDireccionPoliciales
                      .value = UnidadesPoliciale.empty();
                  controller
                      .comboDependienteController
                      .selectUnidadPolicial
                      .value = UnidadesPoliciale.empty();
                  if (value != null) {
                    controller.getEjesUnidadesPoliciales(value.idDgoTipoEje);
                    controller
                        .comboDependienteController
                        .selectDireccionPoliciales
                        .value = value;
                    return;
                  }
                },
                textSeleccioneUndato: "Seleccione una Dirección",
              )
              : Container(),
    );
  }

  Widget getComboEjesUnidadesPoliciales() {
    return Obx(
      () =>
          controller
                      .comboDependienteController
                      .selectDireccionPoliciales
                      .value
                      .idDgoTipoEje >
                  0
              ? ComboBusqueda(
                selectValue:
                    controller
                        .comboDependienteController
                        .selectUnidadPolicial
                        .value,

                showClearButton: false,
                datos:
                    controller
                        .comboDependienteController
                        .listUnidadesPoliciales,
                displayField:
                    (item) =>
                        item.descripcion, // Aquí decides mostrar "nombres"
                searchHint: "Unidad Policial",
                complete: (value) {
                  controller
                      .comboDependienteController
                      .selectUnidadPolicial
                      .value = UnidadesPoliciale.empty();
                  if (value != null) {
                    controller
                        .comboDependienteController
                        .selectUnidadPolicial
                        .value = value;
                    return;
                  }
                },
                textSeleccioneUndato: "Seleccione una Unidad",
              )
              : Container(),
    );
  }

  Widget wgTxtTelefono(ResponsiveUtil responsive) {
    Widget wg = ContenedorDesingWidget(
      child: WgTxtTelefono(
        controllerTelefono: controller.controllerTelefono,

        formKey: controller.formKey,
      ),
    );
    return Obx(
      () =>
          controller
                      .comboDependienteController
                      .selectUnidadPolicial
                      .value
                      .idDgoTipoEje >
                  0
              ? wg
              : Container(),
    );
  }

  Widget btnCrear() {
    return Obx(
      () =>
          controller
                      .comboDependienteController
                      .selectUnidadPolicial
                      .value
                      .idDgoTipoEje >
                  0
              ? controller.selectRecintosElectoral.value.idDgoTipoEje > 0
                  ? BtnIconWidget(
                    icon: Icons.open_in_browser_outlined,
                    titulo: "CREAR CÓDIGO",
                    onPressed:
                        () => controller.msjCrearCodigo(
                          onPressed: () {
                            Get.back();
                            controller.crearCodigo();
                          },
                        ),
                  )
                  : Container()
              : Container(),
    );
  }
}

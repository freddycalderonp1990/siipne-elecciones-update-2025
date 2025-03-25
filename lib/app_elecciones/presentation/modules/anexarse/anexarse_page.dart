part of '../pages.dart';

class AnexarsePage extends GetView<AnexarseController> {
  const AnexarsePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(
      showGps: true,
      mostrarBtnAtras: true,
      title: "ANEXARSE",
      contenido: getContenido(),
      peticionServer: controller.peticionServerState,
    );
  }

  Widget getContenido() {
    final responsive = ResponsiveUtil();
    String Bienvenido =
        controller.user.sexo == 'HOMBRE' ? "BIENVENIDO: " : "BIENVENIDA: ";

    return SingleChildScrollView(child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 10),
        wgConsultarRecinto(),
        SizedBox(height: 10),
        wgDatosRecinto(),
      ],
    ),);
  }

  Widget wgDatosRecinto() {
    final responsive = ResponsiveUtil();

    Widget wg = Column(
      children: [
        Obx(
          () =>
              controller.datosEncargado.value.idDgoReciElect > 0
                  ? ContenedorDesingWidget(
                    child: ExpansionTile(
                      collapsedIconColor: AppColors.colorAzul,
                      iconColor: AppColors.colorAzul,
                      initiallyExpanded: true,
                      title: Text(
                        'DATOS DEL OPERATIVO',
                        style: TextStyle(
                          color: AppColors.colorAzul,
                          fontSize: responsive.diagonalP(AppConfig.tamTexto),
                        ),
                      ),
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              SizedBox(height: responsive.altoP(1)),
                              TituloDetalleTextWidget(
                                title: "Instalación",
                                detalle:
                                    controller
                                        .datosEncargado
                                        .value
                                        .nomRecintoElec,
                              ),
                              TituloDetalleTextWidget(
                                title: "Encargado",
                                detalle:
                                    controller.datosEncargado.value.encargado,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                  : Container(),
        ),

        Obx(
          () =>
              controller.datosEncargado.value.idDgoTipoEje == 1
                  ? getDesingCombosPolicial()
                  : getComboInstalacionesUnidadesPoliciales(),
        ),
        SizedBox(height: 10),
        btnRegistrar(),
      ],
    );

    return Obx(
      () =>
          controller.datosEncargado.value.idDgoReciElect > 0 ? wg : Container(),
    );
  }

  Widget wgConsultarRecinto() {
    final responsive = ResponsiveUtil();
    return ContenedorDesingWidget(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        // handle your onTap here
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          margin: EdgeInsets.only(left: 0.0, right: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: responsive.altoP(1)),
              Expanded(
                child: Form(
                  key: controller.formKey,
                  child: ImputTextWidget(
                    keyboardType: TextInputType.number,
                    controller: controller.controllerCodigoRecinto,
                    icono: Icon(
                      Icons.assignment_sharp,
                      color: SiipneColors.colorIcons,
                      size: responsive.diagonalP(AppConfig.tamIcons),
                    ),
                    label: SiipneStrings.codigo,
                    fonSize: responsive.diagonalP(AppConfig.tamTextoTitulo),
                    validar: validateCodigoRecinto,
                  ),
                ),
              ),
              SizedBox(width: responsive.altoP(1)),
              BtnIconWidget(
                onPressed: () => controller.consultarDatosSegunCodigo(),
                icon: Icons.search,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? validateCodigoRecinto(String? value) {
    if (value != null && value.length > 0) {
      int? codigoRecinto = int.tryParse(value);

      if (codigoRecinto == null) {
        print("El valor ingresado no es un número entero válido.");
        return SiipneStrings.codigoOperativoNoValido;
      }

      return null;
    }
    return SiipneStrings.codigoOperativoNoValido;
  }

  Widget getComboInstalacionesUnidadesPoliciales() {
    return ContenedorDesingWidget(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              TituloTextWidget(
                title:
                    "Seleccione la Unidad a la que pertenece el Servidor Policial ",
                textAlign: TextAlign.center,
              ),
              getComboEjesUnidadesPolicialesOnly(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getComboEjesUnidadesPolicialesOnly() {
    return ContenedorDesingWidget(
      paddin: EdgeInsets.all(5),

      child: ComboBusqueda(
        selectValue: controller.selectUnidadPolicial.value,
        icon: Icons.select_all_sharp,
        showClearButton: false,
        datos: controller.listUnidadesPoliciales,
        displayField: (item) => item.ejePadre, // Aquí decides mostrar "nombres"
        searchHint: "Unidad Policial",
        complete: (value) {
          controller.selectUnidadPolicial.value = DatosUnidadesId.empty();
          controller.select_save_IdDgoTipoEje.value=0;

          if (value != null) {
            controller.selectUnidadPolicial.value = value;
            controller.select_save_IdDgoTipoEje.value=value.idDgoTipoEje;
            return;
          }
        },
        textSeleccioneUndato: "Seleccione una Unidad",
      ),
    );
  }

  Widget btnRegistrar() {
    return Obx(
      () =>
          controller.select_save_IdDgoTipoEje.value > 0

              ? BtnIconWidget(
                icon: Icons.open_in_browser_outlined,
                titulo: "REGISTRAR",
                onPressed: () => controller.registrarse(),
              )
              : Container(),
    );
  }

  Widget getDesingCombosPolicial() {
    final responsive = ResponsiveUtil();
    return Obx(
      () =>
          controller.datosEncargado.value.idDgoTipoEje > 0
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
      icon: Icons.select_all_sharp,
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
                icon: Icons.select_all_sharp,
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
                icon: Icons.select_all_sharp,
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
                  controller.select_save_IdDgoTipoEje.value=0;
                  if (value != null) {
                    controller
                        .comboDependienteController
                        .selectUnidadPolicial
                        .value = value;

                    controller.select_save_IdDgoTipoEje.value=value.idDgoTipoEje;
                    return;
                  }
                },
                textSeleccioneUndato: "Seleccione una Unidad",
              )
              : Container(),
    );
  }
}

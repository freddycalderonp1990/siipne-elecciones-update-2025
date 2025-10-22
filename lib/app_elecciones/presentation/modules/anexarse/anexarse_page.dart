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

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          wgConsultarRecinto(),
          SizedBox(height: 10),

          wgDatosRecinto(),
        ],
      ),
    );
  }

  Widget wgDatosRecinto() {
    final responsive = ResponsiveUtil();

    Widget wg = Column(
      children: [
        Obx(
          () =>
              controller.datosEncargado.value.idDgoReciElect > 0
                  ? ContenedorDesingWidget(
                    child: Theme(
                      data: Theme.of(Get.context!).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        collapsedIconColor: AppColors.colorAzul,
                        iconColor: AppColors.colorAzul,
                        initiallyExpanded: true,
                        tilePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        childrenPadding: const EdgeInsets.only(bottom: 10),
                        title: Text(
                          'DATOS DEL OPERATIVO',
                          style: TextStyle(
                            color: AppColors.colorAzul,
                            fontSize: responsive.diagonalP(AppConfig.tamTexto),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: responsive.altoP(1)),
                                TituloDetalleTextWidget(
                                  title: "Instalación",
                                  detalle: controller.datosEncargado.value.nomRecintoElec,
                                ),
                                TituloDetalleTextWidget(
                                  title: "Encargado",
                                  detalle: controller.datosEncargado.value.encargado,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                ,
                  )
                  : Container(),
        ),
        SizedBox(height: 10),

                   getComboInstalacionesUnidadesPoliciales(),

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
                      color: AppColors.colorIcons,
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
    final responsive = ResponsiveUtil();
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
              getCombosDinamicos(responsive),
            ],
          ),
        ),
      ),
    );
  }

  Widget btnRegistrar() {
    return Obx(
      () =>
          controller.dynamicComboUnidadesPoliciales.showBtnGuardar == true
              ? BtnIconWidget(
                icon: Icons.open_in_browser_outlined,
                titulo: "REGISTRAR",
                onPressed: () => controller.registrarse(),
              )
              : Container(),
    );
  }

  Widget getCombosDinamicos(ResponsiveUtil responsive) {
    return DynamicComboWidget(
      controller: controller.dynamicComboUnidadesPoliciales,
      responsive: responsive,
    );
  }


}

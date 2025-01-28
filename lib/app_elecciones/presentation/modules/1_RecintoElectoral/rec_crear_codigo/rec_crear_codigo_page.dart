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
                "OPERATIVO: \n ${controller.selectProcesoOperativoController.selectProcesosOperativo.value.descProcElecc}",
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
        SizedBox(
          height: responsive.altoP(1),
        ),
        wgTxtTelefono(responsive),
        SizedBox(
          height: responsive.altoP(0.4),
        ),
        btnCrear(),
        SizedBox(
          height: responsive.altoP(separacionBtnMenu),
        ),
      ],
    );
  }

  Widget getComboRecintosElectorales() {
    return ContenedorDesingWidget(
        paddin: EdgeInsets.all(5),
        child: Obx(() => ComboBusqueda(
              selectValue: controller.selectRecintosElectoral.value,

              icon: Icons.select_all_sharp,

              showClearButton: false,
              datos: controller.listRecintosElectorales.value,
              displayField: (item) =>
                  item.nomRecintoElec, // Aquí decides mostrar "nombres"
              searchHint: "Recinto Electoral",
              complete: (value) {
                controller.selectRecintosElectoral.value = RecintosElectoral();

                if (value != null) {
                  controller.selectRecintosElectoral.value = value;
                }
              },
              textSeleccioneUndato: "Seleccione un Recinto",
            )));
  }

  Widget getComboSubsistema() {
    print("aaaaa ${controller.selectRecintosElectoral.value.idDgoTipoEje}");
    return Obx(() => controller.selectRecintosElectoral.value.idDgoTipoEje > 0
        ? ContenedorDesingWidget(
            paddin: EdgeInsets.all(5),
            child: ComboBusqueda(
              selectValue: controller.selectSubsistema.value,
              icon: Icons.select_all_sharp,
              showClearButton: false,
              datos: controller.listSubsistema,
              displayField: (item) =>
                  item.descripcion, // Aquí decides mostrar "nombres"
              searchHint: "Subsistema",
              complete: (value) {
                controller.selectSubsistema.value = UnidadesPoliciale.empty();
                controller.selectDireccionPoliciales.value =
                    UnidadesPoliciale.empty();
                controller.selectUnidadPolicial.value =
                    UnidadesPoliciale.empty();

                if (value != null) {
                  controller.selectSubsistema.value = value;

                  controller.getEjesDireccionesPoliciales(value.idDgoTipoEje);
                  return;
                }
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
              selectValue: controller.selectDireccionPoliciales.value,
              icon: Icons.select_all_sharp,
              showClearButton: false,
              datos: controller.listDireccionesPoliciales,
              displayField: (item) =>
                  item.descripcion, // Aquí decides mostrar "nombres"
              searchHint: "Dirección",
              complete: (value) {
                controller.selectDireccionPoliciales.value =
                    UnidadesPoliciale.empty();
                controller.selectUnidadPolicial.value =
                    UnidadesPoliciale.empty();
                if (value != null) {
                  controller.getEjesUnidadesPoliciales(value.idDgoTipoEje);
                  controller.selectDireccionPoliciales.value = value;
                  return;
                }
              },
              textSeleccioneUndato: "Seleccione una Dirección",
            ))
        : Container());
  }

  Widget getComboEjesUnidadesPoliciales() {
    return Obx(() => controller.selectDireccionPoliciales.value.idDgoTipoEje > 0
        ? ContenedorDesingWidget(
            paddin: EdgeInsets.all(5),
            child: ComboBusqueda(
              selectValue: controller.selectUnidadPolicial.value,
              icon: Icons.select_all_sharp,
              showClearButton: false,
              datos: controller.listUnidadesPoliciales,
              displayField: (item) =>
                  item.descripcion, // Aquí decides mostrar "nombres"
              searchHint: "Unidad Policial",
              complete: (value) {
                controller.selectUnidadPolicial.value =
                    UnidadesPoliciale.empty();

                if (value != null) {
                  controller.selectUnidadPolicial.value = value;
                  return;
                }
              },
              textSeleccioneUndato: "Seleccione una Unidad",
            ))
        : Container());
  }

  Widget wgTxtTelefono(ResponsiveUtil responsive) {
    Widget wg = ContenedorDesingWidget(
        child: Form(
      key: controller.formKey,
      child: Column(
        children: [
          ImputTextWidget(
            keyboardType: TextInputType.number,
            controller: controller.controllerTelefono,
            icono: Icon(
              Icons.phone_android,
              color: Colors.black38,
            ),
            label: "Teléfono",
            fonSize: responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar: validateTelefono,
          )
        ],
      ),
    ));
    return Obx(() => controller.selectUnidadPolicial.value.idDgoTipoEje > 0
        ? wg
        : Container());
  }

  String? validateTelefono(String? value) {
    if (value == null || value.length < 8) {
      return "Ingrese el número de Teléfono";
    }
    return null;
  }

  Widget btnCrear() {

    return Obx(() => controller.selectUnidadPolicial.value.idDgoTipoEje > 0
        ? controller.selectRecintosElectoral.value.idDgoTipoEje>0? BtnIconWidget(
            icon: Icons.open_in_browser_outlined,
            titulo: "CREAR CÓDIGO",
            onPressed:()=>  controller.msjCrearCodigo(onPressed: ()=>controller.crearCodigo())
            ,
          ):Container()
        : Container());
  }


}

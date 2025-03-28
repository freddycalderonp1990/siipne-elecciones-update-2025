part of '../../pages.dart';

class CrearCodigoUnidadPoliPage
    extends GetView<CrearCodigoUnidadPoliController> {
  const CrearCodigoUnidadPoliPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(
      title: "CREAR CÓDIGO",
      mostrarBtnAtras: true,
      onPressBtnAtras: (){

        if(controller.continuar.value){
          controller.continuar.value=false;
        }
        else{
          Get.back();
        }
      },
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

  _getDesingSelectDireccionContinuar(ResponsiveUtil responsive) {
    return Column(
      children: [
        getComboSubsistema(),
        SizedBox(
          height: responsive.altoP(0.4),
        ),
        getComboDireccionesPoliciales(),

        SizedBox(
          height: responsive.altoP(3),
        ),
        btnContinuar(),
      ],
    );
  }

  _getDesingSelectUnidadVolver(ResponsiveUtil responsive) {
    return Column(
      children: [
        getComboRecintosElectorales(),

        SizedBox(
          height: responsive.altoP(0.4),
        ),
        wgTxtTelefono(responsive),
        SizedBox(
          height: responsive.altoP(3),
        ),
        btnCrear(),
      ],
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
                    controller.getSubsistemas();
                  },
                )
              : Container(),
        ),
        Obx(() => !controller.continuar.value
            ? _getDesingSelectDireccionContinuar(responsive)
            : _getDesingSelectUnidadVolver(responsive)),
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
    return ContenedorDesingWidget(
        paddin: EdgeInsets.all(5),
        child: Obx(() => ComboBusqueda(
              selectValue: controller.selectSubsistema.value,
              
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
            )));
  }

  Widget getComboDireccionesPoliciales() {
    return Obx(() => controller.selectSubsistema.value.idDgoTipoEje > 0
        ? ContenedorDesingWidget(
            paddin: EdgeInsets.all(5),
            child: ComboBusqueda(
              selectValue: controller.selectDireccionPoliciales.value,
              
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

  Widget wgTxtTelefono(ResponsiveUtil responsive) {
    Widget wg = ContenedorDesingWidget(
        child: WgTxtTelefono(

          controllerTelefono: controller.controllerTelefono,

          formKey: controller.formKey,
        ));
    return Obx(() => controller.selectRecintosElectoral.value .idDgoTipoEje > 0
        ? wg
        : Container());
  }



  Widget btnContinuar() {
    return Obx(() => controller.selectDireccionPoliciales.value.idDgoTipoEje > 0
        ? BtnIconWidget(
            icon: Icons.open_in_browser_outlined,
            titulo: "CONTINUAR",
            onPressed: ()  async{
               int idDgoTipoEje=controller.selectDireccionPoliciales.value.idDgoTipoEje;
               await controller.getRecintosElectorales(idDgoTipoEje);

            },
          )
        : Container());
  }


  Widget btnVolver() {
    return  BtnIconWidget(
      icon: Icons.open_in_browser_outlined,
      titulo: "VOLVER",
      onPressed: () {
        controller.continuar.value = false;
      },
    );
  }

  Widget btnCrear() {
    return Obx(() =>  controller.selectRecintosElectoral.value.idDgoTipoEje > 0
            ? BtnIconWidget(
                icon: Icons.open_in_browser_outlined,
                titulo: "CREAR CÓDIGO",
                onPressed: () => controller.msjCrearCodigo(onPressed: () {

                  controller.crearCodigo();
                }),
              )
            : Container()
        );
  }
}

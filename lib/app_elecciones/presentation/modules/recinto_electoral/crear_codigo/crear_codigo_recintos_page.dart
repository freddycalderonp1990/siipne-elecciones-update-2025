part of '../../pages.dart';

class CrearCodigoRecintosPage extends GetView<CrearCodigoRecintosController> {
  const CrearCodigoRecintosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();
    return WorkAreaPageWidget(
      title: "ABRIR RECINTO ELECTORAL",
      mostrarBtnAtras: true,
      peticionServer: controller.peticionServerState,
      contenido: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            TextSombrasWidget(
              colorTexto: Colors.white,
              colorSombra: Colors.black,
              title:
                  "OPERATIVO: \n${controller.selectProcesoOperativoController.selectProcesosOperativo.value.descProcElecc}",
              size: responsive.diagonalP(AppConfig.tamTextoTitulo - 0.5),
            ),
            SizedBox(height: 10),
            ContenedorDesingWidget(
              paddin: EdgeInsets.all(5),
              child: getComboRecintosElectorales(),
            ),
            SizedBox(height: 10),
            ContenedorDesingWidget(
              paddin: EdgeInsets.all(5),
              child: getCombosDinamicos(responsive),
            ),
            SizedBox(height: 10),
            wgTelefono(),
            SizedBox(height: 10),
            btnCrear(),
          ],
        ),
      ),
    );
  }

  Widget getComboRecintosElectorales() {
    return Obx(
      () => ComboBusqueda(
        selectValue: controller.selectRecintosElectoral.value,
        showClearButton: false,
        icon: Icons.home_work_rounded,

        datos: controller.listRecintosElectorales.value,
        displayField: (item) =>item.validado?  item.nomRecintoElec+ " (VALIDADO)":item.nomRecintoElec,
        searchHint: "Recinto Electoral",
        textSeleccioneUndato: "Seleccione un Recinto",
        complete: (value) {
          print("value ${value}");

          controller.selectRecintosElectoral.value =
              value ?? RecintosElectoral();
        },
      ),
    );
  }

  Widget getCombosDinamicos(ResponsiveUtil responsive) {
    return DynamicComboWidget(
      controller: controller.dynamicComboUnidadesPoliciales,
      responsive: responsive,
    );
  }

  Widget wgTelefono() {
    return Obx(
      () => AnimatedSwitcher(
        duration: Duration(milliseconds: 30),
        child:
            controller.dynamicComboUnidadesPoliciales.showBtnGuardar.value
                ? ContenedorDesingWidget(
                  child: WgTxtTelefono(
                    controllerTelefono: controller.controllerTelefono,
                    formKey: controller.formKey,
                  ),
                )
                : Container(),
      ),
    );
  }

  Widget btnCrear() {
    return Obx(
      () => AnimatedSwitcher(
        duration: Duration(milliseconds: 30),
        child:
            controller.dynamicComboUnidadesPoliciales.showBtnGuardar.value &&
                    controller.selectRecintosElectoral.value.idDgoReciElect > 0
                ? BtnIconWidget(
                  icon: Icons.open_in_browser_outlined,
                  titulo: "CREAR CÓDIGO",
              onPressed: () {


                controller.msjCrearCodigo(onPressed: () {

                  controller.crearCodigo();
                })

                ;},
                )
                : Container(),
      ),
    );
  }
}

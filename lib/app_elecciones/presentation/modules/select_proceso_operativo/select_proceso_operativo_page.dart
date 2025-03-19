part of '../pages.dart';

class SelectProcesoOperativoPage
    extends GetView<SelectProcesoOperativoController> {
  const SelectProcesoOperativoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(
      title:"OPERATIVOS" ,
      mostrarBtnAtras: true,
      showGps: true,
      contenido:  getContenido(),
      peticionServer: controller.peticionServerState,
    );
  }

  Widget getContenido() {
    final responsive = ResponsiveUtil();




    return SingleChildScrollView(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Obx(
          () => controller.cargaInicial == false
              ? MyUbicacionWidget(
                  callback: (_) {
                    print("ingresoo jajajaja");

                    controller.getProcesoOperativos();
                  },
                )
              : Container(),
        ),

        imgPerfilRedonda(
          size: 28,
          img:       controller.user.foto,
        ),
        SizedBox(
          height: 10,
        ),
        DesingTextNameUser(
            sexo:controller.user.sexo ,
            text:  controller.user.nombres),
        Container(
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: responsive.altoP(2),
              ),
              SizedBox(
                height: responsive.altoP(1),
              ),
              ContenedorDesingWidget(
                paddin: EdgeInsets.all(5),
                child: getComboProcesosRecintos(),
              ),
              SizedBox(
                height: responsive.altoP(1),
              ),
              Obx(() => controller.selectProcesosOperativo.value.idDgoProcElec > 0
                  ? BtnIconWidget(


                      icon: Icons.exit_to_app,
                      titulo: "CONTINUAR",
                      onPressed: () => controller.goToPageTipoServicio(),
                    )
                  : Container()),
              SizedBox(
                height: responsive.altoP(4),
              ),
            ],
          ),
        ),
      ],
    ));
  }

  Widget getComboProcesosRecintos() {
    return Obx(()=>ComboBusqueda(

      icon: Icons.select_all_sharp,
selectValue:  controller.selectProcesosOperativo.value,
      showClearButton: false,
      datos: controller.listProcesosOperativo.value,
      displayField: (item) =>
      item.descProcElecc, // Aquí decides mostrar "nombres"
      searchHint: "Proceso",
      complete: (value) {
        if(value!=null) {
          controller.selectProcesosOperativo.value = value;
        }
        else{
          controller.selectProcesosOperativo.value = ProcesosOperativo.empty();
        }
      },
      textSeleccioneUndato: "Seleccione un Proceso",
    ));
  }
}

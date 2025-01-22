part of '../pages.dart';

class SelectProcesoOperativoPage
    extends GetView<SelectProcesoOperativoController> {
  const SelectProcesoOperativoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(
      mostrarBtnAtras: true,
      contenido: GpsAccessScreen(contenido: getContenido()),
      peticionServer: controller.peticionServerState,
    );
  }

  Widget getContenido() {
    final responsive = ResponsiveUtil();

    String Bienvenido =
        controller.user.sexo == 'HOMBRE' ? "BIENVENIDO: " : "BIENVENIDA: ";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(
          () => controller.cargaInicial == false
              ? MyUbicacionWidget(
                  callback: (_) {
                    print("ingresoo");
                    controller.getProcesoOperativos();
                  },
                )
              : Container(),
        ),
        TextSombrasWidget(
          colorTexto: Colors.white,
          colorSombra: Colors.black,
          title: "OPERATIVOS",
          size: responsive.diagonalP(AppConfig.tamTextoTitulo),
        ),
        SizedBox(
          height: 10,
        ),
        TextSombrasWidget(
          title: Bienvenido + controller.user.nombres,
        ),
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
              BtnIconWidget(
                colorBtn: AppColors.colorBotones,
                colorIcon: Colors.white,
                colorTxt: Colors.white,
                icon: Icons.exit_to_app,
                titulo: "CONTINUAR",
                onPressed: () {},
              ),
              SizedBox(
                height: responsive.altoP(4),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getComboProcesosRecintos() {



    return ComboBusqueda(
      showClearButton: false,
      datos: controller.listProcesosOperativo,
      displayField: (item) => item.descProcElecc, // Aquí decides mostrar "nombres"
      searchHint: "Proceso",
      complete: (value) {
        //controller.getIdCliente(value);
        print(value.descProcElecc);
      },
      textSeleccioneUndato: "Seleccione un Proceso",
    );
  }
}

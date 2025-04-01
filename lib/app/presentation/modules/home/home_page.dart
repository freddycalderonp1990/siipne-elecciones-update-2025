part of '../pages.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (_) => WorkAreaPageWidget(

          mostrarBtnHome: true,
              onPressedBtnHome: () {
                controller.setAppPageSelect(PageAppsSelect.Bienvenida);
              },
              contenido: getContenido(),
              peticionServer: false.obs,
            ));
  }

  Widget getContenido() {
    final responsive = ResponsiveUtil();

    return Column(

      children: [
      Expanded(child: SizedBox()),
    ContenedorDesingWidget(
    anchoPorce: 100,
    margin: EdgeInsets.all(5),
    child: DetalleTextWidget(
    textAlign: TextAlign.justify,
    todoElAncho: true,
    padding: EdgeInsets.all(20),
    detalle:"La aplicación  te permitirá acceder a información "
          "sobre las alertas comunitarias, "
          "con un acceso rápido al botón de emergencia. "
          "Además, podrás conocer "
          "importantes consejos y recursos sobre violencia de género,"
          " así como los servicios disponibles de la Policía Comunitaria. "
          "También incluye tips sobre medidas de autoprotección para tu seguridad "
          "y bienestar, brindándote herramientas y conocimientos esenciales.")),
      SizedBox(height: 10,),
      BtnIconWidget(
        titulo: "INGRESAR",
        icon: Icons.app_blocking,
          onPressed: (){

            Get.offNamed(AppRoutesMiUpc.SPLASH);

      }),
        Expanded(child: SizedBox()),
    ],);
  }


}

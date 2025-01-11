part of '../pages.dart';

class MenuAppPage extends GetView<MenuAppController> {
  const MenuAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(
      mostrarAnuncio: true,
      contenido: getContenido(),
      peticionServer: controller.peticionServerState,
    );
  }

  Widget getContenido() {
    final responsive = ResponsiveUtil();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: responsive.altoP(5),
        ),

      ],
    );
  }
}

part of '../pages.dart';

class HistorialCensoPage extends GetView<HistorialCensoController> {
  const HistorialCensoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageCensoWidget(
      mostrarBtnAtras: true,
      title: "HISTORIAL CENSO",
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
        DesingFotoNameWidget(
          img: controller.user.foto,
          sexo: controller.user.sexo,
          nombres: controller.user.nombres,
        ),

        Expanded(
          child: Obx(
            () => DesingHistoryCensos(
              listHistoryCenso: controller.listHistoryCenso.value,
            ),
          ),
        ),
      ],
    );
  }
}

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
        SizedBox(height: responsive.altoP(2)),
        imgPerfilRedonda(size: 27, img: controller.user.foto),
        SizedBox(height: responsive.altoP(2)),
        DesingTextNameUser(
          sexo: controller.user.sexo,
          text: controller.user.nombres,
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

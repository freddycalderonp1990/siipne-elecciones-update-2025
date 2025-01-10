part of '../pages.dart';

class BienvenidoPage extends GetView<BienvenidoController> {
  const BienvenidoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BienvenidoController>(
        builder: (_) => WorkAreaPageWidget(
              contenido: getContenido(),
              peticionServer: false.obs,
            ));
  }

  Widget getContenido() {
    final responsive = ResponsiveUtil();
    return SingleChildScrollView(child: Column(
      children: [
        SizedBox(
          height: responsive.altoP(3),
        ),
        ContenedorDesingWidget(
          anchoPorce: 90,
          margin: EdgeInsets.all(5),
          child: DetalleTextWidget(
            textAlign: TextAlign.justify,
            todoElAncho: true,
            padding: EdgeInsets.all(20),
            detalle:
            "Nuestro compromiso es el trabajo profesional de hombres y mujeres policías, mediante "
                "la prestación de un servicio efectivo y el respeto de los derechos humanos, que se evidencia"
                " en la confianza, transparencia, credibilidad y legitimidad ante la ciudadanía; a través, del "
                "control y prevención del delito, mediante el Componente de la Gestión Preventiva, servicio a "
                "la comunidad, investigación de la infracción, inteligencia anti delincuencial, gestión operativa,"
                " control y evaluación.",
          ),
        ),
        ContenedorDesingWidget(
          anchoPorce: 90,
          margin: EdgeInsets.all(1),
          child: Container(
            padding: EdgeInsets.all(10),
            child: TituloTextWidget(
              textAlign: TextAlign.center,
              title: '¿Es usted un Servidor Policial?',
            ),
          ),
        ),
        SizedBox(
          height: responsive.altoP(3),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: BtnIconWidget(
                colorBtn: AppColors.colorBotones,
                colorIcon: Colors.white,
                colorTxt: Colors.white,
                onPressed: () {
                  controller.setAppSiipne(PageAppsSelect.PoliKey);
                },
                icon: Icons.check_circle,
                titulo: "SI",
              ),
            ),
            SizedBox(width: 5),
            Expanded(
                child: BtnIconWidget(
                  colorBtn: AppColors.colorBotones,
                  colorIcon: Colors.white,
                  colorTxt: Colors.white,
                  onPressed: () {
                    controller.setAppSiipne(PageAppsSelect.Public);
                  },
                  icon: Icons.cancel,
                  titulo: "NO",
                )),
          ],
        )
      ],
    ),);
  }
}

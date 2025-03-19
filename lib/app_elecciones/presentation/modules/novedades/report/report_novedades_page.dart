part of '../../pages.dart';

class ReportNovedadesPage extends GetView<ReportNovedadesController> {
  const ReportNovedadesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(
      mostrarBtnAtras: true,
      title: "REPORTE DE NOVEDADES",
      showGps: true,
      contenido:  getContenido(),
      peticionServer: controller.peticionServerState,
    );
  }
  Widget getContenido() {
    return ContenedorDesingWidget(
      paddin: EdgeInsets.all(10),
      child: Column(
        children: [
          // ✅ Títulos FIJOS (no se desplazan)
          Container(
            padding: EdgeInsets.all(5),
            child: TituloTextWidget(
              textAlign: TextAlign.center,
              title: controller.recintosElectoralesAbiertos.nomRecintoElec,
            ),
          ),
          Obx(
                () => TituloTextWidget(
              title: "TOTAL: ${controller.listNovedadesElectorales.value.length} de Novedades",
              colorTitulo: AppColors.colorAzul,
            ),
          ),

          Flexible(
            child: ListView(
              shrinkWrap: true, // ✅ Permite que se ajuste sin problemas
              children: [
                _novedades(),
              ],
            ),
          ),
        ],
      ),
    );
  }



  Widget _novedades() {
    return Obx(() {
      final list = controller.listNovedadesElectorales.value ?? [];

      print("Novedades: ${list.length}"); // Para depuración

      return getDesingExpandible(
        title: "Novedades ${list.length}",
        children: list.isEmpty
            ? [Text("No hay novedades disponibles")]
            : [
          ListView.builder(
            reverse: true, // Invierte el orden
            shrinkWrap: true, // 🔹 Evita que el ListView tome más espacio del necesario
            physics: NeverScrollableScrollPhysics(), // 🔹 Evita conflictos de scroll
            itemCount: list.length,
            itemBuilder: (BuildContext context, int i) {
              return DisingNovedades(
                onTap: () {},
                data: list[i],
                index: i,
              );
            },
          ),
        ],
      );
    });
  }

  Widget getDesingExpandible({
    required String title,
    required List<Widget> children,
  }) {
    final ResponsiveUtil responsive = ResponsiveUtil();

    return ExpansionTile(
      collapsedIconColor: AppColors.colorAzul,
      iconColor: AppColors.colorAzul,
      initiallyExpanded: true,
      title: Text(
        title,
        style: TextStyle(
          color: AppColors.colorAzul,
          fontSize: responsive.diagonalP(AppConfig.tamTextoTitulo),
        ),
      ),
      children: children,
    );
  }

}

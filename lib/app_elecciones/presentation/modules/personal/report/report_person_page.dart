part of '../../pages.dart';

class ReportPersonPage extends GetView<ReportPersonController> {
  const ReportPersonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(
      mostrarBtnAtras: true,
      title: "REPORTE DEL PERSONAL",
      showGps: true,
      contenido: getContenido(),
      peticionServer: controller.peticionServerState,
    );
  }

  Widget getContenido() {
    final responsive = ResponsiveUtil();


    return ContenedorDesingWidget(
        paddin: EdgeInsets.all(10),

        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              padding: EdgeInsets.all(5),
              child: TituloTextWidget(
                textAlign: TextAlign.center,
                title: controller.recintosElectoralesAbiertos.nomRecintoElec,
              ),
            ),
        Obx(()=>    TituloTextWidget(
          title: "TOTAL: " +
              (controller.listPersonalActivo.value.length + 1).toString() +
              " de Personal",
          colorTitulo: AppColors.colorAzul,

        ),),
            Obx(() => _wgJefe(controller.encargado.value)),
            _PersonalActivo(),
          ],
        ));
  }

  Widget _wgJefe(PersonalRecintoElectoral data) {
    final ResponsiveUtil responsive = ResponsiveUtil();

    return getDesingExpandible(title: "Encargado 1", children: [
      Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            TituloDetalleTextWidget(
              title: "Fecha Inicio",
              detalle: controller.encargado.value.fechaIni,
            ),
            TituloDetalleTextWidget(
              title: "Datos:",
              detalle: data.personal,
            ),
          ],
        ),
      )
    ]);
  }

  Widget _PersonalActivo() {
    final ResponsiveUtil responsive = ResponsiveUtil();

    return Obx(() {
      final listPersonal = controller.listPersonalActivo.value;

      return getDesingExpandible(
        title: "Personal Activo ${controller.listPersonalActivo.length}",
        children: [
          ListView.builder(
            reverse: true, // Invierte el orden1206762401
            shrinkWrap: true,
            physics:
            NeverScrollableScrollPhysics(), // Evita conflictos de scroll dentro de otro scroll
            itemCount: controller.listPersonalActivo.length,
            itemBuilder: (BuildContext context, int i) {
              PersonalRecintoElectoral data = listPersonal[i];
              return DisingPersonal(
                onTap: () {
                  DialogosAwesome.getWarningSiNo(descripcion: "¿Está seguro que desea inactivar a \n"
                      "${data.personal} del operarivo?",
                      btnCancelOnPress: (){},

                      btnOkOnPress: (){
                        controller.remomePersonalOperativo(data);
                      });

                },
                nombrePersonal: data.personal,
                index: i + 1,
              );
            },
          ),
        ],
      );
    });
  }

  Widget getDesingExpandible(
      {required String title, required List<Widget> children}) {
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

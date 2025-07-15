part of '../pages.dart';

class HistorialCensoPage extends GetView<HistorialCensoController> {
  const HistorialCensoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(
      mostrarBtnAtras: true,
      title: "HISTORIAL CENSO",
      contenido:  getContenido(),
      peticionServer: controller.peticionServerState,
    );
  }

  Widget getContenido() {
    final responsive = ResponsiveUtil();

    return SingleChildScrollView(
      child: Column(
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
          SizedBox(height: responsive.altoP(2                                                     )),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: responsive.altoP(2)),
                _getMenu(responsive),
              ],
            ),
          ),

          SizedBox(height: responsive.altoP(3)),
          BtnIconWidget(
            icon: Icons.exit_to_app,
            titulo: "SALIR",
            onPressed: () => controller.cerrarSession(),
          ),
        ],
      ),
    );
  }

  _getMenu(ResponsiveUtil responsive) {


    return Row(
      children: [
        Flexible(
          child: BtnMenuWidget(
            
            horizontal: true,
            colorFondo: Colors.white,

            img: SiipneEleccionesImages.icon_abrir_rec_elec,
            title:"INICIAR CENSO",
            onTap: () => Get.toNamed(EleccionesRoutes.SELECT_PROCESO_OPERATIVOS),
          ),
        ),
        SizedBox(width: responsive.anchoP(2)),
        Flexible(
          child: BtnMenuWidget(
            horizontal: true,
            colorFondo: Colors.white,
            img: SiipneEleccionesImages.icon_registrarse_rec_elect,
            title: "HISTORIAL CENSOS",
            onTap: () => Get.toNamed(EleccionesRoutes.ANEXARSE),
          ),
        ),
      ],
    );
  }
}

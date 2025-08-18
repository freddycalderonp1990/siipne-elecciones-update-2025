part of '../pages.dart';

class MenuAppCensoPage extends GetView<MenuAppCensoController> {
  const MenuAppCensoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageCensoWidget(
      mostrarBtnAtras: true,
      title: "MENÚ CENSO",
      contenido: getContenido(),
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
          SizedBox(height: responsive.altoP(2)),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: responsive.altoP(2)),
                _getMenu(responsive),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getMenu(ResponsiveUtil responsive) {
    return Column(
      children: [
        BtnMenuWidget(
          horizontal: true,
          colorFondo: Colors.white,
          img: AppCensoImages.ic_iniciar_censo,
          title: "validar",
          onTap: () => Get.toNamed(AppCensoRoutes.VALIDATE_MESA),
        ),

        Row(
          children: [
            Flexible(
              child: BtnMenuWidget(
                horizontal: true,
                colorFondo: Colors.white,
                img: AppCensoImages.ic_iniciar_censo,
                title: "INICIAR CENSO",
                onTap: () =>controller. goToPageIniciarCenso(),
              ),
            ),
            SizedBox(width: responsive.anchoP(2)),
            Flexible(
              child: BtnMenuWidget(
                horizontal: true,
                colorFondo: Colors.white,
                img: AppCensoImages.ic_historial_censo,
                title: "HISTORIAL CENSOS",
                onTap: () => Get.toNamed(AppCensoRoutes.HISTORIAL_CENSO),
              ),
            ),
          ],
        ),

        SizedBox(height: responsive.altoP(1)),

        Obx(
          () =>
              controller.dataMesasList.length > 0
                  ? Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: responsive.anchoP(15),
                    ),

                    child: BtnMenuWidget(
                      horizontal: true,
                      colorFondo: Colors.white,
                      img: AppCensoImages.ic_iniciar_censo,
                      title: "CENSISTA",
                   onTap: (){
                        controller.validarMesasCenso(controller.dataMesasList);
                   },
                   //  onTap: () => Get.toNamed(AppCensoRoutes.CENSISTA),
                    ),
                  )
                  : SizedBox.shrink(),
        ),


      ],
    );
  }


}

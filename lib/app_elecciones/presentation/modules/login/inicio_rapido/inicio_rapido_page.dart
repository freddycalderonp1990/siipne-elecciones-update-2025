part of '../../pages.dart';

class InicioRapidoPage extends GetView<InicioRapidoController> {
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();
    // TODO: verifique

    Widget wg = Obx(
      () => WorkAreaLoginPageWidget(
        title: "POLICÍA NACIONAL DEL ECUADOR",
        imgPerfil: controller.user.value.foto,
        mostrarVersion: true,
        imgFondo: AppImages.imgFondoDefault,
        peticionServer: controller.peticionServerState,
        sizeTittle: 7,
        contenido: <Widget>[getContenido(responsive)],
      ),
    );

    return GetBuilder<LoginController>(builder: (_c) => wg);
  }

  Widget getContenido(ResponsiveUtil responsive) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(
            () => DesingTextNameUser(
              sizeText: responsive.diagonalP(AppConfig.tamTextoTitulo),
              sexo: controller.user.value.sexo,
              text: controller.user.value.nombres,
            ),
          ),

          SizedBox(height: responsive.altoP(2)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: responsive.anchoP(10)),

            child: Column(
              children: [
                wgHuella(),
                SizedBox(height: responsive.altoP(2)),
                wgOtroUsuario(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget wgHuella() {
    Widget wg = BtnMenuWidget(
      img: AppImages.icon_huella,
      title: "HUELLA",
      horizontal: false,
      onTap: () => controller.loginConBiometrico(),
      colorFondo: AppColors.colorAzul,
      colorTexto: Colors.white,
    );

    return wg;
  }

  Widget wgOtroUsuario() {
    Widget wg = BtnMenuWidget(
      img: AppImages.icon_clave,
      title: "¿NO ERES TÚ?",
      horizontal: false,
      onTap: () => controller.ingresoConOtroUsuario(),
      colorFondo: AppColors.colorAzul,
      colorTexto: Colors.white,
    );

    return wg;
  }
}

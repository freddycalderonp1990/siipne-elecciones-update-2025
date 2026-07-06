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
            padding: EdgeInsets.symmetric(horizontal: responsive.anchoP(15)),

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
      title: "Huella/Face ID",
      horizontal: false,
      onTap: () => controller.loginConBiometrico(),
      colorFondo: AppColors.colorIcons,

      colorTexto: Colors.white,
    );

    return wg;
  }

  Widget wgOtroUsuario() {
    Widget wg = BtnMenuWidget(
      img: AppImages.icon_clave,
      title: "Ingresa con Usuario y Clave",
      horizontal: false,
      onTap: () => controller.ingresoConOtroUsuario(),
      colorFondo: AppColors.colorIcons,
      colorTexto: Colors.white,
    );

    return wg;
  }
}

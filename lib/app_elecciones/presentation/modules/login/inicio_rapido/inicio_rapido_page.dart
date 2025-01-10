part of '../../pages.dart';

class InicioRapidoPage extends GetView<InicioRapidoController> {
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();
    // TODO: verifique


    Widget wg = Obx(() => WorkAreaLoginPageWidget(
      title: '',
      imgPerfil:controller.user.value.foto,
      mostrarVersion: true,
      imgFondo: AppImages.imgFondoDefault,
      peticionServer: controller.peticionServerState,
      sizeTittle: 7,
      contenido: <Widget>[getContenido(responsive)],
    ));

    return GetBuilder<LoginController>(
      builder: (_c) => wg,
    );
  }

  Widget getContenido(ResponsiveUtil responsive) {
    return Column(
      children: [
        Obx(()=> Text(
          controller.user.value.nombres,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: responsive.anchoP(5)),
        )),
        SizedBox(
          height: responsive.altoP(2),
        ),
        wgHuella(),

        SizedBox(
          height: responsive.altoP(2),
        ),

        wgOtroUsuario(responsive)
      ],
    );
  }

  Widget wgHuella() {

    Widget wg = DesingBtn(imgLocal: AppImages.icon_huella,

        title: "HUELLA",

        onTap: () => controller.loginConBiometrico());

    return  wg;
  }

  Widget wgOtroUsuario(ResponsiveUtil responsive) {
    Widget wg = DesingBtn(
        title: "¿NO ERES TÚ?",
        imgLocal: AppImages.icon_usuario,
        onTap: () async {
          DialogosAwesome.getWarningSiNo(
              descripcion:
              "Por su seguridad el acceso rápido será desactivado."
                  "\n¿Desea Continuar?",
              btnOkOnPress: (){
                controller.ingresoConOtroUsuario();
              });
        });

    return wg;
  }




}

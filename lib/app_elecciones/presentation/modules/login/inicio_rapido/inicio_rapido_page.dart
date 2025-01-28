part of '../../pages.dart';

class InicioRapidoPage extends GetView<InicioRapidoController> {
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();
    // TODO: verifique


    Widget wg = Obx(() => WorkAreaPageWidget(
      title: '',
      imgPerfil:controller.user.value.foto,
      mostrarVersion: true,
      imgFondo: AppImages.imgFondoDefault,
      peticionServer: controller.peticionServerState,

      contenido:
        Center(child: getContenido(responsive),)

    ));

    return GetBuilder<LoginController>(
      builder: (_c) => wg,
    );
  }

  Widget getContenido(ResponsiveUtil responsive) {
    String Bienvenido =  controller.user.value.sexo == 'HOMBRE'
        ? "BIENVENIDO: "
        : "BIENVENIDA: ";
    return Column(
      children: [
        imgPerfilRedonda(
          size: 28,
          img:       controller.user.value.foto,
        ),
        ContenedorDesingWidget(

          paddin: EdgeInsets.all(5),
          child: TextSombrasWidget(
          size: responsive.diagonalP(AppConfig.tamTextoTitulo),
          title:  Bienvenido + controller.user.value.nombres,),),

        SizedBox(
          height: responsive.altoP(2),
        ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10),

        
        child: Column(

        children: [
          wgHuella(),
          SizedBox(
            height: responsive.altoP(2),
          ),
          wgOtroUsuario()
        ],),)
      ],
    );
  }

  Widget wgHuella() {

    Widget wg = BtnMenuWidget(
      img: AppImages.icon_huella,
      title: "HUELLA",
      horizontal: false,
      onTap: () => controller.loginConBiometrico(),
      colorFondo:AppColors.colorAzulHex,
      colorTexto: Colors.white,
    );




    return  wg;
  }

  Widget wgOtroUsuario() {

    Widget wg = BtnMenuWidget(
      img: AppImages.icon_clave,
      title: "¿NO ERES TÚ?",
      horizontal: false,
      onTap: () => controller.ingresoConOtroUsuario(),
      colorFondo:AppColors.colorAzulHex,
      colorTexto: Colors.white,
    );



    return wg;
  }




}
part of '../pages.dart';

class MenuAppPage extends GetView<MenuAppController> {
  const MenuAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(
      mostrarAnuncio: true,
      contenido: Container(
          child:  getContenido()),
      peticionServer: controller.peticionServerState,
    );
  }





  Widget getContenido() {
    final responsive = ResponsiveUtil();

    String Bienvenido =  controller.user.sexo == 'HOMBRE'
        ? "BIENVENIDO: "
        : "BIENVENIDA: ";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        TextSombrasWidget(
          colorTexto: Colors.white,
          colorSombra: Colors.black,
          title:  "MENÚ PRINCIPAL",size: responsive.diagonalP(AppConfig.tamTextoTitulo),),
        SizedBox(height: 10,),
        TextSombrasWidget(title:  Bienvenido + controller.user.nombres,),
        Container(
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              SizedBox(
                height: responsive.altoP(2),
              ),
              _getMenu(responsive)
            ],
          ),
        ),
        Container(
          width: responsive.anchoP(30),
          child: BtnIconWidget(

            icon: Icons.exit_to_app,
            titulo: "SALIR",

            onPressed: () => controller.cerrarSession(),
          ),
        ),
        SizedBox(
          height: responsive.altoP(3.5),
        ),

      ],
    );
  }


  _getMenu(ResponsiveUtil responsive) {
    double separacionBtnMenu = 1.5;
    return Column(
      children: [
        BtnMenuWidget(

          horizontal: false,
            colorFondo: Colors.white,
            img: SiipneImages.icon_abrir_rec_elec,
            title: SiipneStrings.CREARCODIGO,
            onTap: () {
              Get.toNamed(SiipneRoutes.SELECT_PROCESO_OPERATIVOS);


            }),
        SizedBox(
          height: responsive.altoP(separacionBtnMenu),
        ),
        BtnMenuWidget(
            horizontal: false,
            colorFondo: Colors.white,
            img: SiipneImages.icon_registrarse_rec_elect,
            title: SiipneStrings.ANEXARSE,
            onTap: () {
             /* Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          VerificarGpsPage(pantalla: AnexarsePage())));*/
            }),
        SizedBox(
          height: responsive.altoP(separacionBtnMenu),
        ),

      ],
    );
  }



}

part of '../pages.dart';

class MenuRecintosElectoralesPage extends GetView<MenuRecintosElectoralesController> {
  const MenuRecintosElectoralesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(



      contenido: getContenido(),
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
          title:  "RECINTOS ELECTORALES",size: responsive.diagonalP(AppConfig.tamTextoTitulo),),


      ],
    );
  }






}

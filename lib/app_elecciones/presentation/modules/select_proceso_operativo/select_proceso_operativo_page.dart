part of '../pages.dart';

class SelectProcesoOperativoPage extends GetView<SelectProcesoOperativoController> {
  const SelectProcesoOperativoPage({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(
      mostrarBtnAtras: true,

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
          title:  "OPERATIVOS",size: responsive.diagonalP(AppConfig.tamTextoTitulo),),
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
             /* MyUbicacionWidget(
                callback: (_) {
                  _getProcesosOperativos();
                },
              ),*/
              SizedBox(
                height: responsive.altoP(1),
              ),
              getComboProcesosRecintos(),
              SizedBox(
                height: responsive.altoP(1),
              ),


              BtnIconWidget(
                colorBtn: AppColors.colorBotones,
                colorIcon: Colors.white,
                colorTxt: Colors.white,

                icon: Icons.exit_to_app,
                titulo: "CONTINUAR",

                onPressed: () => controller.cerrarSession(),
              ),
              SizedBox(
                height: responsive.altoP(4),
              ),
            ],
          ),
        ),


      ],
    );
  }


  Widget getComboProcesosRecintos() {
   double paddingContenido = 10.0;

   return  ComboBusqueda(

     showClearButton: false,
     datos: ["uno","dos"],
     searchHint: "Clientes",
     complete: (value) {
       //controller.getIdCliente(value);
       print(value);
     },
     textSeleccioneUndato: "Seleccione un Proceso",

   );


  }




}

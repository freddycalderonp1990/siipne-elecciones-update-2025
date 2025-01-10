part of 'custom_app_widgets.dart';



class TituloTextWidget extends StatelessWidget {

  final String title;

  final  Color colorTitulo ;
  final double ancho;
  final TextAlign textAlign;
  final double? letterSpacing;


  TituloTextWidget({required this.title,  this.colorTitulo= Colors.black, this.ancho=0, this.textAlign=TextAlign.start, this.letterSpacing=0,});
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();

    Widget wg;

    if(ancho==0){
      wg=Text(
        title,
        textAlign: textAlign,
        style: TextStyle(
          letterSpacing: letterSpacing,
            color: colorTitulo,
            fontWeight: FontWeight.bold,
            fontSize: responsive.diagonalP(AppConfig.tamTexto)),
      );
    }
    else{
      wg=Container(
        width: responsive.anchoP(ancho),
        child: Text(
          title,
          textAlign: textAlign,
          style: TextStyle(
              letterSpacing: letterSpacing,
              color: colorTitulo,
              fontWeight: FontWeight.bold,
              fontSize: responsive.diagonalP(AppConfig.tamTextoTitulo)),
        ),
      );
    }

    return wg;
  }
}



part of 'customWidgets.dart';
class DesingTextNameUser extends StatelessWidget {
  const DesingTextNameUser({
    super.key,

    required this.sexo,
    required this.text,  this.sizeText,
  });

  final String text;
  final String sexo;
  final double? sizeText;


  @override
  Widget build(BuildContext context) {
    String Bienvenido =
    //sexo == 'HOMBRE' ? "BIENVENIDO: " : "BIENVENIDA: ";
    sexo == 'HOMBRE' ? "" : " ";
    final responsive = ResponsiveUtil();

    double sizeT=responsive.diagonalP(AppConfig.tamTextoTitulo-0.1);

    return TextLineasWidget(

      colorTexto: Colors.black,
      grosorLinea: 3,
      sizeTxt:sizeText==null?sizeT:sizeText!,
      title: Bienvenido+ text,
    );
  }
}

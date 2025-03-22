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
    sexo == 'HOMBRE' ? "BIENVENIDO: " : "BIENVENIDA: ";
    final responsive = ResponsiveUtil();

    double sizeT=responsive.diagonalP(AppConfig.tamTextoTitulo-0.5);

    return TextLineasWidget(
      sizeTxt:sizeText==null?sizeT:sizeText!,
      title: Bienvenido+ text,
    );
  }
}

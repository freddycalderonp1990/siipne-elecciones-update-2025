part of 'customWidgets.dart';
class DesingTextNameUser extends StatelessWidget {
  const DesingTextNameUser({
    super.key,

    required this.sexo,
    required this.text,
  });

  final String text;
  final String sexo;


  @override
  Widget build(BuildContext context) {
    String Bienvenido =
    sexo == 'HOMBRE' ? "BIENVENIDO: " : "BIENVENIDA: ";
    final responsive = ResponsiveUtil();
    
    return TextLineasWidget(
      sizeTxt:responsive.diagonalP(AppConfig.tamTextoTitulo-0.5) ,
      title: Bienvenido+ text,
    );
  }
}

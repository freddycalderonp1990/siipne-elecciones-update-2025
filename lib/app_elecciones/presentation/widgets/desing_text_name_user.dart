part of 'customWidgets.dart';
class DesingTextNameUser extends StatelessWidget {
  const DesingTextNameUser({
    super.key,

    required this.data,
  });

  final String data;


  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();
    
    return TextSombrasWidget(
      size:responsive.diagonalP(AppConfig.tamTextoTitulo-0.5) ,
      title: data,
    );
  }
}

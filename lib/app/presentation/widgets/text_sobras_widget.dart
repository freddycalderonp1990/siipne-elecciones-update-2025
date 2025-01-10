part of 'custom_app_widgets.dart';

class TextSombrasWidget extends StatelessWidget {
  final String title;
  final Color colorTexto;
  final Color colorSombra;
  final double size;

  const TextSombrasWidget(
      {required this.title,
      this.colorTexto = Colors.black,
      this.colorSombra = Colors.white,
      this.size = 15});

  @override
  Widget build(BuildContext context) {
    return Text(
      title == "null" ? "" : title,
      textAlign: TextAlign.center,
      style: TextStyle(

          color: colorTexto,
          shadows: [
            Shadow(
              blurRadius: 10,
              color: colorSombra,
              offset: Offset(2, 2),
            ),
            Shadow(
              blurRadius: 10,
              color: colorSombra,
              offset: Offset(-2, 2),
            ),
          ],
          fontWeight: FontWeight.bold,
          fontSize: size),
    );
  }
}

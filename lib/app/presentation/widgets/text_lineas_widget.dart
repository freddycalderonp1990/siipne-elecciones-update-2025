part of 'custom_app_widgets.dart';

class TextLineasWidget extends StatelessWidget {
  final String title;

  final Color colorTexto;
  final Color colorLineas;
  final double sizeTxt;
  final double grosorLinea;


  const TextLineasWidget(
      {required this.title,
      this.colorTexto = Colors.black,
      this.colorLineas = Colors.white,
      this.sizeTxt = 15,  this.grosorLinea=5});

  @override
  Widget build(BuildContext context) {
    return
      Stack(
        children: [
          // Texto con borde negro (contorno)
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              letterSpacing: 2.0,
              fontSize: sizeTxt,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = grosorLinea // Grosor del borde
                ..color = colorLineas, // Color del borde
            ),
          ),

          // Texto principal amarillo (relleno)
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              letterSpacing: 2.0,
              fontSize: sizeTxt,
              fontWeight: FontWeight.bold,
              color:colorTexto , // Color amarillo
            ),
          ),
        ],
      )
    ;
  }
}

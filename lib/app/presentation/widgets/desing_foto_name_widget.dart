part of 'custom_app_widgets.dart';


class DesingFotoNameWidget extends StatefulWidget {
  final String img;
  final String sexo;
  final String nombres;

  const DesingFotoNameWidget({
    super.key,
    required this.img,
    required this.sexo,
    required this.nombres,
  });

  @override
  State<DesingFotoNameWidget> createState() => _DesingFotoNameWidgetState();
}

class _DesingFotoNameWidgetState extends State<DesingFotoNameWidget> {
  bool showDatos = true;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();

    return Column(
      children: [
        SizedBox(height: responsive.altoP(1)),
        ImgPerfilRedonda(size: 27, img:!showDatos?"": widget.img),

        BtnIconWidget(
          colorBtn: Colors.transparent,
          colorIcon: Colors.black,
          colorTxt: Colors.black,
          icon: showDatos ? Icons.visibility_off : Icons.visibility,
          titulo: showDatos ? "Ocultar Datos" : "Mostrar Datos",
          onPressed: () {
            setState(() {
              showDatos = !showDatos;
            });
          },
        ),



          DesingTextoNameUser(sexo: widget.sexo, text:!showDatos?"XXXXXX XXXXXX XXXXX XXXXX": widget.nombres),

        SizedBox(height: responsive.altoP(1)),
      ],
    );
  }
}


class DesingTextoNameUser extends StatelessWidget {
  const DesingTextoNameUser({
    super.key,

    required this.sexo,
    required this.text,
    this.sizeText,
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

    double sizeT = responsive.diagonalP(AppConfig.tamTextoTitulo - 0.1);

    return TextLineasWidget(
      colorTexto: Colors.black,
      grosorLinea: 3,
      sizeTxt: sizeText == null ? sizeT : sizeText!,
      title: Bienvenido + text,
    );
  }
}

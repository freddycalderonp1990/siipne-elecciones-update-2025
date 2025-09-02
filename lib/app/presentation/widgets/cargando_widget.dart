part of 'custom_app_widgets.dart';

class CargandoWidget extends StatefulWidget {
  final bool mostrar;
  final Color? color;
  final String titulo;

  const CargandoWidget({required this.mostrar, this.color=AppColors.colorAzul_40,  this.titulo="Cargando"});

  @override
  _CargandoWidgetState createState() => _CargandoWidgetState();
}

class _CargandoWidgetState extends State<CargandoWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return widget.mostrar
        ? Container(
          color:widget. color,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: CircularProgressIndicator(

                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.colorAzul),
                      ),
                    ),
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent, // Fondo para que el escudo se vea bien
                      ),
                      child: Center(
                        child: Image.asset(
                          AppImages.escudopolicia,
                          width: 50,
                          height: 50,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),

                TextoCargandoAnimado(
                  titulo: widget.titulo,
                  style: TextStyle(
                    color: Colors.white,
                    shadows: [Shadow(color: Colors.black, offset: Offset(1, 1), blurRadius: 2)],
                  ),
                ),
              ],
            ),
          ),
        )
        : Container();
  }
}


class TextoCargandoAnimado extends StatefulWidget {
  final TextStyle? style;
  final String titulo;

  const TextoCargandoAnimado({Key? key, this.style, required this.titulo}) : super(key: key);

  @override
  _TextoCargandoAnimadoState createState() => _TextoCargandoAnimadoState();
}

class _TextoCargandoAnimadoState extends State<TextoCargandoAnimado> {
  int _dotCount = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (!mounted) return; // Protección extra
      setState(() {
        _dotCount = (_dotCount + 1) % 4;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancela el timer al destruir el widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String dots = '.' * _dotCount;
    return Text(
      '${widget.titulo}$dots',
      style: widget.style ?? TextStyle(color: Colors.white, fontSize: 18),
    );
  }
}



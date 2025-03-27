part of 'custom_app_widgets.dart';

class CargandoWidget extends StatefulWidget {
  final bool mostrar;
  final Color? color;

  const CargandoWidget({required this.mostrar, this.color=AppColors.colorAzul_40});

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
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.colorAzul,
                  ),
                ),

                TextSombrasWidget(title: "Cargando..."),
              ],
            ),
          ),
        )
        : Container();
  }
}

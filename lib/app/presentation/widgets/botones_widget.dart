part of 'custom_app_widgets.dart';

class BotonesWidget extends StatefulWidget {
  final String title;
  final VoidCallback? onPressed;
  final IconData? iconData;
  final EdgeInsetsGeometry? padding;

  const BotonesWidget(
      {this.onPressed, this.title = '', this.iconData, this.padding});

  @override
  _BotonesWidgetState createState() => _BotonesWidgetState();
}

class _BotonesWidgetState extends State<BotonesWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final responsive = ResponsiveUtil();

    return CupertinoButton(
      borderRadius: BorderRadius.circular(15),
      color: AppColors.colorBotones,
      onPressed: widget.onPressed,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            widget.iconData != null
                ? Icon(
                    widget.iconData,
                    color: Colors.white,
                    size: responsive.diagonalP(AppConfig.tamIcons),
                  )
                : Container(),
            SizedBox(
              width: responsive.anchoP(1),
            ),
            widget.title != ''
                ? Text(
                    widget.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: responsive.diagonalP(AppConfig.tamTexto)),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

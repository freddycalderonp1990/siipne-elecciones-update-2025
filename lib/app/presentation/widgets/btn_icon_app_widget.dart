part of 'custom_app_widgets.dart';
class BtnIconAppWidget extends StatefulWidget {
  final IconData? iconData;
  final String? iconString;
  final String title;
  final Color? colorBorder;
  final Color? colorBtn;
  final Color colorTextoIcon;
  final GestureTapCallback? onTap;
  final double elevation;
  final double sizeIcon;
  final double paddinHorizontal;
  final double sizeTexto;

  const BtnIconAppWidget(
      {this.onTap,
        this.iconData,
        this.title = "",
        this.colorBorder,
        this.colorTextoIcon = Colors.black87,
        this.elevation = 2.0,
        this.sizeIcon = 5.0,
        this.paddinHorizontal = 2.0,
        this.iconString, this.colorBtn, this.sizeTexto=AppConfig.tamTextoTitulo});

  @override
  _BtnIconAppWidgetState createState() => _BtnIconAppWidgetState();
}

class _BtnIconAppWidgetState extends State<BtnIconAppWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final responsive = ResponsiveUtil();
    var colorborder = widget.colorBorder;
    if (colorborder == null) {
      colorborder = AppColors.colorBordeBotones;
    }


    var colorBtn = widget.colorBtn;
    if (colorBtn == null) {
      colorBtn = AppColors.colorBordeBotones;
    }
    return Container(


      padding: EdgeInsets.symmetric(horizontal: widget.paddinHorizontal),
      child: Material(
        color: colorBtn,
        borderRadius:  BorderRadius.circular(AppConfig.radioBotones),
        child: InkWell(
          splashColor: AppColors.colorBordeBotones,

          borderRadius: BorderRadius.circular(AppConfig.radioBotones),
          onTap: widget.onTap,
          // handle your onTap here
          child: Container(
            padding: const EdgeInsets.all(5.0),

            decoration: BoxDecoration(
              border: Border.all(color: colorborder!=null?colorborder:Colors.transparent),
              borderRadius: BorderRadius.circular(AppConfig.radioBotones),
            ),


            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                widget.iconData != null
                    ? Icon(
                  widget.iconData,
                  size: responsive.diagonalP(widget.sizeIcon),
                  color: widget.colorTextoIcon,
                )
                    : widget.iconString != null
                    ? Container(height: responsive.diagonalP(widget.sizeIcon/2),child: Image.asset(widget.iconString!),)
                    : Container(
                  width: responsive.anchoP(1),
                ),
                widget.title != ""
                    ? SizedBox(
                  width: responsive.anchoP(1),
                )
                    : SizedBox(
                  width: responsive.anchoP(0),
                ),
                Flexible(
                    child:  Text(
                      widget.title,
                      style: TextStyle(
                        color: widget.colorTextoIcon,
                        fontSize: responsive.diagonalP(widget.sizeTexto),
                        fontWeight: FontWeight.w300,
                      ),
                    )),
                widget.title != ""
                    ? SizedBox(
                  width: responsive.anchoP(2),
                )
                    : SizedBox(
                  width: responsive.anchoP(0),
                )
              ],
            ),
          ),
        ),),
    );
  }
}

part of 'custom_app_widgets.dart';

class BtnMenuImgWidget extends StatefulWidget {
  final img;
  final String? title;
  final String? descripcion;
  final GestureTapCallback? onTap;
  final bool horizontal;
  final Color colorTexto;
  final Color colorFondo;

  const BtnMenuImgWidget(
      {this.img = null,
      this.title = '',
      this.onTap,
      this.horizontal = true,
      this.colorTexto = Colors.black87,
      this.colorFondo = Colors.blueAccent,
      this.descripcion});

  @override
  _BtnMenuImgWidget createState() => _BtnMenuImgWidget();
}

class _BtnMenuImgWidget extends State<BtnMenuImgWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final responsive = ResponsiveUtil();
    String imgString = widget.img.toString().trim();
    imgString = imgString.replaceAll('\r', '');
    imgString = imgString.replaceAll('\n', '');

    print("\n imgString ${imgString}");

    Widget horizontal = Container(
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.all(Radius.circular(60.0)),
            ),
            width: responsive.anchoP(17),
            height: responsive.anchoP(17),
            child: widget.img != null
                ? Image.asset(
                    widget.img,
                  )
                : Container(),
          ),
          SizedBox(
            width: responsive.altoP(0.5),
          ),
          Flexible(
              child: Material(
            color: Color(0xffeceaea),
            borderRadius: BorderRadius.circular(10),
            elevation: 2,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: widget.onTap,
              // handle your onTap here
              child: Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                width: responsive.anchoP(100),
                height: responsive.anchoP(17),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            widget.title!,
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                letterSpacing: 2.2,
                                color: widget.colorTexto != null
                                    ? widget.colorTexto
                                    : Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: responsive
                                    .diagonalP(AppConfig.tamTextoTitulo)),
                          ),
                        ),
                        widget.descripcion != null
                            ? Flexible(
                                child: Text(
                                  widget.descripcion!,
                                  overflow: TextOverflow.fade,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(

                                      color: widget.colorTexto != null
                                          ? widget.colorTexto
                                          : Colors.black87,
                                      fontWeight: FontWeight.w500,
                                      fontSize: responsive
                                          .diagonalP(AppConfig.tamTexto)),
                                ),
                              )
                            : Container()
                      ],
                    )),
                  ],
                ),
              ),
            ),
          ))
        ],
      ),
    );

    return horizontal;
  }
}

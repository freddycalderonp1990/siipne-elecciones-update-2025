part of 'customWidgets.dart';

class BtnMenuWidget extends StatefulWidget {
  final img;
  final String title;
  final String? descripcion;
  final GestureTapCallback? onTap;
  final bool horizontal;
  final Color colorTexto;
  final Color colorFondo;

  const BtnMenuWidget(
      {this.img = null,
      this.title = '',
      this.descripcion = '',
      this.onTap,
      this.horizontal = false,
      this.colorTexto = Colors.black,
      this.colorFondo = Colors.white});

  @override
  _BtnMenuWidgetState createState() => _BtnMenuWidgetState();
}

class _BtnMenuWidgetState extends State<BtnMenuWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final responsive = ResponsiveUtil();
    final fontSize= responsive
        .diagonalP(AppConfig.tamTexto-0.2);


    Widget horizontal= desing(wg: Row(
      crossAxisAlignment:
      CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: responsive.anchoP(13),
          height: responsive.anchoP(13),
          child: widget.img!=null? Image.asset(
            widget.img,
          ):Image.asset(
            SiipneImages.iconNoImg,
          ),
        ),
        SizedBox(
          width: responsive.altoP(1),
        ),
        Expanded(
            child: Text(
              widget.title,
              textAlign: TextAlign.center,

              style: TextStyle(
                  color: widget.colorTexto!=null? widget.colorTexto:Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize),
            )),
      ],
    ));




    Widget vertical= desing(wg: Column(
      crossAxisAlignment:
      CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: responsive.anchoP(12),
          height: responsive.anchoP(12),
          child: widget.img!=null? Image.asset(
            widget.img,
          ):Image.asset(
            SiipneImages.iconNoImg,
          ),
        ),
        SizedBox(
          width: responsive.altoP(1),
        ),
        Container(
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: widget.colorTexto!=null? widget.colorTexto:Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize),
            )),
      ],
    ));


    return widget.horizontal ? horizontal : vertical;
  }

  Widget desing({required Widget wg}){
    final responsive = ResponsiveUtil();
    final fontSize= responsive
        .diagonalP(AppConfig.tamTexto);
    return  Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConfig.radioBordecajas),
      ),
      child: Material(
        shadowColor:AppColors.colorAzulTitle,
        color:widget. colorFondo!=null?widget. colorFondo:Colors.white,
        borderRadius: BorderRadius.circular(20),
        elevation: 8,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap:widget.onTap,
          // handle your onTap here
          child: Container(
            margin:
            EdgeInsets.only(left: 20.0, right: 20.0,bottom: 10.0,top: 10),
            width: responsive.anchoP(70),

            child: wg,
          ),
        ),
      ),
    );
  }
}

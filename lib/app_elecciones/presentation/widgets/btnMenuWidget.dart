part of 'customWidgets.dart';

class BtnMenuWidget extends StatefulWidget {
  final img;
  final String? imgLocal;
  final String? title;
  final GestureTapCallback? onTap;
  final bool horizontal;
  final Color colorTexto;
  final Color colorFondo;
  final bool mostrarLine;

  const BtnMenuWidget(
      {this.img = null,
      this.imgLocal,
      this.title = '',
      this.onTap,
      this.horizontal = true,
      this.colorTexto = AppColors.colorAzul_1,
      this.colorFondo = Colors.blue,  this.mostrarLine=true});

  @override
  _BtnMenuWidgetState createState() => _BtnMenuWidgetState();
}

class _BtnMenuWidgetState extends State<BtnMenuWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final responsive = ResponsiveUtil();

    var imgMemory = null;

    print("----------------------");
    print(widget.img);
    print("----------------------");
    if (widget.img != null && widget.img != '') {
      imgMemory = PhotoHelper.convertStringToUint8List(widget.img);
    }
    Widget horizontal = Container(
      child: Material(
        shadowColor: Colors.transparent,
        color: Colors.transparent,
        elevation: 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: widget.onTap,
          // handle your onTap here
          child: Container(
            margin:
                EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

                Container(
                  width: responsive.anchoP(22), // Ancho fijo del contenedor
                  height: responsive.anchoP(22),
                  padding: EdgeInsets.all(15),  // Espacio entre la imagen y el borde
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: AppColors.colorPrimary,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: imgMemory != null
                      ? Container(
                    padding: EdgeInsets.all(5),  // Padding adicional para separar la imagen del borde
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: Image.memory(imgMemory).image,
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                      : Image.asset(
                    AppImages.iconNoImg,
                  ),
                ),

                SizedBox(
                  width: 20,
                ),
                Expanded(
                  // Cambiado de Flexible a Expanded
                  child: TextSombrasWidget(
                    size: responsive.diagonalP(AppConfig.tamTextoTitulo),
                    colorSombra: Colors.black12,

                    title: widget.title!,
                    colorTexto: widget.colorTexto,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    Widget vertical = Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConfig.radioBordecajas),
          boxShadow: [
            BoxShadow(
                color: AppColors.colorBordecajas,
                blurRadius: AppConfig.sobraBordecajas)
          ]),
      child: Material(
        shadowColor:
            widget.colorFondo != null ? widget.colorFondo : Colors.white,
        color: widget.colorFondo != null ? widget.colorFondo : Colors.white,
        borderRadius: BorderRadius.circular(20),
        elevation: 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: widget.onTap,
          // handle your onTap here
          child: Container(
            margin:
                EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0, top: 10),
            width: responsive.anchoP(70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: responsive.anchoP(18),
                  height: responsive.anchoP(18),
                  child: imgMemory != null
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            image: DecorationImage(
                              image: Image.memory(imgMemory).image,
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                      : widget.imgLocal != null
                          ? Image.asset(
                              widget.imgLocal!,
                            )
                          : Image.asset(
                              AppImages.iconNoImg,
                            ),
                ),
                SizedBox(
                  width: responsive.altoP(1),
                ),
                Container(
                    child: Text(
                  widget.title!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: widget.colorTexto != null
                          ? widget.colorTexto
                          : Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize:
                          responsive.diagonalP(AppConfig.tamTextoTitulo - 0.5)),
                )),
              ],
            ),
          ),
        ),
      ),
    );

   Widget wg=Column(children: [
     widget.horizontal ? horizontal : vertical,
     widget. mostrarLine?Container(height: 2,color: AppColors.colorAzul_1,):Container(),
     SizedBox(
       height: 20,
     ),
    ],);

    return wg;
  }
}

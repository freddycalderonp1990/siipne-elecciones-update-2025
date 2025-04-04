part of 'customWidgets.dart';
class WorkAreaLoginPageWidget extends StatefulWidget {
  final  RxBool peticionServer;
  final String title;
  final String name;
  final List<Widget> contenido;
  final bool btnAtras;
  final VoidCallback? pantallaIrAtras;
  final Widget? widgetBtnFinal;
  final EdgeInsetsGeometry? paddin;
  final FloatingActionButtonLocation ubicacionBtnFinal;
  final imgPerfil;
  final imgFondo;
  final double sizeTittle;
  final bool mostrarVersion;

  const WorkAreaLoginPageWidget({
    required this.peticionServer,
    this.title = '',
    required this.contenido,
    this.btnAtras = false,
    this.widgetBtnFinal,
    this.paddin,
    this.ubicacionBtnFinal = FloatingActionButtonLocation.centerFloat,
    this.imgPerfil = null,
    this.imgFondo,
    this.sizeTittle = 0,
    this.mostrarVersion = false,
    this.pantallaIrAtras,
    this.name = '',
  });

  @override
  _WorkAreaLoginPageWidgetState createState() => _WorkAreaLoginPageWidgetState();
}

class _WorkAreaLoginPageWidgetState extends State<WorkAreaLoginPageWidget> {
  String version = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadVersion();
  }

  _loadVersion() async {
    String _version = await DeviceInfo.getVersionCodeNameApp;
    setState(() {
      version = _version;
    });
  }

  Widget getTitle() {
    final responsive = ResponsiveUtil();



    return widget.title != ''
        ? TextSombrasWidget(
      colorTexto: Colors.white,
      colorSombra: Colors.black,
      title: widget.title,
      size: responsive.diagonalP(AppConfig.tamTextoTitulo+1),
    )
        : Container();
  }
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();


    Widget wgImgFondo = Container(
      height: responsive.alto,
      width: responsive.ancho,
      child: Image.asset(
        widget.imgFondo == null
            ? AppImages.imgFondoDefault
            : widget.imgFondo,
        fit: BoxFit.fill,
      ),
    );


    Widget wgImgPerfil = Center(
      child: Column(
        children: <Widget>[
          getTitle(),
          SizedBox(height: responsive.altoP(4),),
          widget.imgPerfil != null
              ? imgPerfilRedonda(
            size: 28,
            img: widget.imgPerfil,
          )
              : Container(height: responsive.altoP(5)),
          SizedBox(height: responsive.altoP(1),),
          widget.name != ''
              ? Text(
            widget.name,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "",
                color: Colors.black.withOpacity(0.8),
                fontWeight: FontWeight.w300,
                fontSize: widget.sizeTittle == 0
                    ? responsive.anchoP(4)
                    : responsive.anchoP(widget.sizeTittle)),
          )
              : Container(),

          widget.mostrarVersion
              ?
          TextLineasWidget(title: 'Versión: ' + version,colorTexto: Colors.black,sizeTxt: 10,grosorLinea: 2,)


              : Container()
        ],
      ),
    );

    wgImgPerfil = Container(
      margin: EdgeInsets.only(
        top: responsive.altoP(1.0),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConfig.radioBordecajas),
          boxShadow: [
            BoxShadow(color: Colors.blue.withOpacity(0.1), blurRadius: 45)
          ]),
      child: Stack(
        children: [

          widget.btnAtras
              ? BtnAtrasWidget(
            pantallaIrAtras: widget.pantallaIrAtras,
          )
              : Container(),
          wgImgPerfil
        ],
      ),
    );

    return Scaffold(
        floatingActionButtonLocation: widget.ubicacionBtnFinal,
        floatingActionButton: widget.widgetBtnFinal,
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Stack(
              children: [
                wgImgFondo,
                SafeArea(
                  child: Column(
                    children: [
                     Expanded(child: Column(
                       mainAxisAlignment:
                       MainAxisAlignment.center,
                       children: <Widget>[
                         wgImgPerfil,
                         Column(
                           children: widget.contenido != null
                               ? widget.contenido
                               : [Container()],
                         )
                       ],
                     ))
                    ],
                  ),
                ),
                Obx(()=>  CargandoWidget(
                  mostrar: widget.peticionServer.value,
                ))
              ],
            )));
  }
}





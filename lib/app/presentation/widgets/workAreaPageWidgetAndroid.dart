part of 'custom_app_widgets.dart';

class WorkAreaPageWidgetAndroid extends StatefulWidget {
  final RxBool peticionServer;

  final Widget contenido;

  final String title;
  final imgPerfil;
  final imgFondo;

  final bool mostrarVersion;
  final bool mostrarBtnHome;
  final VoidCallback? onPressedBtnHome;

  const WorkAreaPageWidgetAndroid({
    required this.peticionServer,
    required this.contenido,
    this.imgPerfil = null,
    this.imgFondo,
    this.mostrarVersion = false,
    this.title = '',
    this.mostrarBtnHome = false, this.onPressedBtnHome,
  });

  @override
  _WorkAreaPageWidgetAndroidState createState() => _WorkAreaPageWidgetAndroidState();
}

class _WorkAreaPageWidgetAndroidState extends State<WorkAreaPageWidgetAndroid> {
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

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        print("orientation ${orientation}");

        //orientation == Orientation.portrait
        return getDersingPage();
      },
    );
  }

  Widget getDersingPage() {
    final responsive = ResponsiveUtil();
    return Scaffold(
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Stack(
              children: [

                getImgFondo(),

              widget.mostrarBtnHome?  getBtnHome():Container(),


                Column(
                  children: [
                    Expanded(
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: responsive.anchoP(7)),
                            child: Center(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    getImgPerfil(),
                                    getTitle(),
                                    getVersion(),
                                    widget.contenido != null
                                        ? widget.contenido
                                        : Container(),
                                  ],
                                ),
                              ),
                            ))),
                  ],
                ),
                Obx(
                  () => CargandoWidget(
                    mostrar: widget.peticionServer.value,
                  ),
                ),



                

                
              ],
            )));
  }

  Widget getBtnHome() {
    final responsive = ResponsiveUtil();
    return Positioned(
        top: responsive.altoP(20),
        right: 10,
        child: BtnIconWidget(
          colorIcon: Colors.black,
          colorTxt: Colors.black,
          onPressed:widget. onPressedBtnHome,
          icon: Icons.menu,
          titulo: "Home",
        ));
  }

  Widget getImgFondo() {
    final responsive = ResponsiveUtil();
    return Container(
      height: responsive.alto,
      width: responsive.ancho,
      child: Image.asset(
        widget.imgFondo == null ? AppImages.imgFondoDefault : widget.imgFondo,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget getTitle() {
    final responsive = ResponsiveUtil();
    return widget.title != ''
        ? TextSombrasWidget(
            colorTexto: Colors.white,
            colorSombra: Colors.black,
            title: widget.title,
            size: responsive.diagonalP(AppConfig.tamTextoTitulo),
          )
        : Container();
  }

  Widget getVersion() {
    return widget.mostrarVersion
        ? TextSombrasWidget(
            title: version,
            colorTexto: Colors.white,
            colorSombra: Colors.black,
          )
        : Container();
  }

  Widget getImgPerfil() {
    final responsive = ResponsiveUtil();
    return widget.imgPerfil == null
        ? Container()
        : imgPerfilRedonda(
            size: responsive.diagonalP(AppConfig.tamIcons),
            img: widget.imgPerfil,
          );
  }
}

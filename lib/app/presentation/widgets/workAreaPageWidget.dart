part of 'custom_app_widgets.dart';

class WorkAreaPageWidget extends StatefulWidget {
  final RxBool peticionServer;

  final Widget contenido;

  final ValueChanged<String>? onChangedBusqueda;
  final VoidCallback? onPressBtnAtras;
  final bool showGps;

  final String? title;
  final imgPerfil;
  final imgFondo;

  final bool mostrarVersion;
  final bool mostrarBtnHome;

  final bool mostrarBtnAtras;

  final VoidCallback? onPressedBtnHome;

  const WorkAreaPageWidget(
      {required this.peticionServer,
      required this.contenido,
      this.imgPerfil = null,
      this.imgFondo,
      this.mostrarVersion = false,
      this.title,
      this.mostrarBtnHome = false,
      this.onPressedBtnHome,
      this.mostrarBtnAtras = false,
      this.onChangedBusqueda,
      this.onPressBtnAtras,
      this.showGps = false});

  @override
  _WorkAreaPageWidgetState createState() => _WorkAreaPageWidgetState();
}

class _WorkAreaPageWidgetState extends State<WorkAreaPageWidget> {
  bool _isSearching = false;

  String version = '';
  String namePhone = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadVersion();
  }

  _loadVersion() async {
    String _version = await DeviceInfo.getVersionCodeNameApp;
    String _namePhone = await DeviceInfo.getDeviceMarca;
    _namePhone = _namePhone + " " + await DeviceInfo.getNameDevice;
    _namePhone = "";

    setState(() {
      version = _version;
      namePhone = _namePhone;
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

  Widget getDesingImgProceso() {
    final responsive = ResponsiveUtil();
    return Obx(() {
      if (SiipneImages.imgCabeceraProceso.value.length > 10) {
        var imgMemory = PhotoHelper.convertStringToUint8List(
            SiipneImages.imgCabeceraProceso.value);
        // Puedes procesar imgCabeceraProceso y convertirla a un widget
        return imgMemory != null
            ? Positioned(
                right: 5,
                top: 5,
                child: Container(
                    height: responsive.isHorizontal()
                        ? responsive.altoP(24)
                        : responsive.altoP(12),
                    width: responsive.isHorizontal()
                        ? responsive.anchoP(50)
                        : responsive.anchoP(48),
                    child: Center(
                      child: Image.memory(imgMemory, fit: BoxFit.contain),
                    )))
            : Container();
      } else {
        return Container();
      }
    });
  }

  Widget desingContenido() {
    final responsive = ResponsiveUtil();

    Widget wgContenido = widget.showGps
        ? GpsAccessScreen(contenido: widget.contenido)
        : widget.contenido;

    return widget.title != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextSombrasWidget(
                colorTexto: Colors.white,
                colorSombra: Colors.black,
                title: widget.title!,
                size: responsive.diagonalP(AppConfig.tamTextoTitulo+0.4) ,
              ),
              Flexible(child: wgContenido),
            ],
          )
        : wgContenido;
  }

  Widget getDersingPage() {
    final responsive = ResponsiveUtil();

    return Scaffold(
        backgroundColor:
            AppColors.colorPrimary, // Cambia esto al color que desees
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Stack(
              children: [
                getImgFondo(),
                getDesingImgProceso(),
                Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            height: responsive.altoP(15),
                          ),
                          Flexible(
                              child: Center(
                                child: Container(

                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: desingContenido(),
                                ),
                              )),
                          SizedBox(
                            height: responsive.altoP(5),
                          )
                        ],
                      ),
                    ),
                  ],
                ),

                widget.mostrarBtnAtras
                    ? BtnAtrasWidget(
                  pantallaIrAtras: widget.onPressBtnAtras,
                )
                    : Container(),

                getBtnBuscar(),
                widget.mostrarBtnHome ? getBtnHome() : Container(),

                Obx(
                      () => CargandoWidget(
                    mostrar: widget.peticionServer.value,
                  ),
                ),
                // Condicional de Anuncio
              ],
            )));
  }

  Widget getBtnBuscar() {
    return widget.onChangedBusqueda != null
        ? !_isSearching
            ? BtnBuscar(
                onPressed: () {
                  setState(() {
                    _isSearching =
                        !_isSearching; // Asegúrate de usar setState aquí
                  });
                },
              )
            : Container()
        : Container();
  }

  Widget getBtnHome() {
    final responsive = ResponsiveUtil();
    return Positioned(
        top: responsive.altoP(2),
        right: 10,
        child: BtnIconWidget(

          onPressed: widget.onPressedBtnHome,
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

  Widget getVersion() {
    return widget.mostrarVersion
        ? Column(
            children: [
              TextSombrasWidget(
                size: 13,
                title: version,
                colorTexto: Colors.white,
                colorSombra: Colors.black,
              ),
            ],
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

class BtnBuscar extends StatelessWidget {
  final Function()? onPressed;
  const BtnBuscar({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();
    return Positioned(
        right: responsive.isVertical()
            ? responsive.altoP(1)
            : responsive.anchoP(1),
        top: responsive.isVertical()
            ? responsive.altoP(1)
            : responsive.anchoP(2),
        child: SafeArea(
          child: CupertinoButton(
            minSize: responsive.isVertical()
                ? responsive.altoP(5)
                : responsive.anchoP(5),
            padding: EdgeInsets.all(3),
            borderRadius: BorderRadius.circular(30),
            color: Colors.black26,
            onPressed: onPressed,
            //volver atras
            child: Icon(
              Icons.search,
              color: Colors.white,
              size: responsive.isVertical()
                  ? responsive.altoP(3)
                  : responsive.anchoP(3),
            ),
          ),
        ));
  }
}

class SearchWidget extends StatefulWidget {
  final ValueChanged<String>? onChangedBusqueda;
  final ValueChanged<bool> onChangedisSearching;
  final String? title;
  final bool isSearching;

  SearchWidget(
      {this.onChangedBusqueda,
      this.title,
      required this.isSearching,
      required this.onChangedisSearching});

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _searchQueryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.onChangedBusqueda == null) {
      return getTitle();
    }

    return Container(
      padding: EdgeInsets.only(right: 10, left: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.isSearching
              ? Expanded(
                  child: TextField(
                      autofocus: true,
                      controller: _searchQueryController,
                      onChanged: (value) {
                        if (widget.onChangedBusqueda != null) {
                          widget.onChangedBusqueda!(value);
                        }
                      },
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: "Buscar...",
                        hintStyle: TextStyle(color: Colors.black),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors
                                  .colorPrimary), // Cambia a tu color deseado
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors
                                  .colorPrimary), // Cambia a tu color deseado
                        ),
                      )),
                )
              : getTitle(), // Espacio para alinear la lupa a la derecha
          Row(
            children: [
              widget.isSearching
                  ? IconButton(
                      icon: Icon(
                          widget.isSearching ? Icons.close : Icons.search,
                          color: Colors.white),
                      onPressed: () {
                        setState(() {
                          if (widget.isSearching) {
                            _searchQueryController.clear();
                            if (widget.onChangedBusqueda != null) {
                              widget.onChangedBusqueda!("");
                            }
                          }
                          widget.onChangedisSearching(!widget.isSearching);
                        });
                      },
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }

  getTitle() {
    final responsive = ResponsiveUtil();
    return widget.title != null
        ? TextSombrasWidget(
            colorTexto: AppColors.colorAmarilloTitle,
            colorSombra: Colors.black87,
            title: widget.title!,
            size: responsive.diagonalP(AppConfig.tamTextoTitulo + 0.6),
          )
        : Container();
  }
}

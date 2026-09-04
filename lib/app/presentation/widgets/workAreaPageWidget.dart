  part of 'custom_app_widgets.dart';

  class WorkAreaPageWidget extends StatefulWidget {
    final RxBool peticionServer;
    final NamApps namApps;
    final Widget contenido;
    final ValueChanged<String>? onChangedBusqueda;
    final VoidCallback? onPressBtnAtras;
    final bool showGps;
    final String? title;
    final double? tamanoTitulo;
    final imgPerfil;
    final imgFondo;
    final bool mostrarVersion;
    final bool mostrarBtnHome;
    final bool mostrarBtnAtras;
    final VoidCallback? onPressedBtnHome;
    final bool showBtnNotificacione;
    final bool mostrarDatosServidor;
    final String? nombresServidor;
    final String? sexoServidor;

    const WorkAreaPageWidget({
      required this.peticionServer,
      required this.contenido,
      this.imgPerfil=null,
      this.imgFondo,
      this.mostrarVersion=false,
      this.title,
      this.tamanoTitulo,
      this.mostrarBtnHome=false,
      this.onPressedBtnHome,
      this.mostrarBtnAtras=false,
      this.onChangedBusqueda,
      this.onPressBtnAtras,
      this.showGps=false,
      this.namApps=NamApps.Elecciones,
      this.showBtnNotificacione=false,
      this.mostrarDatosServidor=false,
      this.nombresServidor,
      this.sexoServidor,
    });

    @override
    _WorkAreaPageWidgetState createState()=>_WorkAreaPageWidgetState();
  }

  class _WorkAreaPageWidgetState extends State<WorkAreaPageWidget> {
    bool _isSearching=false;
    String version='';
    String namePhone='';
    final NotificationService notificationService=Get.find();

    @override
    void initState(){
      super.initState();
      _loadVersion();
    }

    _loadVersion() async {
      String _version=await DeviceInfoApp.getVersionCodeNameApp;
      String _namePhone=await DeviceInfoApp.getDeviceMarca;
      _namePhone=_namePhone+" "+await DeviceInfoApp.getNameDevice;
      _namePhone="";
      if(!mounted)return;
      setState((){
        version=_version;
        namePhone=_namePhone;
      });
    }

    @override
    Widget build(BuildContext context){
      return OrientationBuilder(
        builder:(context,orientation)=>getDersingPage(),
      );
    }

    Widget getDesingImgProceso(){
      return Container();
    }

    Widget desingContenido(){
      Widget wgContenido=widget.showGps
          ?GpsAccessScreen(contenido:widget.contenido,namApps:widget.namApps)
          :widget.contenido;
      return wgContenido;
    }

    Widget getDersingPage(){
      final responsive=ResponsiveUtil();

      return Scaffold(
        backgroundColor:AppColors.colorPrimary,
        body:GestureDetector(
          onTap:()=>FocusScope.of(context).requestFocus(FocusNode()),
          child:Stack(
            children:[
              getImgFondo(),
              getDesingImgProceso(),
              SafeArea(
                bottom:false,
                child:Column(
                  children:[
                    SizedBox(height:responsive.altoP(1)),
                    if(widget.title!=null)_cabeceraTitulo(),
                    if(widget.title!=null)SizedBox(height:responsive.altoP(.9)),
                    if(widget.mostrarDatosServidor)_datosServidorPolicial(),
                    if(widget.mostrarDatosServidor)SizedBox(height:responsive.altoP(1)),
                    Expanded(
                      child:Padding(
                        padding:const EdgeInsets.symmetric(horizontal:12),
                        child:desingContenido(),
                      ),
                    ),
                    if(widget.mostrarVersion)getVersion(),
                    SizedBox(height:MediaQuery.of(context).padding.bottom),
                  ],
                ),
              ),
              getBtnBuscar(),
              widget.mostrarBtnHome?getBtnHome():Container(),
              Obx(()=>CargandoWidget(mostrar:widget.peticionServer.value)),
            ],
          ),
        ),
      );
    }

    Widget _cabeceraTitulo(){
      return Padding(
        padding:const EdgeInsets.symmetric(horizontal:12),
        child:Stack(
          alignment:Alignment.center,
          children:[
            if(widget.mostrarBtnAtras)
              Align(
                alignment:Alignment.centerLeft,
                child:_botonRegresar(),
              ),
            Padding(
              padding:EdgeInsets.symmetric(horizontal:widget.mostrarBtnAtras?52:8),
              child:_tituloPrincipal(),
            ),
          ],
        ),
      );
    }

    Widget _tituloPrincipal(){
      final String titulo=widget.title?.trim()??'';
      final double fontSize=widget.tamanoTitulo??20;

      return LayoutBuilder(
        builder:(context,constraints){
          return Column(
            mainAxisSize:MainAxisSize.min,
            children:[
              Text(
                titulo,
                textAlign:TextAlign.center,
                maxLines:3,
                softWrap:true,
                overflow:TextOverflow.visible,
                style:TextStyle(
                  color:Colors.black,
                  fontSize:fontSize,
                  fontWeight:FontWeight.w900,
                  letterSpacing:.6,
                  height:1.08,
                  shadows:const[
                    Shadow(
                      color:Colors.black12,
                      blurRadius:3,
                      offset:Offset(0,1),
                    ),
                  ],
                ),
              ),
              const SizedBox(height:6),
              Container(
                width:52,
                height:3,
                decoration:BoxDecoration(
                  borderRadius:BorderRadius.circular(20),
                  gradient:const LinearGradient(
                    colors:[
                      Color(0xFF123F75),
                      Color(0xFF2869AC),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

    Widget _botonRegresar(){
      return Material(
        color:Colors.transparent,
        borderRadius:BorderRadius.circular(14),
        clipBehavior:Clip.antiAlias,
        child:InkWell(
          onTap:widget.onPressBtnAtras??()=>Get.back(),
          splashColor:Colors.white.withOpacity(.14),
          highlightColor:Colors.white.withOpacity(.07),
          child:Ink(
            width:44,
            height:44,
            decoration:BoxDecoration(
              gradient:const LinearGradient(
                begin:Alignment.topLeft,
                end:Alignment.bottomRight,
                colors:[
                  Color(0xFF123F75),
                  Color(0xFF195496),
                  Color(0xFF2869AC),
                ],
              ),
              borderRadius:BorderRadius.circular(14),
              border:Border.all(
                color:Colors.white.withOpacity(.55),
                width:1.2,
              ),
              boxShadow:[
                BoxShadow(
                  color:const Color(0xFF17365D).withOpacity(.24),
                  blurRadius:10,
                  offset:const Offset(0,4),
                ),
                BoxShadow(
                  color:Colors.white.withOpacity(.18),
                  blurRadius:2,
                  offset:const Offset(0,-1),
                ),
              ],
            ),
            child:Stack(
              alignment:Alignment.center,
              children:[
                Positioned(
                  top:5,
                  left:6,
                  right:6,
                  child:Container(
                    height:1,
                    decoration:BoxDecoration(
                      gradient:LinearGradient(
                        colors:[
                          Colors.transparent,
                          Colors.white.withOpacity(.45),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color:Colors.white,
                  size:18,
                ),
              ],
            ),
          ),
        ),
      );
    }
    Widget _datosServidorPolicial(){
      return Container(
        width:double.infinity,
        margin:const EdgeInsets.symmetric(horizontal:12),
        decoration:BoxDecoration(
          color:Colors.white.withOpacity(.97),
          borderRadius:BorderRadius.circular(21),
          border:Border.all(
            color:const Color(0xFF195496).withOpacity(.11),
          ),
          boxShadow:[
            BoxShadow(
              color:const Color(0xFF17365D).withOpacity(.10),
              blurRadius:20,
              offset:const Offset(0,7),
            ),
          ],
        ),
        child:Column(
          children:[
            Padding(
              padding:const EdgeInsets.fromLTRB(13,12,11,12),
              child:Row(
                crossAxisAlignment:CrossAxisAlignment.center,
                children:[
                  _fotoServidor(),
                  const SizedBox(width:13),
                  Expanded(
                    child:Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children:[
                        Row(
                          children:[
                            Flexible(
                              child:Container(
                                padding:const EdgeInsets.symmetric(
                                  horizontal:7,
                                  vertical:3,
                                ),
                                decoration:BoxDecoration(
                                  color:const Color(0xFFE8F0F8),
                                  borderRadius:BorderRadius.circular(20),
                                  border:Border.all(
                                    color:const Color(0xFF195496).withOpacity(.08),
                                  ),
                                ),
                                child:const Row(
                                  mainAxisSize:MainAxisSize.min,
                                  children:[
                                    Icon(
                                      Icons.badge_outlined,
                                      color:Color(0xFF195496),
                                      size:11,
                                    ),
                                    SizedBox(width:4),
                                    Flexible(
                                      child:Text(
                                        'SERVIDOR POLICIAL',
                                        maxLines:1,
                                        overflow:TextOverflow.ellipsis,
                                        style:TextStyle(
                                          color:Color(0xFF195496),
                                          fontSize:7.3,
                                          fontWeight:FontWeight.w900,
                                          letterSpacing:.65,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width:6),
                            Container(
                              padding:const EdgeInsets.symmetric(
                                horizontal:6,
                                vertical:3,
                              ),
                              decoration:BoxDecoration(
                                color:const Color(0xFFEAF5EE),
                                borderRadius:BorderRadius.circular(20),
                              ),
                              child:const Row(
                                mainAxisSize:MainAxisSize.min,
                                children:[
                                  Icon(
                                    Icons.circle,
                                    color:Color(0xFF319461),
                                    size:6,
                                  ),
                                  SizedBox(width:4),
                                  Text(
                                    'ACTIVO',
                                    style:TextStyle(
                                      color:Color(0xFF287850),
                                      fontSize:6.8,
                                      fontWeight:FontWeight.w800,
                                      letterSpacing:.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height:7),
                        _nombreServidor(),
                        const SizedBox(height:7),
                        Row(
                          children:[
                            Expanded(
                              child:Container(
                                padding:const EdgeInsets.symmetric(
                                  horizontal:8,
                                  vertical:6,
                                ),
                                decoration:BoxDecoration(
                                  color:const Color(0xFFF5F8FB),
                                  borderRadius:BorderRadius.circular(10),
                                  border:Border.all(
                                    color:const Color(0xFFE0E7EE),
                                  ),
                                ),
                                child:const Row(
                                  children:[
                                    Icon(
                                      Icons.verified_user_outlined,
                                      color:Color(0xFF195496),
                                      size:13,
                                    ),
                                    SizedBox(width:5),
                                    Expanded(
                                      child:Text(
                                        'Cuenta institucional SIIPNE Elecciones',
                                        maxLines:1,
                                        overflow:TextOverflow.ellipsis,
                                        style:TextStyle(
                                          color:Color(0xFF667789),
                                          fontSize:8.3,
                                          fontWeight:FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if(widget.showBtnNotificacione)...[
                              const SizedBox(width:7),
                              _botonNotificaciones(),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget _nombreServidor(){
      final String nombres=widget.nombresServidor?.trim()??'';

      return LayoutBuilder(
        builder:(context,constraints){
          return Text(
            nombres,
            softWrap:true,
            maxLines:3,
            overflow:TextOverflow.visible,
            textScaler:const TextScaler.linear(1),
            style:const TextStyle(
              color:Color(0xFF17365D),
              fontSize:13.2,
              fontWeight:FontWeight.w900,
              height:1.12,
              letterSpacing:.05,
            ),
          );
        },
      );
    }

    Widget _fotoServidor(){


      return Stack(
        clipBehavior:Clip.none,
        children:[
          Container(
            width:86,
            height:86,
            padding:const EdgeInsets.all(3),
            decoration:BoxDecoration(
              shape:BoxShape.circle,
              gradient:const LinearGradient(
                begin:Alignment.topLeft,
                end:Alignment.bottomRight,
                colors:[
                  Color(0xFFA7CBEA),
                  Color(0xFF195496),
                  Color(0xFF123F75),
                ],
              ),
              boxShadow:[
                BoxShadow(
                  color:const Color(0xFF195496).withOpacity(.22),
                  blurRadius:15,
                  offset:const Offset(0,5),
                ),
              ],
            ),
            child:Container(
              padding:const EdgeInsets.all(3),
              decoration:const BoxDecoration(
                color:Colors.white,
                shape:BoxShape.circle,
              ),
              child:ClipOval(
                child:ImgPerfilRedonda(
                  size:74,
                  img:widget.imgPerfil,
                ),
              ),
            ),
          ),
          Positioned(
            right:-1,
            bottom:4,
            child:Container(
              width:23,
              height:23,
              decoration:BoxDecoration(
                color:const Color(0xFF195496),
                shape:BoxShape.circle,
                border:Border.all(
                  color:Colors.white,
                  width:2.5,
                ),
                boxShadow:[
                  BoxShadow(
                    color:Colors.black.withOpacity(.12),
                    blurRadius:5,
                  ),
                ],
              ),
              child:const Icon(
                Icons.verified_rounded,
                color:Colors.white,
                size:13,
              ),
            ),
          ),
        ],
      );
    }

    Widget _botonNotificaciones(){
      return GestureDetector(
        onTap:()=>Get.toNamed(AppRoutes.SHOW_NOTIFICATION),
        child:Stack(
          clipBehavior:Clip.none,
          children:[
            Container(
              width:38,
              height:38,
              decoration:BoxDecoration(
                gradient:const LinearGradient(
                  begin:Alignment.topLeft,
                  end:Alignment.bottomRight,
                  colors:[
                    Color(0xFF123F75),
                    Color(0xFF2869AC),
                  ],
                ),
                borderRadius:BorderRadius.circular(11),
                boxShadow:[
                  BoxShadow(
                    color:const Color(0xFF195496).withOpacity(.22),
                    blurRadius:9,
                    offset:const Offset(0,3),
                  ),
                ],
              ),
              child:const Icon(
                Icons.notifications_none_rounded,
                color:Colors.white,
                size:20,
              ),
            ),
            Obx((){
              if(notificationService.cantidadNoLeidas.value<=0){
                return const SizedBox.shrink();
              }

              return Positioned(
                right:-5,
                top:-6,
                child:Container(
                  constraints:const BoxConstraints(
                    minWidth:19,
                    minHeight:19,
                  ),
                  padding:const EdgeInsets.symmetric(
                    horizontal:5,
                    vertical:2,
                  ),
                  decoration:BoxDecoration(
                    color:const Color(0xFFD84B4B),
                    borderRadius:BorderRadius.circular(20),
                    border:Border.all(
                      color:Colors.white,
                      width:2,
                    ),
                  ),
                  alignment:Alignment.center,
                  child:Text(
                    notificationService.cantidadNoLeidas.value>99
                        ?'99+'
                        :notificationService.cantidadNoLeidas.value.toString(),
                    style:const TextStyle(
                      color:Colors.white,
                      fontSize:7.5,
                      fontWeight:FontWeight.w900,
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      );
    }

    Widget getBtnBuscar(){
      return widget.onChangedBusqueda!=null
          ?!_isSearching
          ?BtnBuscar(
        onPressed:(){
          setState(()=>_isSearching=!_isSearching);
        },
      )
          :Container()
          :Container();
    }

    Widget getBtnHome(){
      final responsive=ResponsiveUtil();

      return Positioned(
        top:responsive.altoP(5),
        right:10,
        child:BtnIconWidget(
          onPressed:widget.onPressedBtnHome,
          icon:Icons.menu,
          titulo:"Home",
        ),
      );
    }

    Widget getImgFondo(){
      final responsive=ResponsiveUtil();

      return SizedBox(
        height:responsive.alto,
        width:responsive.ancho,
        child:Image.asset(
          widget.imgFondo==null
              ?AppImages.imgFondoDefault
              :widget.imgFondo,
          fit:BoxFit.fill,
        ),
      );
    }

    Widget getVersion(){
      return widget.mostrarVersion
          ?Padding(
        padding:const EdgeInsets.only(bottom:5),
        child:TextSombrasWidget(
          size:13,
          title:version,
          colorTexto:Colors.white,
          colorSombra:Colors.black,
        ),
      )
          :Container();
    }

    Widget getImgPerfil(){
      final responsive=ResponsiveUtil();

      return widget.imgPerfil==null
          ?Container()
          :ImgPerfilRedonda(
        size:responsive.diagonalP(AppConfig.tamIcons),
        img:widget.imgPerfil,
      );
    }
  }

  class BtnBuscar extends StatelessWidget {
    final Function()? onPressed;

    const BtnBuscar({super.key,this.onPressed});

    @override
    Widget build(BuildContext context){
      final responsive=ResponsiveUtil();

      return Positioned(
        right:responsive.isVertical()
            ?responsive.altoP(1)
            :responsive.anchoP(1),
        top:responsive.isVertical()
            ?responsive.altoP(1)
            :responsive.anchoP(2),
        child:SafeArea(
          child:CupertinoButton(
            minimumSize:Size(
              responsive.isVertical()
                  ?responsive.altoP(5)
                  :responsive.anchoP(5),
              responsive.isVertical()
                  ?responsive.altoP(5)
                  :responsive.anchoP(5),
            ),
            padding:const EdgeInsets.all(3),
            borderRadius:BorderRadius.circular(30),
            color:Colors.black26,
            onPressed:onPressed,
            child:Icon(
              Icons.search,
              color:Colors.white,
              size:responsive.isVertical()
                  ?responsive.altoP(3)
                  :responsive.anchoP(3),
            ),
          ),
        ),
      );
    }
  }

  class SearchWidget extends StatefulWidget {
    final ValueChanged<String>? onChangedBusqueda;
    final ValueChanged<bool> onChangedisSearching;
    final String? title;
    final bool isSearching;

    const SearchWidget({
      super.key,
      this.onChangedBusqueda,
      this.title,
      required this.isSearching,
      required this.onChangedisSearching,
    });

    @override
    _SearchWidgetState createState()=>_SearchWidgetState();
  }

  class _SearchWidgetState extends State<SearchWidget> {
    final TextEditingController _searchQueryController=TextEditingController();

    @override
    void dispose(){
      _searchQueryController.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context){
      if(widget.onChangedBusqueda==null)return getTitle();

      return Container(
        padding:const EdgeInsets.only(
          right:10,
          left:40,
        ),
        child:Row(
          mainAxisAlignment:MainAxisAlignment.center,
          children:[
            widget.isSearching
                ?Expanded(
              child:TextField(
                autofocus:true,
                controller:_searchQueryController,
                cursorColor:const Color(0xFF195496),
                onChanged:(value)=>widget.onChangedBusqueda?.call(value),
                style:const TextStyle(
                  color:Colors.black,
                ),
                decoration:InputDecoration(
                  hintText:"Buscar...",
                  hintStyle:const TextStyle(
                    color:Colors.black,
                  ),
                  enabledBorder:UnderlineInputBorder(
                    borderSide:BorderSide(
                      color:AppColors.colorPrimary,
                    ),
                  ),
                  focusedBorder:UnderlineInputBorder(
                    borderSide:BorderSide(
                      color:AppColors.colorPrimary,
                    ),
                  ),
                ),
              ),
            )
                :Expanded(
              child:getTitle(),
            ),
            if(widget.isSearching)
              IconButton(
                icon:const Icon(
                  Icons.close,
                  color:Colors.white,
                ),
                onPressed:(){
                  _searchQueryController.clear();
                  widget.onChangedBusqueda?.call("");
                  widget.onChangedisSearching(false);
                },
              ),
          ],
        ),
      );
    }

    Widget getTitle(){
      final responsive=ResponsiveUtil();

      return widget.title!=null
          ?TextSombrasWidget(
        colorTexto:AppColors.colorAmarilloTitle,
        colorSombra:Colors.black87,
        title:widget.title!,
        size:responsive.diagonalP(
          AppConfig.tamTextoTitulo+.6,
        ),
      )
          :Container();
    }
  }
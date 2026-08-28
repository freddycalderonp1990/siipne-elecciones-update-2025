import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/extension_api.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'package:siipnemovil2/app/core/utils/utilidadesUtil.dart';

import '../../../../../../app/core/utils/responsiveUtil.dart';
import '../../../../../../app/core/values/app_colors.dart';
import '../../../../../../app/presentation/widgets/custom_app_widgets.dart';
import '../../../../../app/core/app_config.dart';
import '../../../../../app/core/utils/photo_helper.dart';
import '../../../../../app/core/values/app_images.dart';
import '../../../../../feactures/mapas/openstreetmap.dart';
import '../../../../../feactures/mapas/widgets/custom_btn_map.dart';
import '../../../../../feactures/mapas/widgets/custom_marker.dart';
import '../../../../../feactures/user/presentation/modules/controllers.dart';
import '../../../../data/models/models.dart';
import '../../../widgets/customWidgets.dart';
import 'registrar_recinto_widget.dart';

class DesingMapaRecinto extends StatefulWidget {
  final LatLng ubicacion;
  final MapController mapController;
  final ValueChanged<LatLng> tapComplete;
  final VoidCallback? onPressedSave;
  final ValueChanged<RecintosElectoral>? onRecintoSeleccionado;
  final List<RecintosElectoral> listRecintosElectorales;
  final GestureTapCallback ontapMyUbicacion;
  final bool cargando;
  final bool showNoEncuentyroMiRecinto;

  const DesingMapaRecinto({
    super.key,
    required this.ubicacion,
    required this.mapController,
    required this.tapComplete,
    required this.ontapMyUbicacion,
    this.onPressedSave,
    this.cargando=false,
    required this.listRecintosElectorales,
    this.onRecintoSeleccionado,
    this.showNoEncuentyroMiRecinto=false,
  });

  @override
  State<DesingMapaRecinto> createState()=>_DesingMapaRecintoState();
}

class _DesingMapaRecintoState extends State<DesingMapaRecinto> {
  final _mapKey=GlobalKey();

  int? selectedIndex;
  RecintosElectoral? recintoSeleccionado;

  ScrollController? _internalScrollController;

  final PopupController _popupController=PopupController();
  final DraggableScrollableController _sheetController=DraggableScrollableController();

  bool tieneRecintoValidado=false;

  TipoMapa tipoMapaSeleccionado=TipoMapa.voyager;

  Rx<GaleryCameraModel?> mGaleryCameraModel=Rx<GaleryCameraModel?>(null);

  final controllerNombreRecinto=TextEditingController();
  final formKeyRegRecinto=GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
    _verificarRecintoValidado();
  }

  @override
  void didUpdateWidget(covariant DesingMapaRecinto oldWidget){
    super.didUpdateWidget(oldWidget);

    if(oldWidget.listRecintosElectorales!=widget.listRecintosElectorales){
      _verificarRecintoValidado();

      if(recintoSeleccionado!=null){
        final int index=widget.listRecintosElectorales.indexWhere(
              (item)=>item.idDgoReciElect==recintoSeleccionado!.idDgoReciElect,
        );

        if(index>=0){
          selectedIndex=index;
          recintoSeleccionado=widget.listRecintosElectorales[index];
        }else{
          selectedIndex=null;
          recintoSeleccionado=null;
          _popupController.hideAllPopups();
        }
      }
    }
  }

  @override
  void dispose(){
    _popupController.dispose();
    _sheetController.dispose();
    controllerNombreRecinto.dispose();
    super.dispose();
  }

  void _verificarRecintoValidado(){
    try{
      final loginController=Get.find<LoginController>();

      final String nameUser=loginController.user.value.nombres
          .replaceAll(RegExp(r'\s+'),'')
          .toUpperCase();

      tieneRecintoValidado=widget.listRecintosElectorales.any((recinto){
        if(!recinto.validado)return false;

        final String nameValida=recinto.apenomValida
            .replaceAll(RegExp(r'\s+'),'')
            .toUpperCase();

        return nameUser==nameValida;
      });
    }catch(e){
      tieneRecintoValidado=false;
    }
  }

  @override
  Widget build(BuildContext context){
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor:Color(0xFF123F75),
        statusBarIconBrightness:Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor:const Color(0xFFF3F6F9),
      body:Stack(
        children:[
          Positioned.fill(
            child:FlutterMap(
              key:_mapKey,
              mapController:widget.mapController,
              options:MapOptions(
                initialCenter:widget.ubicacion,
                initialZoom:18,
                minZoom:5,
                maxZoom:25,

                // IMPORTANTE:
                // tocar el mapa YA NO cambia widget.ubicacion
                onTap:(tapPosition,point){
                  _popupController.hideAllPopups();
                },
              ),
              children:[
                Openstreetmap.getMapa(
                  tipoMapa:tipoMapaSeleccionado,
                ),
                ...getMarkes(),
              ],
            ),
          ),

          _overlaySuperior(),

          _tituloMapa(),

          getBtnAtras(),

          getBotonera(),

          getReciontoDraggableScrollableSheet(),

          CargandoWidget(
            mostrar:widget.cargando,
          ),
        ],
      ),
    );
  }

  Widget _overlaySuperior(){
    return Positioned(
      top:0,
      left:0,
      right:0,
      height:110,
      child:IgnorePointer(
        child:Container(
          decoration:BoxDecoration(
            gradient:LinearGradient(
              begin:Alignment.topCenter,
              end:Alignment.bottomCenter,
              colors:[
                const Color(0xFF123F75).withOpacity(.84),
                const Color(0xFF17365D).withOpacity(.30),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tituloMapa(){
    final responsive=ResponsiveUtil();

    return Positioned(
      top:responsive.altoP(5.1),
      left:62,
      right:62,
      child:Column(
        children:[
          const Text(
            'VALIDAR RECINTO',
            textAlign:TextAlign.center,
            style:TextStyle(
              color:Colors.white,
              fontSize:14,
              fontWeight:FontWeight.w900,
              letterSpacing:.5,
              shadows:[
                Shadow(
                  color:Colors.black38,
                  blurRadius:4,
                ),
              ],
            ),
          ),

          const SizedBox(height:1),

          Text(
            '${widget.listRecintosElectorales.length} recintos disponibles',
            textAlign:TextAlign.center,
            style:TextStyle(
              color:Colors.white.withOpacity(.90),
              fontSize:8,
              fontWeight:FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget getReciontoDraggableScrollableSheet(){
    /*
      Antes:
        initial .43
        min .23
        max .66

      Ahora damos mayor espacio a la lista.
    */
    const double minChildSize=.34;
    const double initialChildSize=.56;
    const double maxChildSize=.78;

    /*
      Al seleccionar un recinto NO bajamos a .34.
      Lo dejamos en .44 para seguir viendo varios registros.
    */
    const double selectedChildSize=.44;

    return DraggableScrollableSheet(
      controller:_sheetController,
      initialChildSize:initialChildSize,
      minChildSize:minChildSize,
      maxChildSize:maxChildSize,
      snap:true,
      snapSizes:const [
        minChildSize,
        initialChildSize,
        maxChildSize,
      ],
      builder:(context,scrollController){
        final List<RecintosElectoral> listaOrdenada=_getListaOrdenada();

        _internalScrollController=scrollController;

        return Container(
          decoration:BoxDecoration(
            color:const Color(0xFFF7F9FB),
            borderRadius:const BorderRadius.vertical(
              top:Radius.circular(23),
            ),
            boxShadow:[
              BoxShadow(
                color:const Color(0xFF17365D).withOpacity(.18),
                blurRadius:18,
                offset:const Offset(0,-4),
              ),
            ],
          ),
          child:Column(
            children:[
              const SizedBox(height:6),

              Container(
                width:42,
                height:4,
                decoration:BoxDecoration(
                  color:const Color(0xFFB7C1CB),
                  borderRadius:BorderRadius.circular(20),
                ),
              ),

              const SizedBox(height:6),

              _cabeceraPanel(),

              const SizedBox(height:2),

              Expanded(
                child:listaOrdenada.isEmpty
                    ?_sinRecintos()
                    :ListView.builder(
                  controller:scrollController,
                  padding:const EdgeInsets.fromLTRB(
                    10,
                    2,
                    10,
                    5,
                  ),
                  itemCount:listaOrdenada.length,
                  itemBuilder:(context,index){
                    final RecintosElectoral recinto=
                    listaOrdenada[index];

                    final bool esSeleccionado=
                        recintoSeleccionado!=null&&
                            recinto.idDgoReciElect==
                                recintoSeleccionado!.idDgoReciElect;

                    return _itemRecinto(
                      recinto:recinto,
                      esSeleccionado:esSeleccionado,
                      esValidado:recinto.validado,
                      onTap:(){
                        _seleccionarRecinto(
                          recinto,
                          selectedChildSize,
                        );
                      },
                    );
                  },
                ),
              ),

              _botonGuardarInferior(),
            ],
          ),
        );
      },
    );
  }

  List<RecintosElectoral> _getListaOrdenada(){
    final List<RecintosElectoral> lista=
    List<RecintosElectoral>.from(
      widget.listRecintosElectorales,
    );

    if(recintoSeleccionado==null)return lista;

    final int index=lista.indexWhere(
          (item)=>item.idDgoReciElect==
          recintoSeleccionado!.idDgoReciElect,
    );

    if(index>0){
      final seleccionado=lista.removeAt(index);
      lista.insert(0,seleccionado);
    }

    return lista;
  }

  Future<void> _seleccionarRecinto(
      RecintosElectoral recinto,
      double selectedChildSize,
      ) async {
    final int originalIndex=
    widget.listRecintosElectorales.indexWhere(
          (item)=>item.idDgoReciElect==
          recinto.idDgoReciElect,
    );

    if(originalIndex<0)return;

    _popupController.hideAllPopups();

    setState((){
      selectedIndex=originalIndex;
      recintoSeleccionado=recinto;
    });

    final point=LatLng(
      recinto.latitud,
      recinto.longitud,
    );

    ajustarMapaParaVerAmbos(point);

    await Future.delayed(
      const Duration(milliseconds:80),
    );

    if(_internalScrollController!=null&&
        _internalScrollController!.hasClients){
      await _internalScrollController!.animateTo(
        0,
        duration:const Duration(milliseconds:220),
        curve:Curves.easeOut,
      );
    }

    /*
      Ya NO colapsamos al minChildSize.
      Se conserva suficiente altura para visualizar la lista.
    */
    if(_sheetController.isAttached){
      await _sheetController.animateTo(
        selectedChildSize,
        duration:const Duration(milliseconds:280),
        curve:Curves.easeInOut,
      );
    }

    widget.onRecintoSeleccionado?.call(recinto);
  }

  Widget _cabeceraPanel(){
    return Padding(
      padding:const EdgeInsets.symmetric(
        horizontal:11,
      ),
      child:Row(
        children:[
          Container(
            width:34,
            height:34,
            decoration:BoxDecoration(
              color:const Color(0xFFEAF1F8),
              borderRadius:BorderRadius.circular(10),
            ),
            child:const Icon(
              Icons.location_city_outlined,
              color:Color(0xFF195496),
              size:17,
            ),
          ),

          const SizedBox(width:8),

          Expanded(
            child:Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children:[
                const Text(
                  'Seleccione un recinto',
                  style:TextStyle(
                    color:Color(0xFF17365D),
                    fontSize:11,
                    fontWeight:FontWeight.w900,
                  ),
                ),

                const SizedBox(height:1),

                Text(
                  'Toque un recinto para visualizarlo en el mapa',
                  style:TextStyle(
                    color:const Color(0xFF7A8998),
                    fontSize:7.5,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding:const EdgeInsets.symmetric(
              horizontal:7,
              vertical:4,
            ),
            decoration:BoxDecoration(
              color:const Color(0xFFEAF1F8),
              borderRadius:BorderRadius.circular(20),
            ),
            child:Text(
              '${widget.listRecintosElectorales.length}',
              style:const TextStyle(
                color:Color(0xFF195496),
                fontSize:8,
                fontWeight:FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sinRecintos(){
    return const Center(
      child:Column(
        mainAxisSize:MainAxisSize.min,
        children:[
          Icon(
            Icons.location_off_outlined,
            color:Color(0xFF8997A5),
            size:28,
          ),
          SizedBox(height:6),
          Text(
            'No existen recintos disponibles',
            style:TextStyle(
              color:Color(0xFF17365D),
              fontSize:9.5,
              fontWeight:FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemRecinto({
    required RecintosElectoral recinto,
    required bool esSeleccionado,
    required bool esValidado,
    required VoidCallback onTap,
  }){
    final Color colorEstado=
    esSeleccionado
        ?const Color(0xFF195496)
        :esValidado
        ?const Color(0xFF218A61)
        :const Color(0xFF718294);

    return Padding(
      padding:const EdgeInsets.symmetric(
        vertical:3,
      ),
      child:Material(
        color:Colors.transparent,
        borderRadius:BorderRadius.circular(13),
        clipBehavior:Clip.antiAlias,
        child:InkWell(
          onTap:onTap,
          splashColor:colorEstado.withOpacity(.08),
          child:Ink(
            padding:const EdgeInsets.symmetric(
              horizontal:8,
              vertical:7,
            ),
            decoration:BoxDecoration(
              color:esSeleccionado
                  ?const Color(0xFFF0F5FB)
                  :Colors.white,
              borderRadius:BorderRadius.circular(13),
              border:Border.all(
                color:esSeleccionado
                    ?const Color(0xFF195496).withOpacity(.38)
                    :esValidado
                    ?const Color(0xFF218A61).withOpacity(.25)
                    :const Color(0xFFE1E7ED),
                width:esSeleccionado?1.3:1,
              ),
            ),
            child:Row(
              children:[
                Container(
                  width:36,
                  height:36,
                  alignment:Alignment.center,
                  decoration:BoxDecoration(
                    color:colorEstado.withOpacity(.10),
                    borderRadius:BorderRadius.circular(10),
                  ),
                  child:Icon(
                    esSeleccionado
                        ?Icons.check_circle_rounded
                        :esValidado
                        ?Icons.verified_rounded
                        :Icons.location_city_outlined,
                    color:colorEstado,
                    size:18,
                  ),
                ),

                const SizedBox(width:8),

                Expanded(
                  child:Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children:[
                      Text(
                        recinto.nomRecintoElecOnly,
                        maxLines:2,
                        overflow:TextOverflow.ellipsis,
                        style:const TextStyle(
                          color:Color(0xFF17365D),
                          fontSize:9.8,
                          fontWeight:FontWeight.w800,
                          height:1.08,
                        ),
                      ),

                      const SizedBox(height:3),

                      Row(
                        children:[
                          const Icon(
                            Icons.near_me_outlined,
                            color:Color(0xFF7A8998),
                            size:10,
                          ),

                          const SizedBox(width:3),

                          Text(
                            '${recinto.distance} m',
                            style:const TextStyle(
                              color:Color(0xFF68798A),
                              fontSize:7.2,
                              fontWeight:FontWeight.w600,
                            ),
                          ),

                          if(esValidado)...[
                            const SizedBox(width:6),

                            Container(
                              padding:const EdgeInsets.symmetric(
                                horizontal:5,
                                vertical:2,
                              ),
                              decoration:BoxDecoration(
                                color:const Color(0xFFE7F5EE),
                                borderRadius:BorderRadius.circular(20),
                              ),
                              child:const Text(
                                'VALIDADO',
                                style:TextStyle(
                                  color:Color(0xFF218A61),
                                  fontSize:5.9,
                                  fontWeight:FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),

                      if(esValidado&&
                          recinto.apenomValida.isNotEmpty)...[
                        const SizedBox(height:2),

                        Text(
                          'Valida: ${recinto.apenomValida}',
                          maxLines:1,
                          overflow:TextOverflow.ellipsis,
                          style:const TextStyle(
                            color:Color(0xFF218A61),
                            fontSize:6.8,
                            fontWeight:FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(width:4),

                Icon(
                  esSeleccionado
                      ?Icons.check_circle_rounded
                      :Icons.chevron_right_rounded,
                  color:esSeleccionado
                      ?const Color(0xFF195496)
                      :const Color(0xFF9AA7B4),
                  size:18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _botonGuardarInferior(){
    final bool habilitado=
        selectedIndex!=null&&
            recintoSeleccionado!=null;

    return Container(
      width:double.infinity,
      padding:const EdgeInsets.fromLTRB(
        10,
        6,
        10,
        9,
      ),
      decoration:const BoxDecoration(
        color:Color(0xFFF7F9FB),
        border:Border(
          top:BorderSide(
            color:Color(0xFFE1E7ED),
          ),
        ),
      ),
      child:Opacity(
        opacity:habilitado?1:.38,
        child:IgnorePointer(
          ignoring:!habilitado,
          child:Center(
            child:SizedBox(
              width:210,
              child:_botonGuardar(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _botonGuardar(){
    return Material(
      color:Colors.transparent,
      borderRadius:BorderRadius.circular(13),
      clipBehavior:Clip.antiAlias,
      child:InkWell(
        onTap:_validarAntesDeGuardar,
        child:Ink(
          height:45,
          decoration:BoxDecoration(
            gradient:const LinearGradient(
              begin:Alignment.centerLeft,
              end:Alignment.centerRight,
              colors:[
                Color(0xFF123F75),
                Color(0xFF195496),
                Color(0xFF2869AC),
              ],
            ),
            borderRadius:BorderRadius.circular(13),
            boxShadow:[
              BoxShadow(
                color:const Color(0xFF195496).withOpacity(.20),
                blurRadius:8,
                offset:const Offset(0,3),
              ),
            ],
          ),
          child:const Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children:[
              Icon(
                Icons.verified_outlined,
                color:Colors.white,
                size:17,
              ),
              SizedBox(width:7),
              Text(
                'VALIDAR RECINTO',
                style:TextStyle(
                  color:Colors.white,
                  fontSize:9.5,
                  fontWeight:FontWeight.w900,
                  letterSpacing:.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validarAntesDeGuardar(){
    if(recintoSeleccionado==null)return;

    if(tieneRecintoValidado){
      DialogosAwesome.getWarning(
        descripcion:
        "Usted ya ha validado un recinto. Si desea realizar el proceso nuevamente, por favor comuníquese con Talento Humano para habilitar su validación.",
      );
      return;
    }

    String msj=
        "Asegúrese de encontrarse exactamente en el lugar del recinto electoral."
        "\n\n[azul]Este registro será utilizado en el proceso electoral y será[/azul] [rojo]AUDITADO[/rojo][azul], siendo usted responsable de la información ingresada.[/azul]"
        "\n\nUn registro incorrecto podría generar inconvenientes el día de las elecciones."
        "\n\n¿Está seguro/a de registrar la ubicación actual?";

    if(recintoSeleccionado!.validado){
      msj=
      "El recinto ya fue validado por ${recintoSeleccionado!.apenomValida}."
          "\n\nAsegúrese de encontrarse en el lugar correcto."
          "\nEste cambio quedará AUDITADO y será su responsabilidad."
          "\nUna validación incorrecta podría generar inconvenientes el día de las elecciones."
          "\n\n¿Desea reemplazar la ubicación actual y validarlo nuevamente?";
    }

    DialogosAwesome.getWarningSiNoContador(
      title:
      "Validar Recinto Electoral \n ${recintoSeleccionado!.nomRecintoElecOnly}",
      descripcion:msj,
      btnOkOnPress:widget.onPressedSave,
    );
  }

  List<Widget> getMarkes(){
    final List<Marker> markersRecinto=[];

    if(recintoSeleccionado!=null){
      final recinto=recintoSeleccionado!;

      late Marker marker;

      marker=Marker(
        key:ValueKey(recinto),
        point:LatLng(
          recinto.latitud,
          recinto.longitud,
        ),
        width:70,
        height:70,
        alignment:Alignment.bottomCenter,
        child:GestureDetector(
          behavior:HitTestBehavior.opaque,
          onTap:(){
            _popupController.showPopupsOnlyFor(
              [marker],
            );
          },
          child:_markerRecinto(
            validado:recinto.validado,
          ),
        ),
      );

      markersRecinto.add(marker);
    }

    return[
      MarkerLayer(
        markers:[
          Marker(
            key:const ValueKey('ubicacion_usuario'),
            point:widget.ubicacion,
            width:60,
            height:60,
            child:_markerUsuario(),
          ),
        ],
      ),

      PopupMarkerLayer(
        options:PopupMarkerLayerOptions(
          popupController:_popupController,
          markers:markersRecinto,
          popupDisplayOptions:PopupDisplayOptions(
            builder:(context,marker){
              final valueKey=marker.key;

              if(valueKey is! ValueKey){
                return const SizedBox.shrink();
              }

              final value=valueKey.value;

              if(value is! RecintosElectoral){
                return const SizedBox.shrink();
              }

              return _popupRecinto(value);
            },
          ),
        ),
      ),
    ];
  }

  Widget _markerUsuario(){
    return GestureDetector(
      onTap:widget.ontapMyUbicacion,
      child:Stack(
        alignment:Alignment.center,
        children:[
          Container(
            width:52,
            height:52,
            decoration:BoxDecoration(
              color:const Color(0xFF195496).withOpacity(.12),
              shape:BoxShape.circle,
              border:Border.all(
                color:const Color(0xFF195496).withOpacity(.18),
              ),
            ),
          ),

          Container(
            width:31,
            height:31,
            decoration:BoxDecoration(
              color:const Color(0xFF195496),
              shape:BoxShape.circle,
              border:Border.all(
                color:Colors.white,
                width:3,
              ),
              boxShadow:[
                BoxShadow(
                  color:Colors.black.withOpacity(.22),
                  blurRadius:7,
                  offset:const Offset(0,2),
                ),
              ],
            ),
            child:const Icon(
              Icons.person_rounded,
              color:Colors.white,
              size:15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _markerRecinto({
    required bool validado,
  }){
    final Color color=
    validado
        ?const Color(0xFF218A61)
        :const Color(0xFF17365D);

    return Column(
      mainAxisSize:MainAxisSize.min,
      children:[
        Container(
          width:43,
          height:43,
          decoration:BoxDecoration(
            color:color,
            shape:BoxShape.circle,
            border:Border.all(
              color:Colors.white,
              width:3,
            ),
            boxShadow:[
              BoxShadow(
                color:Colors.black.withOpacity(.25),
                blurRadius:8,
                offset:const Offset(0,3),
              ),
            ],
          ),
          child:Icon(
            validado
                ?Icons.verified_rounded
                :Icons.location_city_rounded,
            color:Colors.white,
            size:20,
          ),
        ),

        Container(
          width:3,
          height:9,
          decoration:BoxDecoration(
            color:color,
            borderRadius:BorderRadius.circular(3),
          ),
        ),
      ],
    );
  }

  Widget _popupRecinto(
      RecintosElectoral recinto,
      ){
    return Container(
      width:235,
      padding:const EdgeInsets.all(11),
      decoration:BoxDecoration(
        color:Colors.white,
        borderRadius:BorderRadius.circular(16),
        border:Border.all(
          color:const Color(0xFFDCE4EC),
        ),
        boxShadow:[
          BoxShadow(
            color:Colors.black.withOpacity(.18),
            blurRadius:14,
            offset:const Offset(0,5),
          ),
        ],
      ),
      child:Column(
        mainAxisSize:MainAxisSize.min,
        crossAxisAlignment:CrossAxisAlignment.start,
        children:[
          Row(
            children:[
              Container(
                width:35,
                height:35,
                decoration:BoxDecoration(
                  color:recinto.validado
                      ?const Color(0xFFE7F5EE)
                      :const Color(0xFFEAF1F8),
                  borderRadius:BorderRadius.circular(10),
                ),
                child:Icon(
                  recinto.validado
                      ?Icons.verified_rounded
                      :Icons.location_city_outlined,
                  color:recinto.validado
                      ?const Color(0xFF218A61)
                      :const Color(0xFF195496),
                  size:18,
                ),
              ),

              const SizedBox(width:8),

              Expanded(
                child:Text(
                  recinto.nomRecintoElecOnly,
                  maxLines:3,
                  overflow:TextOverflow.ellipsis,
                  style:const TextStyle(
                    color:Color(0xFF17365D),
                    fontSize:10,
                    fontWeight:FontWeight.w900,
                    height:1.12,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height:8),

          Container(
            height:1,
            color:const Color(0xFFE5EAF0),
          ),

          const SizedBox(height:8),

          Row(
            children:[
              const Icon(
                Icons.near_me_outlined,
                color:Color(0xFF7A8998),
                size:13,
              ),
              const SizedBox(width:5),
              Text(
                'Distancia: ${recinto.distance} m',
                style:const TextStyle(
                  color:Color(0xFF68798A),
                  fontSize:8.2,
                  fontWeight:FontWeight.w600,
                ),
              ),
            ],
          ),

          if(recinto.validado)...[
            const SizedBox(height:7),

            Container(
              padding:const EdgeInsets.symmetric(
                horizontal:7,
                vertical:4,
              ),
              decoration:BoxDecoration(
                color:const Color(0xFFE7F5EE),
                borderRadius:BorderRadius.circular(20),
              ),
              child:const Row(
                mainAxisSize:MainAxisSize.min,
                children:[
                  Icon(
                    Icons.verified_rounded,
                    color:Color(0xFF218A61),
                    size:11,
                  ),
                  SizedBox(width:4),
                  Text(
                    'RECINTO VALIDADO',
                    style:TextStyle(
                      color:Color(0xFF218A61),
                      fontSize:6.5,
                      fontWeight:FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),

            if(recinto.apenomValida.isNotEmpty)...[
              const SizedBox(height:5),

              Text(
                'Validado por: ${recinto.apenomValida}',
                maxLines:2,
                overflow:TextOverflow.ellipsis,
                style:const TextStyle(
                  color:Color(0xFF68798A),
                  fontSize:7.5,
                  fontWeight:FontWeight.w600,
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }

  Widget getBotonera(){
    final responsive=ResponsiveUtil();

    return Positioned(
      top:responsive.altoP(13),
      right:10,
      child:Container(
        decoration:BoxDecoration(
          color:Colors.white.withOpacity(.96),
          borderRadius:BorderRadius.circular(14),
          boxShadow:[
            BoxShadow(
              color:Colors.black.withOpacity(.14),
              blurRadius:10,
              offset:const Offset(0,3),
            ),
          ],
        ),
        child:Column(
          children:[
            _mapBtn(
              icon:Icons.my_location_rounded,
              tooltip:'Mi ubicación',
              onTap:widget.ontapMyUbicacion,
            ),

            _separadorMapa(),

            _mapBtn(
              icon:Icons.layers_outlined,
              tooltip:'Cambiar mapa',
              activo:true,
              onTap:_mostrarSelectorMapa,
            ),

            _separadorMapa(),

            _mapBtn(
              icon:Icons.add_rounded,
              tooltip:'Acercar',
              onTap:(){
                final zoomActual=
                    widget.mapController.camera.zoom;

                if(zoomActual<25){
                  widget.mapController.move(
                    widget.mapController.camera.center,
                    zoomActual+1,
                  );
                }
              },
            ),

            _separadorMapa(),

            _mapBtn(
              icon:Icons.remove_rounded,
              tooltip:'Alejar',
              onTap:(){
                final zoomActual=
                    widget.mapController.camera.zoom;

                if(zoomActual>5){
                  widget.mapController.move(
                    widget.mapController.camera.center,
                    zoomActual-1,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _mapBtn({
    required IconData icon,
    required GestureTapCallback onTap,
    String? tooltip,
    bool activo=false,
  }){
    Widget boton=InkWell(
      onTap:onTap,
      child:SizedBox(
        width:43,
        height:43,
        child:Icon(
          icon,
          color:activo
              ?const Color(0xFF195496)
              :const Color(0xFF52677B),
          size:19,
        ),
      ),
    );

    if(tooltip!=null){
      boton=Tooltip(
        message:tooltip,
        child:boton,
      );
    }

    return boton;
  }

  Widget _separadorMapa(){
    return Container(
      width:27,
      height:1,
      color:const Color(0xFFE1E7ED),
    );
  }

  void _mostrarSelectorMapa(){
    _popupController.hideAllPopups();

    showModalBottomSheet(
      context:context,
      backgroundColor:Colors.transparent,
      isScrollControlled:false,
      builder:(context){
        return StatefulBuilder(
          builder:(context,setModalState){
            return Container(
              padding:const EdgeInsets.fromLTRB(
                14,
                10,
                14,
                20,
              ),
              decoration:const BoxDecoration(
                color:Color(0xFFF7F9FB),
                borderRadius:BorderRadius.vertical(
                  top:Radius.circular(26),
                ),
              ),
              child:SafeArea(
                top:false,
                child:Column(
                  mainAxisSize:MainAxisSize.min,
                  children:[
                    Container(
                      width:42,
                      height:4,
                      decoration:BoxDecoration(
                        color:const Color(0xFFB8C1CB),
                        borderRadius:BorderRadius.circular(20),
                      ),
                    ),

                    const SizedBox(height:13),

                    const Row(
                      children:[
                        Icon(
                          Icons.layers_outlined,
                          color:Color(0xFF195496),
                          size:22,
                        ),
                        SizedBox(width:8),
                        Expanded(
                          child:Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children:[
                              Text(
                                'TIPO DE MAPA',
                                style:TextStyle(
                                  color:Color(0xFF17365D),
                                  fontSize:12.5,
                                  fontWeight:FontWeight.w900,
                                ),
                              ),
                              SizedBox(height:2),
                              Text(
                                'Seleccione la visualización que desea utilizar',
                                style:TextStyle(
                                  color:Color(0xFF7A8998),
                                  fontSize:8.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height:13),

                    _opcionTipoMapa(
                      tipo:TipoMapa.voyager,
                      titulo:'Voyager',
                      descripcion:'Equilibrado y detallado',
                      icon:Icons.public_rounded,
                      setModalState:setModalState,
                    ),

                    _opcionTipoMapa(
                      tipo:TipoMapa.claro,
                      titulo:'Claro',
                      descripcion:'Vista limpia y minimalista',
                      icon:Icons.light_mode_outlined,
                      setModalState:setModalState,
                    ),

                    _opcionTipoMapa(
                      tipo:TipoMapa.openStreetMap,
                      titulo:'OpenStreetMap',
                      descripcion:'Vista tradicional con mayor detalle',
                      icon:Icons.map_outlined,
                      setModalState:setModalState,
                    ),

                    _opcionTipoMapa(
                      tipo:TipoMapa.oscuro,
                      titulo:'Oscuro',
                      descripcion:'Mayor contraste para uso nocturno',
                      icon:Icons.dark_mode_outlined,
                      setModalState:setModalState,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _opcionTipoMapa({
    required TipoMapa tipo,
    required String titulo,
    required String descripcion,
    required IconData icon,
    required StateSetter setModalState,
  }){
    final bool seleccionado=
        tipoMapaSeleccionado==tipo;

    return Padding(
      padding:const EdgeInsets.only(
        bottom:8,
      ),
      child:Material(
        color:Colors.transparent,
        borderRadius:BorderRadius.circular(14),
        clipBehavior:Clip.antiAlias,
        child:InkWell(
          onTap:(){
            setState((){
              tipoMapaSeleccionado=tipo;
            });

            setModalState((){});

            Future.delayed(
              const Duration(milliseconds:100),
                  (){
                if(mounted&&Navigator.of(context).canPop()){
                  Navigator.of(context).pop();
                }
              },
            );
          },
          child:Ink(
            padding:const EdgeInsets.all(10),
            decoration:BoxDecoration(
              color:seleccionado
                  ?const Color(0xFFEAF1F8)
                  :Colors.white,
              borderRadius:BorderRadius.circular(14),
              border:Border.all(
                color:seleccionado
                    ?const Color(0xFF195496).withOpacity(.40)
                    :const Color(0xFFE1E7ED),
                width:seleccionado?1.3:1,
              ),
            ),
            child:Row(
              children:[
                Container(
                  width:39,
                  height:39,
                  decoration:BoxDecoration(
                    color:seleccionado
                        ?const Color(0xFF195496)
                        :const Color(0xFFF0F3F6),
                    borderRadius:BorderRadius.circular(11),
                  ),
                  child:Icon(
                    icon,
                    color:seleccionado
                        ?Colors.white
                        :const Color(0xFF667788),
                    size:19,
                  ),
                ),

                const SizedBox(width:9),

                Expanded(
                  child:Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children:[
                      Text(
                        titulo,
                        style:TextStyle(
                          color:const Color(0xFF17365D),
                          fontSize:10.5,
                          fontWeight:seleccionado
                              ?FontWeight.w900
                              :FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height:2),

                      Text(
                        descripcion,
                        style:const TextStyle(
                          color:Color(0xFF7A8998),
                          fontSize:7.8,
                        ),
                      ),
                    ],
                  ),
                ),

                Icon(
                  seleccionado
                      ?Icons.radio_button_checked_rounded
                      :Icons.radio_button_off_rounded,
                  color:seleccionado
                      ?const Color(0xFF195496)
                      :const Color(0xFFB1BBC5),
                  size:20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getBtnAtras(){
    final responsive=ResponsiveUtil();

    return Positioned(
      top:responsive.altoP(5),
      left:10,
      child:Material(
        color:Colors.transparent,
        borderRadius:BorderRadius.circular(13),
        clipBehavior:Clip.antiAlias,
        child:InkWell(
          onTap:(){
            Get.back();
          },
          child:Ink(
            width:43,
            height:43,
            decoration:BoxDecoration(
              color:Colors.white.withOpacity(.96),
              borderRadius:BorderRadius.circular(13),
              boxShadow:[
                BoxShadow(
                  color:Colors.black.withOpacity(.14),
                  blurRadius:10,
                  offset:const Offset(0,3),
                ),
              ],
            ),
            child:const Icon(
              Icons.arrow_back_ios_new_rounded,
              color:Color(0xFF195496),
              size:18,
            ),
          ),
        ),
      ),
    );
  }

  void ajustarMapaParaVerAmbos(
      LatLng destino,
      ){
    final bounds=LatLngBounds.fromPoints([
      widget.ubicacion,
      destino,
    ]);

    widget.mapController.fitCamera(
      CameraFit.bounds(
        bounds:bounds,

        /*
          Menos padding inferior que antes porque
          ahora el panel no se colapsa tanto.
        */
        padding:const EdgeInsets.fromLTRB(
          45,
          105,
          45,
          190,
        ),
      ),
    );
  }

  Widget wgFoto(){
    final responsive=ResponsiveUtil();

    return Obx((){
      return Column(
        children:[
          mGaleryCameraModel.value==null
              ?TituloTextWidget(
            title:"Registrar una Imagen",
          )
              :TituloTextWidget(
            title:"Cambiar la Imagen",
          ),

          SizedBox(
            height:responsive.altoP(1),
          ),

          InkWell(
            onTap:() async {
              final ahora=DateTime.now();

              String dosDigitos(int n)=>
                  n.toString().padLeft(2,'0');

              String nameRecintoImg=
                  "ImgRecinto_${ahora.year}"
                  "${dosDigitos(ahora.month)}"
                  "${dosDigitos(ahora.day)}_"
                  "${dosDigitos(ahora.hour)}"
                  "${dosDigitos(ahora.minute)}"
                  "${dosDigitos(ahora.second)}.jpg";

              mGaleryCameraModel.value=
              await PhotoHelper
                  .getDesingPictureGaleryOrCamera(
                titleImg:nameRecintoImg,
                initPeticion:(value){},
              );
            },
            child:Image.asset(
              AppImages.icon_camara,
              width:responsive.altoP(6),
            ),
          ),

          if(mGaleryCameraModel.value!=null)
            ClipRRect(
              borderRadius:BorderRadius.circular(25),
              child:Image.file(
                mGaleryCameraModel.value!.imageFile,
                fit:BoxFit.fill,
                height:responsive.altoP(30),
                width:responsive.altoP(34),
              ),
            ),
        ],
      );
    });
  }

  Widget getTextLatLongitud(){
    final responsive=ResponsiveUtil();

    return Container(
      width:responsive.anchoP(100),
      color:Colors.transparent,
      child:TextSombrasWidget(
        colorSombra:Colors.white,
        title:
        "Latitud: ${UtilidadesUtil.redondearDouble(widget.ubicacion.latitude,decimales:6)} - Longitud: ${UtilidadesUtil.redondearDouble(widget.ubicacion.longitude,decimales:6)}",
      ),
    );
  }

  void desingRegistrarRecinto(){
    DialogosDesingWidget.getDialogoX(
      title:"Nuevo Recinto",
      contenido:RegistrarRecintoWidget(
        formKey:formKeyRegRecinto,
        controllerNombreRecinto:controllerNombreRecinto,
        foto:mGaleryCameraModel,
        onGuardar:(){
          ///Guardar recinto
        },
      ),
    );
  }
}
part of '../pages.dart';

class TiposServiciosEjesPage extends GetView<TiposServiciosEjesController> {
  const TiposServiciosEjesPage({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(
      title:"OPERATIVO:\n${controller.selectProcesoOperativoController.selectProcesosOperativo.value.descProcElecc}",
      tamanoTitulo:16,
      mostrarBtnAtras:true,
      mostrarDatosServidor:true,
      imgPerfil:controller.user.foto,
      nombresServidor:controller.user.nombres?.toString(),
      sexoServidor:controller.user.sexo?.toString(),
      contenido:getContenido(),
      peticionServer:controller.peticionServerState,
    );
  }

  Widget getContenido() {
    final responsive=ResponsiveUtil();

    return SingleChildScrollView(
      physics:const AlwaysScrollableScrollPhysics(),
      padding:const EdgeInsets.fromLTRB(8,6,8,20),
      child:Column(
        crossAxisAlignment:CrossAxisAlignment.stretch,
        children:[
          _cabeceraServicios(),
          SizedBox(height:responsive.altoP(1.2)),
          _getMenu(responsive),
        ],
      ),
    );
  }

  Widget _cabeceraServicios() {
    return Container(
      width:double.infinity,
      padding:const EdgeInsets.fromLTRB(11,10,11,10),
      decoration:BoxDecoration(
        color:Colors.white.withOpacity(.96),
        borderRadius:BorderRadius.circular(16),
        border:Border.all(color:const Color(0xFF195496).withOpacity(.09)),
        boxShadow:[
          BoxShadow(
            color:const Color(0xFF17365D).withOpacity(.06),
            blurRadius:13,
            offset:const Offset(0,4),
          ),
        ],
      ),
      child:Row(
        children:[
          Container(
            width:42,
            height:42,
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
              borderRadius:BorderRadius.circular(12),
            ),
            child:const Icon(
              Icons.account_tree_outlined,
              color:Colors.white,
              size:21,
            ),
          ),
          const SizedBox(width:10),
          const Expanded(
            child:Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children:[
                Text(
                  'TIPO DE SERVICIO',
                  style:TextStyle(
                    color:Color(0xFF195496),
                    fontSize:7.5,
                    fontWeight:FontWeight.w900,
                    letterSpacing:.8,
                  ),
                ),
                SizedBox(height:3),
                Text(
                  'Seleccione el servicio al que fue designado',
                  style:TextStyle(
                    color:Color(0xFF17365D),
                    fontSize:12.5,
                    fontWeight:FontWeight.w800,
                    height:1.12,
                  ),
                ),
                SizedBox(height:2),
                Text(
                  'Los servicios disponibles dependen del operativo seleccionado',
                  style:TextStyle(
                    color:Color(0xFF7A8998),
                    fontSize:8.2,
                    height:1.15,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width:7),
          Container(
            width:31,
            height:31,
            decoration:const BoxDecoration(
              color:Color(0xFFEAF1F8),
              borderRadius:BorderRadius.all(Radius.circular(9)),
            ),
            child:const Icon(
              Icons.touch_app_outlined,
              color:Color(0xFF195496),
              size:17,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getMenu(ResponsiveUtil responsive) {
    return Obx((){
      final List<Widget> botones=[];

      if(controller.tipoEjesActivos.value.tipoEjeRecintos){
        botones.add(
          _moduloServicio(
            img:SiipneEleccionesImages.icon_abrir_rec_elec,
            title:'RECINTOS',
            subtitle:'Recintos electorales',
            icon:Icons.location_city_outlined,
            color:const Color(0xFF195496),
            colorSuave:const Color(0xFFEAF1F8),
            onTap:(){
              Get.toNamed(EleccionesRoutes.CREAR_CODIGO_RECINTOS);
            },
          ),
        );
      }

      if(controller.tipoEjesActivos.value.tipoEjeUnidadesPoliciales){
        botones.add(
          _moduloServicio(
            img:SiipneEleccionesImages.icon_unidades_policiales,
            title:SiipneStrings.UNIDADESPOLICIALES,
            subtitle:'Unidades policiales',
            icon:Icons.local_police_outlined,
            color:const Color(0xFF195496),
            colorSuave:const Color(0xFFEAF1F8),
            onTap:(){
              Get.toNamed(EleccionesRoutes.CREAR_CODIGO_UNIDADES_POLI);
            },
          ),
        );
      }

      if(controller.tipoEjesActivos.value.tipoEjeOtros){
        botones.add(
          _moduloServicio(
            img:SiipneEleccionesImages.icon_registrar_novedades_rec_elec,
            title:'OTROS',
            subtitle:'Otros servicios',
            icon:Icons.dashboard_customize_outlined,
            color:const Color(0xFF5C7085),
            colorSuave:const Color(0xFFF0F3F6),
            onTap:(){},
          ),
        );
      }

      if(controller.selectProcesoOperativoController.selectProcesosOperativo.value.validarRecinto){
        botones.add(
          _moduloServicio(
            img:SiipneEleccionesImages.ic_validar_recinto,
            title:SiipneStrings.VALIDAR_RECINTO,
            subtitle:'Validar recinto',
            icon:Icons.verified_outlined,
            color:const Color(0xFF218A61),
            colorSuave:const Color(0xFFEAF5EF),
            onTap:()=>Get.toNamed(
              EleccionesRoutes.VALIDAR_RECINTO,
              arguments:{
                "selectProcesosOperativo":controller.selectProcesoOperativoController.selectProcesosOperativo.value,
              },
            ),
          ),
        );
      }

      return _gridBotones(botones);
    });
  }

  Widget _gridBotones(List<Widget> botones) {
    if(botones.isEmpty){
      return _sinServicios();
    }

    return LayoutBuilder(
      builder:(context,constraints){
        const double separacionHorizontal=10;
        const double separacionVertical=10;

        final double anchoBoton=(constraints.maxWidth-separacionHorizontal)/2;
        final List<Widget> filas=[];

        for(int i=0;i<botones.length;i+=2){
          final bool tieneSegundo=i+1<botones.length;

          if(tieneSegundo){
            filas.add(
              Row(
                crossAxisAlignment:CrossAxisAlignment.start,
                children:[
                  SizedBox(
                    width:anchoBoton,
                    child:botones[i],
                  ),
                  const SizedBox(width:separacionHorizontal),
                  SizedBox(
                    width:anchoBoton,
                    child:botones[i+1],
                  ),
                ],
              ),
            );
          }else{
            filas.add(
              Center(
                child:SizedBox(
                  width:anchoBoton,
                  child:botones[i],
                ),
              ),
            );
          }

          if(i+2<botones.length){
            filas.add(
              const SizedBox(height:separacionVertical),
            );
          }
        }

        return Column(
          children:filas,
        );
      },
    );
  }

  Widget _moduloServicio({
    required String img,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Color colorSuave,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration:BoxDecoration(
        borderRadius:BorderRadius.circular(17),
        boxShadow:[
          BoxShadow(
            color:const Color(0xFF17365D).withOpacity(.07),
            blurRadius:13,
            offset:const Offset(0,5),
          ),
        ],
      ),
      child:Material(
        color:Colors.transparent,
        borderRadius:BorderRadius.circular(17),
        clipBehavior:Clip.antiAlias,
        child:InkWell(
          onTap:onTap,
          splashColor:color.withOpacity(.08),
          highlightColor:color.withOpacity(.03),
          child:Ink(
            height:148,
            decoration:BoxDecoration(
              color:Colors.white.withOpacity(.97),
              borderRadius:BorderRadius.circular(17),
              border:Border.all(
                color:color.withOpacity(.13),
              ),
            ),
            child:Stack(
              children:[
                Positioned(
                  right:-35,
                  top:-35,
                  child:Container(
                    width:98,
                    height:98,
                    decoration:BoxDecoration(
                      shape:BoxShape.circle,
                      color:color.withOpacity(.045),
                    ),
                  ),
                ),
                Padding(
                  padding:const EdgeInsets.fromLTRB(10,10,10,10),
                  child:Column(
                    crossAxisAlignment:CrossAxisAlignment.center,
                    children:[
                      Row(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        children:[
                          Container(
                            padding:const EdgeInsets.symmetric(
                              horizontal:6,
                              vertical:3,
                            ),
                            decoration:BoxDecoration(
                              color:colorSuave,
                              borderRadius:BorderRadius.circular(20),
                            ),
                            child:Text(
                              'SERVICIO',
                              style:TextStyle(
                                color:color,
                                fontSize:6.3,
                                fontWeight:FontWeight.w900,
                                letterSpacing:.7,
                              ),
                            ),
                          ),
                          Container(
                            width:27,
                            height:27,
                            decoration:BoxDecoration(
                              color:color,
                              borderRadius:BorderRadius.circular(8),
                              boxShadow:[
                                BoxShadow(
                                  color:color.withOpacity(.20),
                                  blurRadius:7,
                                  offset:const Offset(0,2),
                                ),
                              ],
                            ),
                            child:const Icon(
                              Icons.arrow_forward_rounded,
                              color:Colors.white,
                              size:14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height:4),
                      Expanded(
                        child:Container(
                          width:64,
                          padding:const EdgeInsets.all(7),
                          decoration:BoxDecoration(
                            color:colorSuave,
                            borderRadius:BorderRadius.circular(14),
                            border:Border.all(
                              color:color.withOpacity(.08),
                            ),
                          ),
                          child:Image.asset(
                            img,
                            fit:BoxFit.contain,
                            errorBuilder:(context,error,stackTrace)=>Icon(
                              icon,
                              color:color,
                              size:30,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height:6),
                      Text(
                        title,
                        textAlign:TextAlign.center,
                        maxLines:2,
                        softWrap:true,
                        overflow:TextOverflow.ellipsis,
                        style:const TextStyle(
                          color:Color(0xFF17365D),
                          fontSize:10.5,
                          fontWeight:FontWeight.w900,
                          height:1.05,
                          letterSpacing:.05,
                        ),
                      ),
                      const SizedBox(height:2),
                      Text(
                        subtitle,
                        textAlign:TextAlign.center,
                        maxLines:1,
                        overflow:TextOverflow.ellipsis,
                        style:const TextStyle(
                          color:Color(0xFF758596),
                          fontSize:7.5,
                          fontWeight:FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sinServicios() {
    return Container(
      width:double.infinity,
      padding:const EdgeInsets.symmetric(
        horizontal:15,
        vertical:20,
      ),
      decoration:BoxDecoration(
        color:Colors.white.withOpacity(.95),
        borderRadius:BorderRadius.circular(17),
        border:Border.all(
          color:const Color(0xFFDCE4EC),
        ),
      ),
      child:const Column(
        children:[
          Icon(
            Icons.info_outline_rounded,
            color:Color(0xFF7A8998),
            size:29,
          ),
          SizedBox(height:7),
          Text(
            'No existen servicios disponibles',
            textAlign:TextAlign.center,
            style:TextStyle(
              color:Color(0xFF17365D),
              fontSize:11,
              fontWeight:FontWeight.w800,
            ),
          ),
          SizedBox(height:2),
          Text(
            'No se encontraron opciones habilitadas para este operativo.',
            textAlign:TextAlign.center,
            style:TextStyle(
              color:Color(0xFF7A8998),
              fontSize:8.5,
            ),
          ),
        ],
      ),
    );
  }
}
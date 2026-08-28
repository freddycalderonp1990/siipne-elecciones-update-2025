part of '../../pages.dart';

class ReportNovedadesPage extends GetView<ReportNovedadesController> {
  const ReportNovedadesPage({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(
      mostrarBtnAtras:true,
      title:"REPORTE DE NOVEDADES",
      tamanoTitulo:18,
      showGps:true,
      contenido:getContenido(),
      peticionServer:controller.peticionServerState,
    );
  }

  Widget getContenido() {
    final responsive=ResponsiveUtil();

    return SingleChildScrollView(
      physics:const BouncingScrollPhysics(),
      padding:const EdgeInsets.fromLTRB(8,6,8,20),
      child:Column(
        crossAxisAlignment:CrossAxisAlignment.stretch,
        children:[
          _cabeceraRecinto(),
          SizedBox(height:responsive.altoP(1)),
          _resumenNovedades(),
          SizedBox(height:responsive.altoP(1)),
          _novedades(),
          SizedBox(height:responsive.altoP(2)),
        ],
      ),
    );
  }

  Widget _cabeceraRecinto() {
    return Container(
      width:double.infinity,
      padding:const EdgeInsets.fromLTRB(11,10,11,10),
      decoration:BoxDecoration(
        color:Colors.white.withOpacity(.97),
        borderRadius:BorderRadius.circular(16),
        border:Border.all(
          color:const Color(0xFF195496).withOpacity(.10),
        ),
        boxShadow:[
          BoxShadow(
            color:const Color(0xFF17365D).withOpacity(.06),
            blurRadius:12,
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
              Icons.location_city_outlined,
              color:Colors.white,
              size:21,
            ),
          ),
          const SizedBox(width:10),
          Expanded(
            child:Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children:[
                const Text(
                  'RECINTO ELECTORAL',
                  style:TextStyle(
                    color:Color(0xFF195496),
                    fontSize:7,
                    fontWeight:FontWeight.w900,
                    letterSpacing:.5,
                  ),
                ),
                const SizedBox(height:3),
                Text(
                  controller.recintosElectoralesAbiertos.nomRecintoElec,
                  maxLines:3,
                  overflow:TextOverflow.ellipsis,
                  style:const TextStyle(
                    color:Color(0xFF17365D),
                    fontSize:11.5,
                    fontWeight:FontWeight.w900,
                    height:1.12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _resumenNovedades() {
    return Obx((){
      final int total=controller.listNovedadesElectorales.value.length;

      return Container(
        width:double.infinity,
        padding:const EdgeInsets.all(11),
        decoration:BoxDecoration(
          gradient:const LinearGradient(
            begin:Alignment.centerLeft,
            end:Alignment.centerRight,
            colors:[
              Color(0xFFFFF7ED),
              Color(0xFFFFFBF6),
            ],
          ),
          borderRadius:BorderRadius.circular(16),
          border:Border.all(
            color:const Color(0xFFE5A94D).withOpacity(.22),
          ),
        ),
        child:Row(
          children:[
            Container(
              width:46,
              height:46,
              decoration:BoxDecoration(
                color:Colors.white,
                borderRadius:BorderRadius.circular(13),
                border:Border.all(
                  color:const Color(0xFFE5A94D).withOpacity(.18),
                ),
              ),
              child:const Icon(
                Icons.report_problem_outlined,
                color:Color(0xFFD68A1F),
                size:22,
              ),
            ),
            const SizedBox(width:10),
            const Expanded(
              child:Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children:[
                  Text(
                    'NOVEDADES REGISTRADAS',
                    style:TextStyle(
                      color:Color(0xFF17365D),
                      fontSize:10.5,
                      fontWeight:FontWeight.w900,
                    ),
                  ),
                  SizedBox(height:2),
                  Text(
                    'Incidencias reportadas durante el operativo',
                    style:TextStyle(
                      color:Color(0xFF7A8998),
                      fontSize:7.8,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              constraints:const BoxConstraints(
                minWidth:46,
                minHeight:38,
              ),
              padding:const EdgeInsets.symmetric(
                horizontal:10,
                vertical:7,
              ),
              decoration:BoxDecoration(
                color:total>0
                    ?const Color(0xFFD68A1F)
                    :const Color(0xFF8997A5),
                borderRadius:BorderRadius.circular(12),
              ),
              child:Column(
                mainAxisSize:MainAxisSize.min,
                children:[
                  Text(
                    '$total',
                    style:const TextStyle(
                      color:Colors.white,
                      fontSize:15,
                      fontWeight:FontWeight.w900,
                    ),
                  ),
                  const Text(
                    'TOTAL',
                    style:TextStyle(
                      color:Colors.white70,
                      fontSize:5.8,
                      fontWeight:FontWeight.w800,
                      letterSpacing:.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _novedades() {
    return Obx((){
      final list=controller.listNovedadesElectorales.value??[];

      print("Novedades: ${list.length}");

      return Container(
        width:double.infinity,
        decoration:BoxDecoration(
          color:Colors.white,
          borderRadius:BorderRadius.circular(16),
          border:Border.all(
            color:const Color(0xFFE0E7ED),
          ),
          boxShadow:[
            BoxShadow(
              color:const Color(0xFF17365D).withOpacity(.05),
              blurRadius:10,
              offset:const Offset(0,3),
            ),
          ],
        ),
        child:Theme(
          data:ThemeData().copyWith(
            dividerColor:Colors.transparent,
            splashColor:Colors.transparent,
            highlightColor:Colors.transparent,
          ),
          child:ExpansionTile(
            initiallyExpanded:true,
            tilePadding:const EdgeInsets.symmetric(
              horizontal:11,
              vertical:3,
            ),
            childrenPadding:const EdgeInsets.fromLTRB(10,0,10,10),
            collapsedIconColor:const Color(0xFF195496),
            iconColor:const Color(0xFF195496),
            leading:Container(
              width:38,
              height:38,
              decoration:BoxDecoration(
                color:list.isEmpty
                    ?const Color(0xFFF0F3F6)
                    :const Color(0xFFFFF3E4),
                borderRadius:BorderRadius.circular(11),
              ),
              child:Icon(
                list.isEmpty
                    ?Icons.inbox_outlined
                    :Icons.warning_amber_rounded,
                color:list.isEmpty
                    ?const Color(0xFF8997A5)
                    :const Color(0xFFD68A1F),
                size:19,
              ),
            ),
            title:const Text(
              'NOVEDADES',
              style:TextStyle(
                color:Color(0xFF17365D),
                fontSize:10.8,
                fontWeight:FontWeight.w900,
              ),
            ),
            subtitle:Text(
              '${list.length} registros disponibles',
              style:const TextStyle(
                color:Color(0xFF7A8998),
                fontSize:7.4,
              ),
            ),
            trailing:Row(
              mainAxisSize:MainAxisSize.min,
              children:[
                Container(
                  padding:const EdgeInsets.symmetric(
                    horizontal:7,
                    vertical:4,
                  ),
                  decoration:BoxDecoration(
                    color:list.isEmpty
                        ?const Color(0xFFF0F3F6)
                        :const Color(0xFFFFF3E4),
                    borderRadius:BorderRadius.circular(20),
                  ),
                  child:Text(
                    '${list.length}',
                    style:TextStyle(
                      color:list.isEmpty
                          ?const Color(0xFF8997A5)
                          :const Color(0xFFD68A1F),
                      fontSize:7.5,
                      fontWeight:FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(width:4),
                const Icon(
                  Icons.expand_more_rounded,
                  color:Color(0xFF195496),
                ),
              ],
            ),
            children:list.isEmpty
                ?[
              _sinNovedades(),
            ]
                :[
              ListView.builder(
                reverse:true,
                shrinkWrap:true,
                physics:const NeverScrollableScrollPhysics(),
                itemCount:list.length,
                itemBuilder:(BuildContext context,int i){
                  return Padding(
                    padding:const EdgeInsets.only(bottom:7),
                    child:Container(
                      decoration:BoxDecoration(
                        color:const Color(0xFFF9FAFC),
                        borderRadius:BorderRadius.circular(13),
                        border:Border.all(
                          color:const Color(0xFFE1E7ED),
                        ),
                      ),
                      child:ClipRRect(
                        borderRadius:BorderRadius.circular(13),
                        child:DisingNovedades(
                          onTap:(){},
                          data:list[i],
                          index:i,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _sinNovedades() {
    return Container(
      width:double.infinity,
      padding:const EdgeInsets.symmetric(
        horizontal:10,
        vertical:20,
      ),
      decoration:BoxDecoration(
        color:const Color(0xFFF7F9FB),
        borderRadius:BorderRadius.circular(13),
      ),
      child:const Column(
        children:[
          Icon(
            Icons.check_circle_outline_rounded,
            color:Color(0xFF218A61),
            size:30,
          ),
          SizedBox(height:7),
          Text(
            'No hay novedades disponibles',
            textAlign:TextAlign.center,
            style:TextStyle(
              color:Color(0xFF17365D),
              fontSize:9.2,
              fontWeight:FontWeight.w800,
            ),
          ),
          SizedBox(height:3),
          Text(
            'No existen incidencias registradas para este recinto.',
            textAlign:TextAlign.center,
            style:TextStyle(
              color:Color(0xFF7A8998),
              fontSize:7.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget getDesingExpandible({
    required String title,
    required List<Widget> children,
  }) {
    final responsive=ResponsiveUtil();

    return ExpansionTile(
      collapsedIconColor:AppColors.colorAzul,
      iconColor:AppColors.colorAzul,
      initiallyExpanded:true,
      title:Text(
        title,
        style:TextStyle(
          color:AppColors.colorAzul,
          fontSize:responsive.diagonalP(AppConfig.tamTextoTitulo),
        ),
      ),
      children:children,
    );
  }
}
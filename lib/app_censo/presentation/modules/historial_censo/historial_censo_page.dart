part of '../pages.dart';

class HistorialCensoPage extends GetView<HistorialCensoController> {
  const HistorialCensoPage({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageCensoWidget(
      showBtnNotificacione:false,
      mostrarDatosServidor:true,
      mostrarBtnAtras:true,
      title:"HISTORIAL CENSO",
      imgPerfil:controller.user.foto,
      nombresServidor:controller.user.nombres?.toString(),
      sexoServidor:controller.user.sexo?.toString(),
      contenido:getContenido(),
      peticionServer:controller.peticionServerState,
    );
  }

  Widget getContenido() {
    return Column(
      crossAxisAlignment:CrossAxisAlignment.stretch,
      children:[
        Expanded(
          child:SingleChildScrollView(
            physics:const BouncingScrollPhysics(),
            padding:const EdgeInsets.fromLTRB(9,6,9,22),
            child:Column(
              crossAxisAlignment:CrossAxisAlignment.stretch,
              children:[
                _listadoHistorial(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _listadoHistorial() {
    return Obx((){
      final list=controller.listHistoryCenso.value;
      if(list.isEmpty){
        return _sinHistorial();
      }
      return Container(
        width:double.infinity,
        padding:const EdgeInsets.fromLTRB(10,10,10,11),
        decoration:BoxDecoration(
          color:Colors.white.withOpacity(.98),
          borderRadius:BorderRadius.circular(19),
          border:Border.all(
            color:const Color(0xFFE0E7ED),
          ),
          boxShadow:[
            BoxShadow(
              color:const Color(0xFF17365D).withOpacity(.055),
              blurRadius:12,
              offset:const Offset(0,4),
            ),
          ],
        ),
        child:Column(
          crossAxisAlignment:CrossAxisAlignment.stretch,
          children:[
            _tituloSeccion(
              total:list.length,
            ),
            const SizedBox(height:10),
            Container(
              width:double.infinity,
              height:1,
              decoration:BoxDecoration(
                gradient:LinearGradient(
                  colors:[
                    Colors.transparent,
                    const Color(0xFFDCE4EC),
                    const Color(0xFFDCE4EC),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            const SizedBox(height:10),
            ListView.builder(
              shrinkWrap:true,
              physics:const NeverScrollableScrollPhysics(),
              itemCount:list.length,
              itemBuilder:(context,index){
                DataHistoryCenso data=list[index];
                return Padding(
                  padding:EdgeInsets.only(
                    bottom:index==list.length-1?0:10,
                  ),
                  child:_registroHistorial(
                    data:data,
                    index:index,
                  ),
                );
              },
            ),
          ],
        ),
      );
    });
  }

  Widget _registroHistorial({
    required DataHistoryCenso data,
    required int index,
  }) {
    return Column(
      crossAxisAlignment:CrossAxisAlignment.stretch,
      children:[
        Container(
          decoration:BoxDecoration(
            color:Colors.white,
            borderRadius:BorderRadius.circular(12),
            border:Border.all(
              color:Colors.black,
              width:1.2,
            ),
          ),
          child:Padding(
            padding:const EdgeInsets.all(1),
            child:ClipRRect(
              borderRadius:BorderRadius.circular(11),
              child:DesingHistoryCensos(
                data:data,
                index:index+1,
                onPressed:(){
                  DownloadPdfCensoRequest request=DownloadPdfCensoRequest(
                    idDpgPerCenso:data.idDgpPerCenso,
                    idPerCensado:data.idPerCensado,
                  );

                  controller.descargarPdfCenso(
                    request:request,
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _tituloSeccion({
    required int total,
  }) {
    return Row(
      children:[
        Container(
          width:41,
          height:41,
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
            boxShadow:[
              BoxShadow(
                color:const Color(0xFF195496).withOpacity(.15),
                blurRadius:7,
                offset:const Offset(0,3),
              ),
            ],
          ),
          child:const Icon(
            Icons.format_list_bulleted_rounded,
            color:Colors.white,
            size:20,
          ),
        ),

        const SizedBox(width:9),

        const Expanded(
          child:Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children:[
              Text(
                'REGISTROS DEL CENSO',
                style:TextStyle(
                  color:Color(0xFF17365D),
                  fontSize:10.6,
                  fontWeight:FontWeight.w900,
                  letterSpacing:.2,
                ),
              ),

              SizedBox(height:2),

              Text(
                'Seleccione un registro para consultar o descargar su comprobante',
                style:TextStyle(
                  color:Color(0xFF7A8998),
                  fontSize:7.2,
                  height:1.2,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width:6),

        Container(
          padding:const EdgeInsets.symmetric(
            horizontal:8,
            vertical:5,
          ),
          decoration:BoxDecoration(
            color:const Color(0xFFEAF1F8),
            borderRadius:BorderRadius.circular(10),
            border:Border.all(
              color:const Color(0xFF195496).withOpacity(.10),
            ),
          ),
          child:Column(
            mainAxisSize:MainAxisSize.min,
            children:[
              Text(
                '$total',
                style:const TextStyle(
                  color:Color(0xFF195496),
                  fontSize:11,
                  fontWeight:FontWeight.w900,
                  height:1,
                ),
              ),

              const SizedBox(height:2),

              const Text(
                'TOTAL',
                style:TextStyle(
                  color:Color(0xFF7A8998),
                  fontSize:5.2,
                  fontWeight:FontWeight.w900,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width:6),

        Container(
          width:35,
          height:35,
          decoration:BoxDecoration(
            color:const Color(0xFFEAF5EE),
            borderRadius:BorderRadius.circular(10),
            border:Border.all(
              color:const Color(0xFF218A61).withOpacity(.08),
            ),
          ),
          child:const Icon(
            Icons.picture_as_pdf_outlined,
            color:Color(0xFF218A61),
            size:17,
          ),
        ),
      ],
    );
  }

  Widget _sinHistorial() {
    return Container(
      width:double.infinity,
      padding:const EdgeInsets.fromLTRB(18,27,18,25),
      decoration:BoxDecoration(
        color:Colors.white.withOpacity(.98),
        borderRadius:BorderRadius.circular(19),
        border:Border.all(
          color:const Color(0xFFE0E7ED),
        ),
        boxShadow:[
          BoxShadow(
            color:const Color(0xFF17365D).withOpacity(.05),
            blurRadius:11,
            offset:const Offset(0,4),
          ),
        ],
      ),
      child:Column(
        children:[
          Stack(
            alignment:Alignment.center,
            children:[
              Container(
                width:76,
                height:76,
                decoration:BoxDecoration(
                  shape:BoxShape.circle,
                  color:const Color(0xFFEAF1F8).withOpacity(.65),
                ),
              ),

              Container(
                width:58,
                height:58,
                decoration:BoxDecoration(
                  color:Colors.white,
                  borderRadius:BorderRadius.circular(17),
                  border:Border.all(
                    color:const Color(0xFFDCE4EC),
                  ),
                  boxShadow:[
                    BoxShadow(
                      color:const Color(0xFF17365D).withOpacity(.06),
                      blurRadius:8,
                      offset:const Offset(0,3),
                    ),
                  ],
                ),
                child:const Icon(
                  Icons.history_toggle_off_rounded,
                  color:Color(0xFF6F8294),
                  size:29,
                ),
              ),
            ],
          ),

          const SizedBox(height:13),

          const Text(
            'SIN REGISTROS DE CENSO',
            textAlign:TextAlign.center,
            style:TextStyle(
              color:Color(0xFF17365D),
              fontSize:10.5,
              fontWeight:FontWeight.w900,
              letterSpacing:.25,
            ),
          ),

          const SizedBox(height:5),

          const Padding(
            padding:EdgeInsets.symmetric(horizontal:12),
            child:Text(
              'Actualmente no existen censos registrados para mostrar en el historial.',
              textAlign:TextAlign.center,
              style:TextStyle(
                color:Color(0xFF7A8998),
                fontSize:7.6,
                height:1.3,
              ),
            ),
          ),

          const SizedBox(height:13),

          Container(
            padding:const EdgeInsets.symmetric(
              horizontal:10,
              vertical:7,
            ),
            decoration:BoxDecoration(
              color:const Color(0xFFF1F6FA),
              borderRadius:BorderRadius.circular(20),
              border:Border.all(
                color:const Color(0xFF195496).withOpacity(.08),
              ),
            ),
            child:const Row(
              mainAxisSize:MainAxisSize.min,
              children:[
                Icon(
                  Icons.info_outline_rounded,
                  color:Color(0xFF195496),
                  size:13,
                ),

                SizedBox(width:5),

                Text(
                  'Los nuevos registros aparecerán automáticamente',
                  style:TextStyle(
                    color:Color(0xFF195496),
                    fontSize:6.7,
                    fontWeight:FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
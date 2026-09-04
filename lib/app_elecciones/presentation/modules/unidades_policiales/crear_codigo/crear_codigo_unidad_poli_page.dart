part of '../../pages.dart';

class CrearCodigoUnidadPoliPage extends GetView<CrearCodigoUnidadPoliController> {
  const CrearCodigoUnidadPoliPage({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(
      title:"CREAR CÓDIGO",
      tamanoTitulo:18,
      mostrarBtnAtras:true,
      mostrarDatosServidor:true,
      imgPerfil:controller.user.foto,
      nombresServidor:controller.user.nombres?.toString(),
      sexoServidor:controller.user.sexo?.toString(),
      onPressBtnAtras:(){
        if(controller.continuar.value){
          controller.continuar.value=false;
        }else{
          Get.back();
        }
      },
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
          _cabeceraOperativo(),
          SizedBox(height:responsive.altoP(1.2)),
          _indicadorEtapa(),
          SizedBox(height:responsive.altoP(1)),
          _getMenu(responsive),
        ],
      ),
    );
  }

  Widget _cabeceraOperativo() {
    return Container(
      width:double.infinity,
      padding:const EdgeInsets.fromLTRB(11,10,11,10),
      decoration:BoxDecoration(
        color:Colors.white.withOpacity(.96),
        borderRadius:BorderRadius.circular(16),
        border:Border.all(color:const Color(0xFF195496).withOpacity(.09)),
        boxShadow:[BoxShadow(color:const Color(0xFF17365D).withOpacity(.06),blurRadius:13,offset:const Offset(0,4))],
      ),
      child:Row(
        children:[
          Container(
            width:42,
            height:42,
            decoration:BoxDecoration(
              gradient:const LinearGradient(begin:Alignment.topLeft,end:Alignment.bottomRight,colors:[Color(0xFF123F75),Color(0xFF195496),Color(0xFF2869AC)]),
              borderRadius:BorderRadius.circular(12),
            ),
            child:const Icon(Icons.how_to_vote_outlined,color:Colors.white,size:21),
          ),
          const SizedBox(width:10),
          Expanded(
            child:Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children:[
                const Text('OPERATIVO',style:TextStyle(color:Color(0xFF195496),fontSize:7.5,fontWeight:FontWeight.w900,letterSpacing:.8)),
                const SizedBox(height:3),
                Text(
                  "${controller.selectProcesoOperativoController.selectProcesosOperativo.value.descProcElecc}",
                  maxLines:3,
                  softWrap:true,
                  overflow:TextOverflow.visible,
                  style:const TextStyle(color:Color(0xFF17365D),fontSize:12.2,fontWeight:FontWeight.w800,height:1.12),
                ),
              ],
            ),
          ),
          const SizedBox(width:8),
          Container(
            width:31,
            height:31,
            decoration:const BoxDecoration(color:Color(0xFFEAF1F8),borderRadius:BorderRadius.all(Radius.circular(9))),
            child:const Icon(Icons.verified_outlined,color:Color(0xFF195496),size:17),
          ),
        ],
      ),
    );
  }

  Widget _indicadorEtapa() {
    return Obx((){
      final bool pasoDos=controller.continuar.value;

      return Container(
        width:double.infinity,
        padding:const EdgeInsets.symmetric(horizontal:10,vertical:9),
        decoration:BoxDecoration(
          color:Colors.white.withOpacity(.95),
          borderRadius:BorderRadius.circular(14),
          border:Border.all(color:const Color(0xFFDCE4EC)),
        ),
        child:Row(
          children:[
            _paso(numero:'1',titulo:'Dirección',activo:!pasoDos,completado:pasoDos),
            Expanded(
              child:Container(
                height:2,
                margin:const EdgeInsets.symmetric(horizontal:7),
                color:pasoDos?const Color(0xFF195496):const Color(0xFFDCE4EC),
              ),
            ),
            _paso(numero:'2',titulo:'Unidad',activo:pasoDos,completado:false),
          ],
        ),
      );
    });
  }

  Widget _paso({required String numero,required String titulo,required bool activo,required bool completado}) {
    final Color color=activo||completado?const Color(0xFF195496):const Color(0xFF9AA7B3);

    return Row(
      mainAxisSize:MainAxisSize.min,
      children:[
        Container(
          width:27,
          height:27,
          alignment:Alignment.center,
          decoration:BoxDecoration(
            color:activo||completado?const Color(0xFFEAF1F8):const Color(0xFFF2F4F6),
            borderRadius:BorderRadius.circular(9),
            border:Border.all(color:color.withOpacity(.18)),
          ),
          child:completado
              ?Icon(Icons.check_rounded,color:color,size:15)
              :Text(numero,style:TextStyle(color:color,fontSize:9,fontWeight:FontWeight.w900)),
        ),
        const SizedBox(width:5),
        Text(
          titulo,
          style:TextStyle(color:color,fontSize:8.5,fontWeight:FontWeight.w800),
        ),
      ],
    );
  }

  Widget _getMenu(ResponsiveUtil responsive) {
    return Column(
      children:[
        Obx(
              ()=>controller.cargaInicial==false
              ?MyUbicacionWidget(
            callback:(_){
              controller.getSubsistemas();
            },
          )
              :const SizedBox.shrink(),
        ),
        Obx(
              ()=>!controller.continuar.value
              ?_getDesingSelectDireccionContinuar(responsive)
              :_getDesingSelectUnidadVolver(responsive),
        ),
      ],
    );
  }

  Widget _getDesingSelectDireccionContinuar(ResponsiveUtil responsive) {
    return Column(
      children:[
        _cardSeleccionInicial(),
        SizedBox(height:responsive.altoP(1.4)),
        btnContinuar(),
      ],
    );
  }

  Widget _getDesingSelectUnidadVolver(ResponsiveUtil responsive) {
    return Column(
      children:[
        _cardSeleccionUnidad(responsive),
        SizedBox(height:responsive.altoP(1.4)),
        btnCrear(),
      ],
    );
  }

  Widget _cardSeleccionInicial() {
    return Container(
      width:double.infinity,
      padding:const EdgeInsets.fromLTRB(12,11,12,12),
      decoration:BoxDecoration(
        color:Colors.white.withOpacity(.97),
        borderRadius:BorderRadius.circular(18),
        border:Border.all(color:const Color(0xFF195496).withOpacity(.10)),
        boxShadow:[BoxShadow(color:const Color(0xFF17365D).withOpacity(.07),blurRadius:14,offset:const Offset(0,5))],
      ),
      child:Column(
        crossAxisAlignment:CrossAxisAlignment.stretch,
        children:[
          _cabeceraCard(
            icon:Icons.account_tree_outlined,
            titulo:'ESTRUCTURA POLICIAL',
            subtitulo:'Seleccione el subsistema y la dirección policial',
          ),
          const SizedBox(height:11),
          getComboSubsistema(),
          const SizedBox(height:10),
          getComboDireccionesPoliciales(),
        ],
      ),
    );
  }

  Widget _cardSeleccionUnidad(ResponsiveUtil responsive) {
    return Container(
      width:double.infinity,
      padding:const EdgeInsets.fromLTRB(12,11,12,12),
      decoration:BoxDecoration(
        color:Colors.white.withOpacity(.97),
        borderRadius:BorderRadius.circular(18),
        border:Border.all(color:const Color(0xFF195496).withOpacity(.10)),
        boxShadow:[BoxShadow(color:const Color(0xFF17365D).withOpacity(.07),blurRadius:14,offset:const Offset(0,5))],
      ),
      child:Column(
        crossAxisAlignment:CrossAxisAlignment.stretch,
        children:[
          _cabeceraCard(
            icon:Icons.apartment_outlined,
            titulo:'UNIDAD POLICIAL',
            subtitulo:'Seleccione la unidad y registre un teléfono de contacto',
          ),
          const SizedBox(height:11),
          getComboRecintosElectorales(),
          const SizedBox(height:10),
          wgTxtTelefono(responsive),
        ],
      ),
    );
  }

  Widget _cabeceraCard({required IconData icon,required String titulo,required String subtitulo}) {
    return Row(
      children:[
        Container(
          width:40,
          height:40,
          decoration:BoxDecoration(color:const Color(0xFFEAF1F8),borderRadius:BorderRadius.circular(11)),
          child:Icon(icon,color:const Color(0xFF195496),size:20),
        ),
        const SizedBox(width:9),
        Expanded(
          child:Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children:[
              Text(titulo,style:const TextStyle(color:Color(0xFF17365D),fontSize:12.5,fontWeight:FontWeight.w900)),
              const SizedBox(height:2),
              Text(subtitulo,style:const TextStyle(color:Color(0xFF7A8998),fontSize:8.5,height:1.15)),
            ],
          ),
        ),
      ],
    );
  }

  Widget getComboRecintosElectorales() {
    return Obx(
          ()=>Container(
        width:double.infinity,
        padding:const EdgeInsets.fromLTRB(8,8,8,6),
        decoration:BoxDecoration(
          color:const Color(0xFFF7F9FB),
          borderRadius:BorderRadius.circular(13),
          border:Border.all(color:const Color(0xFFE0E7ED)),
        ),
        child:ComboBusqueda(
          selectValue:controller.selectRecintosElectoral.value,
          showClearButton:false,
          datos:controller.listRecintosElectorales.value,
          displayField:(item)=>item.nomRecintoElec,
          searchHint:"Recinto Electoral",
          complete:(value){
            controller.selectRecintosElectoral.value=RecintosElectoral();

            if(value!=null){
              controller.selectRecintosElectoral.value=value;
            }
          },
          textSeleccioneUndato:"Seleccione un Recinto",
        ),
      ),
    );
  }

  Widget getComboSubsistema() {
    return Obx(
          ()=>Container(
        width:double.infinity,
        padding:const EdgeInsets.fromLTRB(8,8,8,6),
        decoration:BoxDecoration(
          color:const Color(0xFFF7F9FB),
          borderRadius:BorderRadius.circular(13),
          border:Border.all(color:const Color(0xFFE0E7ED)),
        ),
        child:ComboBusqueda(
          selectValue:controller.selectSubsistema.value,
          showClearButton:false,
          datos:controller.listSubsistema,
          displayField:(item)=>item.descripcion,
          searchHint:"Subsistema",
          complete:(value){
            controller.selectSubsistema.value=UnidadesPoliciale.empty();
            controller.selectDireccionPoliciales.value=UnidadesPoliciale.empty();
            controller.selectUnidadPolicial.value=UnidadesPoliciale.empty();

            if(value!=null){
              controller.selectSubsistema.value=value;
              controller.getEjesDireccionesPoliciales(value.idDgoTipoEje);
              return;
            }
          },
          textSeleccioneUndato:"Seleccione un Subsistema",
        ),
      ),
    );
  }

  Widget getComboDireccionesPoliciales() {
    return Obx(
          ()=>controller.selectSubsistema.value.idDgoTipoEje>0
          ?Container(
        width:double.infinity,
        padding:const EdgeInsets.fromLTRB(8,8,8,6),
        decoration:BoxDecoration(
          color:const Color(0xFFF7F9FB),
          borderRadius:BorderRadius.circular(13),
          border:Border.all(color:const Color(0xFFE0E7ED)),
        ),
        child:ComboBusqueda(
          selectValue:controller.selectDireccionPoliciales.value,
          showClearButton:false,
          datos:controller.listDireccionesPoliciales,
          displayField:(item)=>item.descripcion,
          searchHint:"Dirección",
          complete:(value){
            controller.selectDireccionPoliciales.value=UnidadesPoliciale.empty();
            controller.selectUnidadPolicial.value=UnidadesPoliciale.empty();

            if(value!=null){
              controller.getEjesUnidadesPoliciales(value.idDgoTipoEje);
              controller.selectDireccionPoliciales.value=value;
              return;
            }
          },
          textSeleccioneUndato:"Seleccione una Dirección",
        ),
      )
          :const SizedBox.shrink(),
    );
  }

  Widget wgTxtTelefono(ResponsiveUtil responsive) {
    return Obx(
          ()=>controller.selectRecintosElectoral.value.idDgoTipoEje>0
          ?Container(
        width:double.infinity,
        padding:const EdgeInsets.fromLTRB(8,8,8,6),
        decoration:BoxDecoration(
          color:const Color(0xFFF7F9FB),
          borderRadius:BorderRadius.circular(13),
          border:Border.all(color:const Color(0xFFE0E7ED)),
        ),
        child:WgTxtTelefono(
          controllerTelefono:controller.controllerTelefono,
          formKey:controller.formKey,
        ),
      )
          :const SizedBox.shrink(),
    );
  }

  Widget btnContinuar() {
    return Obx(
          ()=>controller.selectDireccionPoliciales.value.idDgoTipoEje>0
          ?Center(
        child:SizedBox(
          width:210,
          child:_botonPrincipal(
            titulo:'CONTINUAR',
            icon:Icons.arrow_forward_rounded,
            onTap:() async {
              int idDgoTipoEje=controller.selectDireccionPoliciales.value.idDgoTipoEje;
              await controller.getRecintosElectorales(idDgoTipoEje);
            },
          ),
        ),
      )
          :const SizedBox.shrink(),
    );
  }

  Widget btnVolver() {
    return Center(
      child:SizedBox(
        width:210,
        child:_botonSecundario(
          titulo:'VOLVER',
          icon:Icons.arrow_back_rounded,
          onTap:(){
            controller.continuar.value=false;
          },
        ),
      ),
    );
  }

  Widget btnCrear() {
    return Obx(
          ()=>controller.selectRecintosElectoral.value.idDgoTipoEje>0
          ?Center(
        child:SizedBox(
          width:220,
          child:_botonPrincipal(
            titulo:'CREAR CÓDIGO',
            icon:Icons.add_circle_outline_rounded,
            onTap:(){
              controller.msjCrearCodigo(
                onPressed:(){
                  controller.crearCodigo();
                },
              );
            },
          ),
        ),
      )
          :const SizedBox.shrink(),
    );
  }

  Widget _botonPrincipal({required String titulo,required IconData icon,required VoidCallback onTap}) {
    return Material(
      color:Colors.transparent,
      borderRadius:BorderRadius.circular(14),
      clipBehavior:Clip.antiAlias,
      child:InkWell(
        onTap:onTap,
        splashColor:Colors.white.withOpacity(.15),
        child:Ink(
          height:49,
          decoration:BoxDecoration(
            gradient:const LinearGradient(begin:Alignment.topLeft,end:Alignment.bottomRight,colors:[Color(0xFF123F75),Color(0xFF195496),Color(0xFF2869AC)]),
            borderRadius:BorderRadius.circular(14),
            boxShadow:[BoxShadow(color:const Color(0xFF195496).withOpacity(.22),blurRadius:10,offset:const Offset(0,4))],
          ),
          child:Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children:[
              Icon(icon,color:Colors.white,size:19),
              const SizedBox(width:8),
              Text(titulo,style:const TextStyle(color:Colors.white,fontSize:10.5,fontWeight:FontWeight.w900,letterSpacing:.7)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _botonSecundario({required String titulo,required IconData icon,required VoidCallback onTap}) {
    return Material(
      color:Colors.transparent,
      borderRadius:BorderRadius.circular(14),
      clipBehavior:Clip.antiAlias,
      child:InkWell(
        onTap:onTap,
        splashColor:const Color(0xFF195496).withOpacity(.08),
        child:Ink(
          height:47,
          decoration:BoxDecoration(
            color:Colors.white,
            borderRadius:BorderRadius.circular(14),
            border:Border.all(color:const Color(0xFFDCE4EC)),
          ),
          child:Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children:[
              Icon(icon,color:const Color(0xFF195496),size:18),
              const SizedBox(width:7),
              Text(titulo,style:const TextStyle(color:Color(0xFF195496),fontSize:10.5,fontWeight:FontWeight.w900,letterSpacing:.6)),
            ],
          ),
        ),
      ),
    );
  }
}
part of '../pages.dart';

class AnexarsePage extends GetView<AnexarseController> {
  const AnexarsePage({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(
      showGps:true,
      mostrarBtnAtras:true,
      title:"ANEXARSE",
      tamanoTitulo:20,
      mostrarDatosServidor:false,
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
          _tituloConsulta(),
          SizedBox(height:responsive.altoP(1)),
          wgConsultarRecinto(),
          SizedBox(height:responsive.altoP(1.2)),
          wgDatosRecinto(),
        ],
      ),
    );
  }

  Widget _tituloConsulta() {
    return Padding(
      padding:const EdgeInsets.symmetric(horizontal:2),
      child:Row(
        children:[
          Container(
            width:3,
            height:28,
            decoration:BoxDecoration(
              color:const Color(0xFF195496),
              borderRadius:BorderRadius.circular(20),
            ),
          ),
          const SizedBox(width:8),
          const Expanded(
            child:Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children:[
                Text(
                  'Consultar operativo',
                  style:TextStyle(
                    color:Color(0xFF17365D),
                    fontSize:14,
                    fontWeight:FontWeight.w800,
                  ),
                ),
                SizedBox(height:1),
                Text(
                  'Ingrese el código del recinto electoral',
                  style:TextStyle(
                    color:Color(0xFF7A8998),
                    fontSize:9,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width:31,
            height:31,
            decoration:const BoxDecoration(
              color:Color(0xFFEAF1F8),
              borderRadius:BorderRadius.all(Radius.circular(9)),
            ),
            child:const Icon(
              Icons.search_rounded,
              color:Color(0xFF195496),
              size:17,
            ),
          ),
        ],
      ),
    );
  }

  Widget wgConsultarRecinto() {
    final responsive=ResponsiveUtil();

    return Container(
      width:double.infinity,
      padding:const EdgeInsets.fromLTRB(12,11,12,11),
      decoration:BoxDecoration(
        color:Colors.white.withOpacity(.97),
        borderRadius:BorderRadius.circular(18),
        border:Border.all(
          color:const Color(0xFF195496).withOpacity(.10),
        ),
        boxShadow:[
          BoxShadow(
            color:const Color(0xFF17365D).withOpacity(.07),
            blurRadius:14,
            offset:const Offset(0,5),
          ),
        ],
      ),
      child:Form(
        key:controller.formKey,
        child:Row(
          crossAxisAlignment:CrossAxisAlignment.center,
          children:[
            Expanded(
              child:ImputTextWidget(
                keyboardType:TextInputType.number,
                controller:controller.controllerCodigoRecinto,
                icono:Icon(
                  Icons.numbers_rounded,
                  color:const Color(0xFF195496),
                  size:responsive.diagonalP(AppConfig.tamIcons),
                ),
                label:SiipneStrings.codigo,
                fonSize:responsive.diagonalP(AppConfig.tamTextoTitulo),
                validar:validateCodigoRecinto,
              ),
            ),
            const SizedBox(width:10),
            _botonBuscar(),
          ],
        ),
      ),
    );
  }

  Widget _botonBuscar() {
    return Material(
      color:Colors.transparent,
      borderRadius:BorderRadius.circular(13),
      clipBehavior:Clip.antiAlias,
      child:InkWell(
        onTap:()=>controller.consultarDatosSegunCodigo(),
        splashColor:Colors.white.withOpacity(.15),
        child:Ink(
          width:48,
          height:48,
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
            borderRadius:BorderRadius.circular(13),
            boxShadow:[
              BoxShadow(
                color:const Color(0xFF195496).withOpacity(.20),
                blurRadius:9,
                offset:const Offset(0,3),
              ),
            ],
          ),
          child:const Icon(
            Icons.search_rounded,
            color:Colors.white,
            size:22,
          ),
        ),
      ),
    );
  }

  Widget wgDatosRecinto() {
    final responsive=ResponsiveUtil();

    return Obx((){
      if(controller.datosEncargado.value.idDgoReciElect<=0){
        return const SizedBox.shrink();
      }

      return Column(
        children:[
          _cardDatosOperativo(responsive),
          SizedBox(height:responsive.altoP(1.2)),
          getComboInstalacionesUnidadesPoliciales(),
          SizedBox(height:responsive.altoP(1.3)),
          btnRegistrar(),
        ],
      );
    });
  }

  Widget _cardDatosOperativo(ResponsiveUtil responsive) {
    return Container(
      width:double.infinity,
      decoration:BoxDecoration(
        color:Colors.white.withOpacity(.97),
        borderRadius:BorderRadius.circular(18),
        border:Border.all(
          color:const Color(0xFF195496).withOpacity(.10),
        ),
        boxShadow:[
          BoxShadow(
            color:const Color(0xFF17365D).withOpacity(.07),
            blurRadius:14,
            offset:const Offset(0,5),
          ),
        ],
      ),
      child:Theme(
        data:Theme.of(Get.context!).copyWith(
          dividerColor:Colors.transparent,
          splashColor:const Color(0xFF195496).withOpacity(.04),
          highlightColor:const Color(0xFF195496).withOpacity(.02),
        ),
        child:ExpansionTile(
          initiallyExpanded:true,
          tilePadding:const EdgeInsets.symmetric(horizontal:12,vertical:2),
          childrenPadding:const EdgeInsets.fromLTRB(12,0,12,12),
          collapsedIconColor:const Color(0xFF195496),
          iconColor:const Color(0xFF195496),
          leading:Container(
            width:40,
            height:40,
            decoration:BoxDecoration(
              color:const Color(0xFFEAF1F8),
              borderRadius:BorderRadius.circular(11),
            ),
            child:const Icon(
              Icons.how_to_vote_outlined,
              color:Color(0xFF195496),
              size:20,
            ),
          ),
          title:const Text(
            'DATOS DEL OPERATIVO',
            style:TextStyle(
              color:Color(0xFF17365D),
              fontSize:12.5,
              fontWeight:FontWeight.w900,
              letterSpacing:.4,
            ),
          ),
          subtitle:const Padding(
            padding:EdgeInsets.only(top:2),
            child:Text(
              'Información del recinto consultado',
              style:TextStyle(
                color:Color(0xFF7A8998),
                fontSize:8.5,
              ),
            ),
          ),
          children:[
            Container(
              width:double.infinity,
              padding:const EdgeInsets.all(10),
              decoration:BoxDecoration(
                color:const Color(0xFFF6F8FA),
                borderRadius:BorderRadius.circular(13),
                border:Border.all(
                  color:const Color(0xFFE1E7ED),
                ),
              ),
              child:Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children:[
                  _datoOperativo(
                    icon:Icons.location_on_outlined,
                    titulo:'Instalación',
                    detalle:controller.datosEncargado.value.nomRecintoElec,
                  ),
                  const SizedBox(height:9),
                  Container(
                    height:1,
                    color:const Color(0xFFE2E8EE),
                  ),
                  const SizedBox(height:9),
                  _datoOperativo(
                    icon:Icons.person_outline_rounded,
                    titulo:'Encargado',
                    detalle:controller.datosEncargado.value.encargado,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _datoOperativo({
    required IconData icon,
    required String titulo,
    required dynamic detalle,
  }) {
    return Row(
      crossAxisAlignment:CrossAxisAlignment.start,
      children:[
        Container(
          width:31,
          height:31,
          decoration:BoxDecoration(
            color:const Color(0xFFEAF1F8),
            borderRadius:BorderRadius.circular(9),
          ),
          child:Icon(
            icon,
            color:const Color(0xFF195496),
            size:16,
          ),
        ),
        const SizedBox(width:9),
        Expanded(
          child:Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children:[
              Text(
                titulo.toUpperCase(),
                style:const TextStyle(
                  color:Color(0xFF7A8998),
                  fontSize:7.2,
                  fontWeight:FontWeight.w800,
                  letterSpacing:.6,
                ),
              ),
              const SizedBox(height:2),
              Text(
                detalle?.toString()??'',
                softWrap:true,
                style:const TextStyle(
                  color:Color(0xFF17365D),
                  fontSize:10.5,
                  fontWeight:FontWeight.w700,
                  height:1.15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String? validateCodigoRecinto(String? value) {
    if(value!=null&&value.isNotEmpty){
      int? codigoRecinto=int.tryParse(value);

      if(codigoRecinto==null){
        print("El valor ingresado no es un número entero válido.");
        return SiipneStrings.codigoOperativoNoValido;
      }

      return null;
    }

    return SiipneStrings.codigoOperativoNoValido;
  }

  Widget getComboInstalacionesUnidadesPoliciales() {
    final responsive=ResponsiveUtil();

    return Container(
      width:double.infinity,
      padding:const EdgeInsets.fromLTRB(12,11,12,12),
      decoration:BoxDecoration(
        color:Colors.white.withOpacity(.97),
        borderRadius:BorderRadius.circular(18),
        border:Border.all(
          color:const Color(0xFF195496).withOpacity(.10),
        ),
        boxShadow:[
          BoxShadow(
            color:const Color(0xFF17365D).withOpacity(.07),
            blurRadius:14,
            offset:const Offset(0,5),
          ),
        ],
      ),
      child:Column(
        crossAxisAlignment:CrossAxisAlignment.stretch,
        children:[
          Row(
            children:[
              Container(
                width:40,
                height:40,
                decoration:BoxDecoration(
                  color:const Color(0xFFEAF1F8),
                  borderRadius:BorderRadius.circular(11),
                ),
                child:const Icon(
                  Icons.account_tree_outlined,
                  color:Color(0xFF195496),
                  size:20,
                ),
              ),
              const SizedBox(width:9),
              const Expanded(
                child:Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children:[
                    Text(
                      'UNIDAD POLICIAL',
                      style:TextStyle(
                        color:Color(0xFF17365D),
                        fontSize:12.5,
                        fontWeight:FontWeight.w900,
                      ),
                    ),
                    SizedBox(height:2),
                    Text(
                      'Seleccione la unidad a la que pertenece el servidor policial',
                      style:TextStyle(
                        color:Color(0xFF7A8998),
                        fontSize:8.5,
                        height:1.15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height:11),
          Container(
            width:double.infinity,
            padding:const EdgeInsets.fromLTRB(9,9,9,5),
            decoration:BoxDecoration(
              color:const Color(0xFFF7F9FB),
              borderRadius:BorderRadius.circular(13),
              border:Border.all(
                color:const Color(0xFFE0E7ED),
              ),
            ),
            child:getCombosDinamicos(responsive),
          ),
        ],
      ),
    );
  }

  Widget btnRegistrar() {
    return Obx(
          ()=>controller.dynamicComboUnidadesPoliciales.showBtnGuardar==true
          ?Center(
        child:SizedBox(
          width:210,
          child:_botonRegistrar(),
        ),
      )
          :const SizedBox.shrink(),
    );
  }

  Widget _botonRegistrar() {
    return Material(
      color:Colors.transparent,
      borderRadius:BorderRadius.circular(14),
      clipBehavior:Clip.antiAlias,
      child:InkWell(
        onTap:()=>controller.registrarse(),
        splashColor:Colors.white.withOpacity(.15),
        child:Ink(
          height:48,
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
            boxShadow:[
              BoxShadow(
                color:const Color(0xFF195496).withOpacity(.22),
                blurRadius:10,
                offset:const Offset(0,4),
              ),
            ],
          ),
          child:const Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children:[
              Icon(
                Icons.how_to_reg_rounded,
                color:Colors.white,
                size:19,
              ),
              SizedBox(width:8),
              Text(
                'REGISTRAR',
                style:TextStyle(
                  color:Colors.white,
                  fontSize:11,
                  fontWeight:FontWeight.w900,
                  letterSpacing:.7,
                ),
              ),
              SizedBox(width:8),
              Icon(
                Icons.arrow_forward_rounded,
                color:Colors.white,
                size:16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getCombosDinamicos(ResponsiveUtil responsive) {
    return DynamicComboWidget(
      controller:controller.dynamicComboUnidadesPoliciales,
      responsive:responsive,
    );
  }
}
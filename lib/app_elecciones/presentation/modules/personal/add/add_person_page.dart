part of '../../pages.dart';

class AddPersonPage extends GetView<AddPersonController> {
  const AddPersonPage({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(
      mostrarBtnAtras:true,
      title:"AGREGAR PERSONAL",
      tamanoTitulo:18,
      showGps:true,
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
          _btnVerPersonal(),
          SizedBox(height:responsive.altoP(1)),
          _cardBusqueda(),
          SizedBox(height:responsive.altoP(1)),
          wgDatosPersona(),
          getCombos(),
          SizedBox(height:responsive.altoP(1.3)),
          getBtnAgregar(),
          SizedBox(height:responsive.altoP(2)),
        ],
      ),
    );
  }

  Widget _cabeceraGestion() {
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
              Icons.group_add_outlined,
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
                  'REGISTRO DE PERSONAL',
                  style:TextStyle(
                    color:Color(0xFF17365D),
                    fontSize:12.2,
                    fontWeight:FontWeight.w900,
                  ),
                ),
                SizedBox(height:2),
                Text(
                  'Busque al servidor policial y asigne su unidad',
                  style:TextStyle(
                    color:Color(0xFF7A8998),
                    fontSize:8.4,
                    height:1.15,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width:30,
            height:30,
            decoration:BoxDecoration(
              color:const Color(0xFFEAF1F8),
              borderRadius:BorderRadius.circular(9),
            ),
            child:const Icon(
              Icons.person_add_alt_1_outlined,
              color:Color(0xFF195496),
              size:16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _btnVerPersonal() {
    return Center(
      child:SizedBox(
        width:210,
        child:Material(
          color:Colors.transparent,
          borderRadius:BorderRadius.circular(13),
          clipBehavior:Clip.antiAlias,
          child:InkWell(
            onTap:()=>controller.goToPageReportePersonal(),
            splashColor:const Color(0xFF195496).withOpacity(.08),
            child:Ink(
              height:44,
              decoration:BoxDecoration(
                color:Colors.white,
                borderRadius:BorderRadius.circular(13),
                border:Border.all(
                  color:const Color(0xFFDCE4EC),
                ),
                boxShadow:[
                  BoxShadow(
                    color:const Color(0xFF17365D).withOpacity(.04),
                    blurRadius:7,
                    offset:const Offset(0,2),
                  ),
                ],
              ),
              child:const Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children:[
                  Icon(
                    Icons.groups_2_outlined,
                    color:Color(0xFF195496),
                    size:18,
                  ),
                  SizedBox(width:7),
                  Text(
                    'VER PERSONAL',
                    style:TextStyle(
                      color:Color(0xFF195496),
                      fontSize:9.5,
                      fontWeight:FontWeight.w900,
                      letterSpacing:.5,
                    ),
                  ),
                  SizedBox(width:6),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color:Color(0xFF195496),
                    size:11,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardBusqueda() {
    return Container(
      width:double.infinity,
      padding:const EdgeInsets.fromLTRB(11,10,11,11),
      decoration:BoxDecoration(
        color:Colors.white.withOpacity(.97),
        borderRadius:BorderRadius.circular(17),
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
        crossAxisAlignment:CrossAxisAlignment.start,
        children:[
          _tituloSeccion(
            icon:Icons.badge_outlined,
            titulo:'BUSCAR SERVIDOR',
            subtitulo:'Ingrese el número de cédula',
          ),
          const SizedBox(height:10),
          wgConsultaIdGenPersonaPorDocumento(),
        ],
      ),
    );
  }

  Widget _tituloSeccion({
    required IconData icon,
    required String titulo,
    required String subtitulo,
  }) {
    return Row(
      children:[
        Container(
          width:35,
          height:35,
          decoration:BoxDecoration(
            color:const Color(0xFFEAF1F8),
            borderRadius:BorderRadius.circular(10),
          ),
          child:Icon(
            icon,
            color:const Color(0xFF195496),
            size:18,
          ),
        ),
        const SizedBox(width:8),
        Expanded(
          child:Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children:[
              Text(
                titulo,
                style:const TextStyle(
                  color:Color(0xFF17365D),
                  fontSize:10.5,
                  fontWeight:FontWeight.w900,
                ),
              ),
              const SizedBox(height:1),
              Text(
                subtitulo,
                style:const TextStyle(
                  color:Color(0xFF7A8998),
                  fontSize:7.7,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget wgConsultaIdGenPersonaPorDocumento() {
    final responsive=ResponsiveUtil();

    return Row(
      crossAxisAlignment:CrossAxisAlignment.start,
      children:[
        Expanded(
          child:Form(
            key:controller.formKeyDocumento,
            child:ImputTextWidget(
              keyboardType:TextInputType.number,
              controller:controller.controllerDocumento,
              icono:Icon(
                Icons.assignment_ind_outlined,
                color:AppColors.colorIcons,
                size:responsive.diagonalP(AppConfig.tamIcons),
              ),
              label:SiipneStrings.cedula,
              fonSize:responsive.diagonalP(AppConfig.tamTextoTitulo),
              validar:validateDocumento,
            ),
          ),
        ),
        const SizedBox(width:8),
        Material(
          color:Colors.transparent,
          borderRadius:BorderRadius.circular(13),
          clipBehavior:Clip.antiAlias,
          child:InkWell(
            onTap:()=>controller.getDatosPersona(),
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
                    blurRadius:8,
                    offset:const Offset(0,3),
                  ),
                ],
              ),
              child:const Icon(
                Icons.search_rounded,
                color:Colors.white,
                size:21,
              ),
            ),
          ),
        ),
      ],
    );
  }

  String? validateDocumento(String? value) {
    if(value==null||value.length<10){
      return SiipneStrings.errorCedulaNoValida;
    }else if(controller.user.documento==controller.controllerDocumento.text){
      return SiipneStrings.ingreseCedulaDistinta;
    }

    return null;
  }

  Widget wgDatosPersona() {
    return Obx(
          ()=>controller.datosPerson.value.idGenPersona>0
          ?Padding(
        padding:const EdgeInsets.only(top:8),
        child:Container(
          width:double.infinity,
          padding:const EdgeInsets.all(11),
          decoration:BoxDecoration(
            gradient:const LinearGradient(
              begin:Alignment.centerLeft,
              end:Alignment.centerRight,
              colors:[
                Color(0xFFF0F5FB),
                Color(0xFFF8FAFC),
              ],
            ),
            borderRadius:BorderRadius.circular(16),
            border:Border.all(
              color:const Color(0xFF195496).withOpacity(.18),
            ),
          ),
          child:Row(
            children:[
              Container(
                width:48,
                height:48,
                decoration:BoxDecoration(
                  color:Colors.white,
                  shape:BoxShape.circle,
                  border:Border.all(
                    color:const Color(0xFF195496).withOpacity(.18),
                  ),
                  boxShadow:[
                    BoxShadow(
                      color:const Color(0xFF17365D).withOpacity(.07),
                      blurRadius:7,
                      offset:const Offset(0,2),
                    ),
                  ],
                ),
                child:const Icon(
                  Icons.person_rounded,
                  color:Color(0xFF195496),
                  size:24,
                ),
              ),
              const SizedBox(width:10),
              Expanded(
                child:Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children:[
                    Row(
                      children:[
                        const Text(
                          'SERVIDOR ENCONTRADO',
                          style:TextStyle(
                            color:Color(0xFF195496),
                            fontSize:6.8,
                            fontWeight:FontWeight.w900,
                            letterSpacing:.5,
                          ),
                        ),
                        const SizedBox(width:5),
                        Container(
                          width:6,
                          height:6,
                          decoration:const BoxDecoration(
                            color:Color(0xFF218A61),
                            shape:BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height:4),
                    Text(
                      controller.datosPerson.value.siglas.length>0
                          ?"${controller.datosPerson.value.siglas}.${controller.datosPerson.value.apenom}"
                          :controller.datosPerson.value.apenom,
                      maxLines:3,
                      overflow:TextOverflow.ellipsis,
                      style:const TextStyle(
                        color:Color(0xFF17365D),
                        fontSize:10.7,
                        fontWeight:FontWeight.w900,
                        height:1.12,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.verified_rounded,
                color:Color(0xFF218A61),
                size:20,
              ),
            ],
          ),
        ),
      )
          :const SizedBox.shrink(),
    );
  }

  Widget getCombos() {
    return Obx(
          ()=>controller.datosPerson.value.idGenPersona>0
          ?Padding(
        padding:const EdgeInsets.only(top:8),
        child:Container(
          width:double.infinity,
          padding:const EdgeInsets.fromLTRB(11,10,11,11),
          decoration:BoxDecoration(
            color:Colors.white.withOpacity(.97),
            borderRadius:BorderRadius.circular(17),
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
            crossAxisAlignment:CrossAxisAlignment.stretch,
            children:[
              _tituloSeccion(
                icon:Icons.account_tree_outlined,
                titulo:'ASIGNACIÓN POLICIAL',
                subtitulo:'Seleccione la unidad correspondiente',
              ),
              const SizedBox(height:10),
              getComboSubsistema(),
              getComboDireccionesPoliciales(),
              getComboEjesUnidadesPoliciales(),
            ],
          ),
        ),
      )
          :const SizedBox.shrink(),
    );
  }

  Widget getComboSubsistema() {
    return Obx(
          ()=>controller.datosPerson.value.idGenPersona>0
          ?Padding(
        padding:const EdgeInsets.only(bottom:8),
        child:Container(
          width:double.infinity,
          padding:const EdgeInsets.fromLTRB(7,7,7,5),
          decoration:BoxDecoration(
            color:const Color(0xFFF7F9FB),
            borderRadius:BorderRadius.circular(12),
            border:Border.all(
              color:const Color(0xFFE0E7ED),
            ),
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
      )
          :const SizedBox.shrink(),
    );
  }

  Widget getComboDireccionesPoliciales() {
    return Obx(
          ()=>controller.selectSubsistema.value.idDgoTipoEje>0
          ?Padding(
        padding:const EdgeInsets.only(bottom:8),
        child:Container(
          width:double.infinity,
          padding:const EdgeInsets.fromLTRB(7,7,7,5),
          decoration:BoxDecoration(
            color:const Color(0xFFF7F9FB),
            borderRadius:BorderRadius.circular(12),
            border:Border.all(
              color:const Color(0xFFE0E7ED),
            ),
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
        ),
      )
          :const SizedBox.shrink(),
    );
  }

  Widget getComboEjesUnidadesPoliciales() {
    return Obx(
          ()=>controller.selectDireccionPoliciales.value.idDgoTipoEje>0
          ?Container(
        width:double.infinity,
        padding:const EdgeInsets.fromLTRB(7,7,7,5),
        decoration:BoxDecoration(
          color:const Color(0xFFF7F9FB),
          borderRadius:BorderRadius.circular(12),
          border:Border.all(
            color:const Color(0xFFE0E7ED),
          ),
        ),
        child:ComboBusqueda(
          selectValue:controller.selectUnidadPolicial.value,
          showClearButton:false,
          datos:controller.listUnidadesPoliciales,
          displayField:(item)=>item.descripcion,
          searchHint:"Unidad Policial",
          complete:(value){
            controller.selectUnidadPolicial.value=UnidadesPoliciale.empty();

            if(value!=null){
              controller.selectUnidadPolicial.value=value;
              return;
            }
          },
          textSeleccioneUndato:"Seleccione una Unidad",
        ),
      )
          :const SizedBox.shrink(),
    );
  }

  Widget getBtnAgregar() {
    return Obx(
          ()=>controller.datosPerson.value.idGenPersona>0&&
          controller.selectUnidadPolicial.value.idDgoTipoEje>0
          ?Center(
        child:SizedBox(
          width:215,
          child:Material(
            color:Colors.transparent,
            borderRadius:BorderRadius.circular(14),
            clipBehavior:Clip.antiAlias,
            child:InkWell(
              onTap:(){
                if(controller.datosPerson.value.idGenPersona>0){
                  DialogosAwesome.getInformationSiNo(
                    descripcion:
                    "¿Está seguro/a de registrar a\n${controller.datosPerson.value.siglas} ${controller.datosPerson.value.apenom}?",
                    btnOkOnPress:(){
                      controller.addPersona();
                    },
                  );
                }
              },
              splashColor:Colors.white.withOpacity(.15),
              child:Ink(
                height:49,
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
                      Icons.person_add_alt_1_rounded,
                      color:Colors.white,
                      size:18,
                    ),
                    SizedBox(width:8),
                    Text(
                      'AGREGAR',
                      style:TextStyle(
                        color:Colors.white,
                        fontSize:10.5,
                        fontWeight:FontWeight.w900,
                        letterSpacing:.7,
                      ),
                    ),
                    SizedBox(width:7),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color:Colors.white,
                      size:15,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      )
          :const SizedBox.shrink(),
    );
  }
}
part of '../../pages.dart';

class CrearCodigoRecintosPage extends GetView<CrearCodigoRecintosController> {
  const CrearCodigoRecintosPage({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    final responsive=ResponsiveUtil();

    return WorkAreaPageWidget(
      showGps:true,
      title:"ABRIR RECINTO ELECTORAL",
      tamanoTitulo:18,
      mostrarBtnAtras:true,
      mostrarDatosServidor:true,
      imgPerfil:controller.user.foto,
      nombresServidor:controller.user.nombres?.toString(),
      sexoServidor:controller.user.sexo?.toString(),
      peticionServer:controller.peticionServerState,
      contenido:SingleChildScrollView(
        physics:const AlwaysScrollableScrollPhysics(),
        padding:const EdgeInsets.fromLTRB(8,6,8,20),
        child:Column(
          crossAxisAlignment:CrossAxisAlignment.stretch,
          children:[
            _cabeceraOperativo(),
            SizedBox(height:responsive.altoP(1.2)),
            _cardRecinto(),
            SizedBox(height:responsive.altoP(1.2)),
            _cardUnidadPolicial(responsive),
            SizedBox(height:responsive.altoP(1.2)),
            wgTelefono(),
            SizedBox(height:responsive.altoP(1.4)),
            btnCrear(),
          ],
        ),
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
              Icons.how_to_vote_outlined,
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
                  'OPERATIVO',
                  style:TextStyle(
                    color:Color(0xFF195496),
                    fontSize:7.5,
                    fontWeight:FontWeight.w900,
                    letterSpacing:.8,
                  ),
                ),
                const SizedBox(height:3),
                Text(
                  "${controller.selectProcesoOperativoController.selectProcesosOperativo.value.descProcElecc}",
                  softWrap:true,
                  maxLines:3,
                  overflow:TextOverflow.visible,
                  style:const TextStyle(
                    color:Color(0xFF17365D),
                    fontSize:12.2,
                    fontWeight:FontWeight.w800,
                    height:1.12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width:8),
          Container(
            width:31,
            height:31,
            decoration:const BoxDecoration(
              color:Color(0xFFEAF1F8),
              borderRadius:BorderRadius.all(Radius.circular(9)),
            ),
            child:const Icon(
              Icons.verified_outlined,
              color:Color(0xFF195496),
              size:17,
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardRecinto() {
    return Container(
      width:double.infinity,
      padding:const EdgeInsets.fromLTRB(12,11,12,12),
      decoration:BoxDecoration(
        color:Colors.white.withOpacity(.97),
        borderRadius:BorderRadius.circular(18),
        border:Border.all(color:const Color(0xFF195496).withOpacity(.10)),
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
                  Icons.location_city_outlined,
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
                      'RECINTO ELECTORAL',
                      style:TextStyle(
                        color:Color(0xFF17365D),
                        fontSize:12.5,
                        fontWeight:FontWeight.w900,
                      ),
                    ),
                    SizedBox(height:2),
                    Text(
                      'Seleccione el recinto electoral donde prestará servicio',
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
            padding:const EdgeInsets.fromLTRB(8,8,8,6),
            decoration:BoxDecoration(
              color:const Color(0xFFF7F9FB),
              borderRadius:BorderRadius.circular(13),
              border:Border.all(color:const Color(0xFFE0E7ED)),
            ),
            child:getComboRecintosElectorales(),
          ),
        ],
      ),
    );
  }

  Widget _cardUnidadPolicial(ResponsiveUtil responsive) {
    return Container(
      width:double.infinity,
      padding:const EdgeInsets.fromLTRB(12,11,12,12),
      decoration:BoxDecoration(
        color:Colors.white.withOpacity(.97),
        borderRadius:BorderRadius.circular(18),
        border:Border.all(color:const Color(0xFF195496).withOpacity(.10)),
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
                      'Seleccione la unidad policial correspondiente',
                      style:TextStyle(
                        color:Color(0xFF7A8998),
                        fontSize:8.5,
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
              border:Border.all(color:const Color(0xFFE0E7ED)),
            ),
            child:getCombosDinamicos(responsive),
          ),
        ],
      ),
    );
  }

  void desingRegistrarRecinto() {
    DialogosDesingWidget.getDialogoX(
      title:"Nuevo Recinto",
      contenido:RegistrarRecintoWidget(
        formKey:controller.formKeyRegRecinto,
        controllerNombreRecinto:controller.controllerNombreRecinto,
        foto:controller.mGaleryCameraModel,
        onGuardar:(){
          ///Guardar recinto
        },
      ),
    );
  }

  Widget getComboRecintosElectorales() {
    return Obx(
          ()=>ComboBusquedaRecintos(
        onNoEncuentroRecinto:(){
          desingRegistrarRecinto();
        },
        showNoEncuentroRecinto:controller.selectProcesoOperativoController.selectProcesosOperativo.value.permitirAgregarRecintos,
        selectValue:controller.selectRecintosElectoral.value,
        showClearButton:false,
        icon:Icons.home_work_rounded,
        datos:controller.listRecintosElectorales.value,
        displayField:(item)=>item.validado?item.nomRecintoElec+" (VALIDADO)":item.nomRecintoElec,
        searchHint:"Recinto Electoral",
        textSeleccioneUndato:"Seleccione un Recinto",
        complete:(value){
          print("value $value");
          controller.selectRecintosElectoral.value=value??RecintosElectoral();
        },
      ),
    );
  }

  Widget getCombosDinamicos(ResponsiveUtil responsive) {
    return DynamicComboWidget(
      controller:controller.dynamicComboUnidadesPoliciales,
      responsive:responsive,
    );
  }

  Widget wgTelefono() {
    return Obx(
          ()=>AnimatedSwitcher(
        duration:const Duration(milliseconds:30),
        child:controller.dynamicComboUnidadesPoliciales.showBtnGuardar.value
            ?Container(
          key:const ValueKey('telefono_visible'),
          width:double.infinity,
          padding:const EdgeInsets.fromLTRB(12,11,12,12),
          decoration:BoxDecoration(
            color:Colors.white.withOpacity(.97),
            borderRadius:BorderRadius.circular(18),
            border:Border.all(color:const Color(0xFF195496).withOpacity(.10)),
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
                      Icons.phone_outlined,
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
                          'DATOS DE CONTACTO',
                          style:TextStyle(
                            color:Color(0xFF17365D),
                            fontSize:12.5,
                            fontWeight:FontWeight.w900,
                          ),
                        ),
                        SizedBox(height:2),
                        Text(
                          'Ingrese un número telefónico de contacto',
                          style:TextStyle(
                            color:Color(0xFF7A8998),
                            fontSize:8.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height:10),
              Container(
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
              ),
            ],
          ),
        )
            :const SizedBox.shrink(key:ValueKey('telefono_oculto')),
      ),
    );
  }

  Widget btnCrear() {
    return Obx(
          ()=>AnimatedSwitcher(
        duration:const Duration(milliseconds:30),
        child:controller.dynamicComboUnidadesPoliciales.showBtnGuardar.value&&
            controller.selectRecintosElectoral.value.idDgoReciElect>0
            ?Center(
          key:const ValueKey('btn_crear_visible'),
          child:SizedBox(
            width:220,
            child:_botonCrearCodigo(),
          ),
        )
            :const SizedBox.shrink(key:ValueKey('btn_crear_oculto')),
      ),
    );
  }

  Widget _botonCrearCodigo() {
    return Material(
      color:Colors.transparent,
      borderRadius:BorderRadius.circular(14),
      clipBehavior:Clip.antiAlias,
      child:InkWell(
        onTap:(){
          controller.msjCrearCodigo(
            onPressed:(){
              controller.crearCodigo();
            },
          );
        },
        splashColor:Colors.white.withOpacity(.15),
        child:Ink(
          height:50,
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
                color:const Color(0xFF195496).withOpacity(.23),
                blurRadius:11,
                offset:const Offset(0,4),
              ),
            ],
          ),
          child:const Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children:[
              Icon(
                Icons.add_circle_outline_rounded,
                color:Colors.white,
                size:20,
              ),
              SizedBox(width:8),
              Text(
                'CREAR CÓDIGO',
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
}
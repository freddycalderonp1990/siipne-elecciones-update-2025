part of '../pages.dart';

class CensistaPage extends GetView<CensistaController> {
  const CensistaPage({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Obx(
          ()=>WorkAreaPageCensoWidget(
        onPressBtnAtras:(){
          if(controller.showBtnValidarFoto.value){
            controller.showBtnValidarFoto.value=false;
          }else{
            Get.back();
          }
        },
        showGps:true,
        mostrarBtnAtras:true,
        title:controller.showBtnValidarFoto.value
            ?"REGISTRAR FOTOGRAFÍA"
            :"CENSISTA",
        contenido:Column(
          children:[
            Obx(
                  ()=>controller.showBtnValidarFoto.value
                  ?const SizedBox.shrink()
                  :DesingFotoNameWidget(
                img:controller.user.foto,
                sexo:controller.user.sexo,
                nombres:controller.user.nombres,
              ),
            ),

            Expanded(
              child:getContenido(),
            ),

            Obx((){
              if(controller.mGaleryCameraModel.value!=null){
                WidgetsBinding.instance.addPostFrameCallback((_){
                  if(controller.scrollController.hasClients){
                    controller.scrollController.animateTo(
                      controller.scrollController.position.maxScrollExtent,
                      duration:const Duration(milliseconds:400),
                      curve:Curves.easeOut,
                    );
                  }
                });
              }

              return const SizedBox.shrink();
            }),
          ],
        ),
        peticionServer:controller.peticionServerState,
      ),
    );
  }

  Widget getContenido() {
    return Obx(
          ()=>controller.showBtnValidarFoto.value
          ?desingValidar()
          :SingleChildScrollView(
        controller:controller.scrollController,
        physics:const BouncingScrollPhysics(),
        padding:const EdgeInsets.fromLTRB(9,6,9,22),
        child:getContenidoCensado(),
      ),
    );
  }

  Widget getContenidoCensado() {
    final responsive=ResponsiveUtil();

    return Column(
      crossAxisAlignment:CrossAxisAlignment.stretch,
      children:[
        _cabeceraCenso(),
        SizedBox(height:responsive.altoP(1)),
        wgConsultarRecinto(),
        SizedBox(height:responsive.altoP(1)),
        wgDatosCenso(),
        SizedBox(height:responsive.altoP(2)),
      ],
    );
  }

  Widget _cabeceraCenso() {
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
              Icons.assignment_ind_outlined,
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
                  'GESTIÓN DE CENSO',
                  style:TextStyle(
                    color:Color(0xFF17365D),
                    fontSize:12,
                    fontWeight:FontWeight.w900,
                  ),
                ),
                SizedBox(height:2),
                Text(
                  'Ingrese el código asignado para continuar con el registro',
                  style:TextStyle(
                    color:Color(0xFF7A8998),
                    fontSize:8,
                    height:1.15,
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
              color:const Color(0xFFEAF5EE),
              borderRadius:BorderRadius.circular(20),
            ),
            child:const Row(
              mainAxisSize:MainAxisSize.min,
              children:[
                Icon(
                  Icons.circle,
                  color:Color(0xFF218A61),
                  size:6,
                ),
                SizedBox(width:4),
                Text(
                  'CENSISTA',
                  style:TextStyle(
                    color:Color(0xFF218A61),
                    fontSize:6.4,
                    fontWeight:FontWeight.w900,
                  ),
                ),
              ],
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
      padding:const EdgeInsets.fromLTRB(11,10,11,11),
      decoration:BoxDecoration(
        color:Colors.white,
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
            icon:Icons.qr_code_scanner_rounded,
            titulo:'CONSULTAR CENSO',
            subtitulo:'Ingrese el código proporcionado',
          ),

          const SizedBox(height:10),

          Row(
            crossAxisAlignment:CrossAxisAlignment.start,
            children:[
              Expanded(
                child:Form(
                  key:controller.formKey,
                  child:ImputTextWidget(
                    keyboardType:TextInputType.number,
                    controller:controller.controllerCodigoCenso,
                    icono:Icon(
                      Icons.numbers_rounded,
                      color:AppColors.colorIcons,
                      size:responsive.diagonalP(AppConfig.tamIcons),
                    ),
                    label:SiipneStrings.codigo,
                    fonSize:responsive.diagonalP(AppConfig.tamTextoTitulo),
                    validar:validateCodigoRecinto,
                  ),
                ),
              ),

              const SizedBox(width:8),

              Material(
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
          ),
        ],
      ),
    );
  }

  Widget _tituloSeccion({
    required IconData icon,
    required String titulo,
    required String subtitulo,
    Color color=const Color(0xFF195496),
    Color fondo=const Color(0xFFEAF1F8),
  }) {
    return Row(
      children:[
        Container(
          width:35,
          height:35,
          decoration:BoxDecoration(
            color:fondo,
            borderRadius:BorderRadius.circular(10),
          ),
          child:Icon(
            icon,
            color:color,
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

  String? validateCodigoRecinto(String? value) {
    String msj="Código del censo no valido";

    if(value!=null&&value.length>0){
      int? codigoRecinto=int.tryParse(value);

      if(codigoRecinto==null){
        print("El valor ingresado no es un número entero válido.");
        return msj;
      }

      return null;
    }

    return msj;
  }

  Widget wgDatosCenso() {
    final responsive=ResponsiveUtil();

    return Obx(
          ()=>controller.dataPerCenso.value.idDgpPerCenso>0
          ?Column(
        children:[
          _datosCensoCard(),
          SizedBox(height:responsive.altoP(1)),
          wgFoto(),
          SizedBox(height:responsive.altoP(1.5)),
          btnValidar(),
        ],
      )
          :const SizedBox.shrink(),
    );
  }

  Widget _datosCensoCard() {
    return Container(
      width:double.infinity,
      decoration:BoxDecoration(
        color:Colors.white,
        borderRadius:BorderRadius.circular(17),
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
          childrenPadding:const EdgeInsets.fromLTRB(
            10,
            0,
            10,
            10,
          ),
          collapsedIconColor:const Color(0xFF195496),
          iconColor:const Color(0xFF195496),
          leading:Container(
            width:38,
            height:38,
            decoration:BoxDecoration(
              color:const Color(0xFFEAF1F8),
              borderRadius:BorderRadius.circular(11),
            ),
            child:const Icon(
              Icons.assignment_turned_in_outlined,
              color:Color(0xFF195496),
              size:19,
            ),
          ),
          title:const Text(
            'DATOS DEL CENSO',
            style:TextStyle(
              color:Color(0xFF17365D),
              fontSize:10.8,
              fontWeight:FontWeight.w900,
            ),
          ),
          subtitle:const Text(
            'Información asociada al código consultado',
            style:TextStyle(
              color:Color(0xFF7A8998),
              fontSize:7.4,
            ),
          ),
          children:[
            Container(
              width:double.infinity,
              padding:const EdgeInsets.all(10),
              decoration:BoxDecoration(
                color:const Color(0xFFF7F9FB),
                borderRadius:BorderRadius.circular(13),
                border:Border.all(
                  color:const Color(0xFFE1E7ED),
                ),
              ),
              child:Column(
                children:[
                  _filaDato(
                    icon:Icons.event_note_outlined,
                    titulo:'Proceso',
                    detalle:controller.dataPerCenso.value.proceso,
                  ),

                  _separadorDato(),

                  _filaDato(
                    icon:Icons.location_city_outlined,
                    titulo:'Recinto',
                    detalle:controller.dataPerCenso.value.recintoAsignado,
                  ),

                  _separadorDato(),

                  _filaDato(
                    icon:Icons.table_restaurant_outlined,
                    titulo:'Mesa',
                    detalle:controller.dataPerCenso.value.mesaAsignado,
                  ),

                  _separadorDato(),

                  _filaDato(
                    icon:Icons.person_outline_rounded,
                    titulo:'Censado',
                    detalle:"${controller.dataPerCenso.value.nameCensado}",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filaDato({
    required IconData icon,
    required String titulo,
    required String detalle,
  }) {
    return Row(
      crossAxisAlignment:CrossAxisAlignment.start,
      children:[
        Container(
          width:31,
          height:31,
          decoration:BoxDecoration(
            color:const Color(0xFFEAF1F8),
            borderRadius:BorderRadius.circular(8),
          ),
          child:Icon(
            icon,
            color:const Color(0xFF195496),
            size:15,
          ),
        ),

        const SizedBox(width:8),

        Expanded(
          child:Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children:[
              Text(
                titulo.toUpperCase(),
                style:const TextStyle(
                  color:Color(0xFF7A8998),
                  fontSize:6.4,
                  fontWeight:FontWeight.w900,
                  letterSpacing:.4,
                ),
              ),

              const SizedBox(height:2),

              Text(
                detalle,
                style:const TextStyle(
                  color:Color(0xFF17365D),
                  fontSize:9.5,
                  fontWeight:FontWeight.w800,
                  height:1.15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _separadorDato() {
    return const Padding(
      padding:EdgeInsets.symmetric(vertical:7),
      child:Divider(
        height:1,
        color:Color(0xFFE1E7ED),
      ),
    );
  }

  Widget wgFoto() {
    final responsive=ResponsiveUtil();

    return Container(
      width:double.infinity,
      padding:const EdgeInsets.fromLTRB(11,10,11,11),
      decoration:BoxDecoration(
        color:Colors.white,
        borderRadius:BorderRadius.circular(17),
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
      child:Column(
        children:[
          _tituloSeccion(
            icon:Icons.photo_camera_outlined,
            titulo:'FOTOGRAFÍA DEL CENSADO',
            subtitulo:'Capture una fotografía actual para continuar',
            color:const Color(0xFFD68A1F),
            fondo:const Color(0xFFFFF3E4),
          ),

          const SizedBox(height:11),

          Obx(
                ()=>controller.mGaleryCameraModel.value==null
                ?_capturarFotografia(responsive)
                :_fotografiaCapturada(responsive),
          ),
        ],
      ),
    );
  }

  Widget _capturarFotografia(ResponsiveUtil responsive) {
    return Material(
      color:Colors.transparent,
      borderRadius:BorderRadius.circular(14),
      clipBehavior:Clip.antiAlias,
      child:InkWell(
        onTap:() async {
          if(controller.dataPerCenso.value.estadoCenso!="iniciado"){
            DialogosAwesome.getInformation(
              descripcion:
              "Para continuar, asegúrese de que se  haya completado el registro del formulario en el sistema SIIPNE 3W."
                  "\nSolo después podrá registrar la fotografía.",
            );

            controller.dataPerCenso.value=DataPerCenso.empty();
            controller.dataPerCensoList.clear();
            return;
          }

          controller.mGaleryCameraModel.value=
          await PhotoHelper.getDesingPictureGaleryOrCamera(
            onlyCamera:true,
            initPeticion:(value){
              controller.peticionServerState(value);
            },
            titleImg:"",
          );
        },
        child:Ink(
          width:double.infinity,
          height:76,
          decoration:BoxDecoration(
            color:const Color(0xFFF7F9FB),
            borderRadius:BorderRadius.circular(14),
            border:Border.all(
              color:const Color(0xFFDCE4EC),
            ),
          ),
          child:Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children:[
              Container(
                width:44,
                height:44,
                decoration:BoxDecoration(
                  color:const Color(0xFFEAF1F8),
                  borderRadius:BorderRadius.circular(12),
                ),
                child:const Icon(
                  Icons.add_a_photo_outlined,
                  color:Color(0xFF195496),
                  size:21,
                ),
              ),

              const SizedBox(width:10),

              const Column(
                mainAxisAlignment:MainAxisAlignment.center,
                crossAxisAlignment:CrossAxisAlignment.start,
                children:[
                  Text(
                    'REGISTRAR FOTOGRAFÍA',
                    style:TextStyle(
                      color:Color(0xFF17365D),
                      fontSize:9.7,
                      fontWeight:FontWeight.w900,
                    ),
                  ),

                  SizedBox(height:2),

                  Text(
                    'Utilice la cámara del dispositivo',
                    style:TextStyle(
                      color:Color(0xFF7A8998),
                      fontSize:7.3,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fotografiaCapturada(ResponsiveUtil responsive) {
    return Column(
      children:[
        ClipRRect(
          borderRadius:BorderRadius.circular(15),
          child:Image.file(
            controller.mGaleryCameraModel.value!.imageFile,
            fit:BoxFit.cover,
            height:responsive.altoP(26),
            width:double.infinity,
          ),
        ),

        const SizedBox(height:8),

        Center(
          child:SizedBox(
            width:190,
            child:Material(
              color:Colors.transparent,
              borderRadius:BorderRadius.circular(11),
              clipBehavior:Clip.antiAlias,
              child:InkWell(
                onTap:() async {
                  controller.mGaleryCameraModel.value=
                  await PhotoHelper.getDesingPictureGaleryOrCamera(
                    onlyCamera:true,
                    initPeticion:(value){
                      controller.peticionServerState(value);
                    },
                    titleImg:"",
                  );
                },
                child:Ink(
                  height:40,
                  decoration:BoxDecoration(
                    color:const Color(0xFFEAF1F8),
                    borderRadius:BorderRadius.circular(11),
                  ),
                  child:const Row(
                    mainAxisAlignment:MainAxisAlignment.center,
                    children:[
                      Icon(
                        Icons.refresh_rounded,
                        color:Color(0xFF195496),
                        size:16,
                      ),

                      SizedBox(width:6),

                      Text(
                        'CAMBIAR FOTOGRAFÍA',
                        style:TextStyle(
                          color:Color(0xFF195496),
                          fontSize:8,
                          fontWeight:FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget btnValidar() {
    return Obx(
          ()=>controller.mGaleryCameraModel.value!=null
          ?_botonPrincipal(
        icon:Icons.arrow_forward_rounded,
        titulo:'SIGUIENTE',
        onPressed:(){
          controller.validacionFacialCompleta.value=false;
          controller.validarFoto();
        },
      )
          :const SizedBox.shrink(),
    );
  }

  Widget btnRegistrar() {
    return Obx(
          (){
        if(controller.mGaleryCameraModel.value==null){
          return const SizedBox.shrink();
        }

        final bool habilitado=
            controller.validacionFacialCompleta.value;

        return Column(
          children:[
            _botonPrincipal(
              icon:habilitado
                  ?Icons.save_outlined
                  :Icons.lock_outline_rounded,
              titulo:habilitado
                  ?'GUARDAR'
                  :'ESPERE VALIDACIÓN',
              habilitado:habilitado,
              onPressed:(){
                DialogosAwesome.getWarningSiNoContador(
                  title:"¿Está seguro que desea finalizar el proceso de censo?",
                  descripcion:
                  "Al confirmar, se guardará la foto registrada y el censo quedará concluido.",
                  btnOkOnPress:(){
                    controller.SaveCensusPersonPhotoUseCaseServer();
                  },
                );
              },
            ),

            if(!habilitado)...[
              const SizedBox(height:7),

              const Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children:[
                  SizedBox(
                    width:10,
                    height:10,
                    child:CircularProgressIndicator(
                      strokeWidth:1.5,
                      color:Color(0xFF195496),
                    ),
                  ),

                  SizedBox(width:6),

                  Text(
                    'El botón se habilitará al completar el análisis',
                    style:TextStyle(
                      color:Color(0xFF7A8998),
                      fontSize:6.8,
                      fontWeight:FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ],
        );
      },
    );
  }
  Widget _botonPrincipal({
    required IconData icon,
    required String titulo,
    required VoidCallback onPressed,
    bool habilitado=true,
  }) {
    return Center(
      child:SizedBox(
        width:215,
        child:AnimatedOpacity(
          duration:const Duration(milliseconds:250),
          opacity:habilitado?1:.62,
          child:Material(
            color:Colors.transparent,
            borderRadius:BorderRadius.circular(14),
            clipBehavior:Clip.antiAlias,
            child:InkWell(
              onTap:habilitado?onPressed:null,
              splashColor:Colors.white.withOpacity(.15),
              child:Ink(
                height:49,
                decoration:BoxDecoration(
                  gradient:habilitado
                      ?const LinearGradient(
                    begin:Alignment.topLeft,
                    end:Alignment.bottomRight,
                    colors:[
                      Color(0xFF123F75),
                      Color(0xFF195496),
                      Color(0xFF2869AC),
                    ],
                  )
                      :const LinearGradient(
                    begin:Alignment.topLeft,
                    end:Alignment.bottomRight,
                    colors:[
                      Color(0xFF8997A5),
                      Color(0xFF748493),
                    ],
                  ),
                  borderRadius:BorderRadius.circular(14),
                  boxShadow:habilitado
                      ?[
                    BoxShadow(
                      color:const Color(0xFF195496).withOpacity(.22),
                      blurRadius:10,
                      offset:const Offset(0,4),
                    ),
                  ]
                      :[],
                ),
                child:Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children:[
                    Icon(
                      icon,
                      color:Colors.white,
                      size:18,
                    ),

                    const SizedBox(width:8),

                    Text(
                      titulo,
                      style:const TextStyle(
                        color:Colors.white,
                        fontSize:10.3,
                        fontWeight:FontWeight.w900,
                        letterSpacing:.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget desingValidar() {
    final responsive=ResponsiveUtil();

    final Uint8List? imgMemory=
    PhotoHelper.convertStringToUint8List(
      controller.dataFotoDgp.value.foto,
    );

    return SingleChildScrollView(
      physics:const BouncingScrollPhysics(),
      padding:const EdgeInsets.fromLTRB(9,6,9,18),
      child:Column(
        crossAxisAlignment:CrossAxisAlignment.stretch,
        children:[
          _cabeceraValidacion(),

          const SizedBox(height:10),

          Container(
            width:double.infinity,
            padding:const EdgeInsets.all(8),
            decoration:BoxDecoration(
              color:const Color(0xFFF7F9FB),
              borderRadius:BorderRadius.circular(17),
              border:Border.all(
                color:const Color(0xFFE0E7ED),
              ),
            ),
            child:Row(
              crossAxisAlignment:CrossAxisAlignment.start,
              children:[
                Expanded(
                  child:_cardFotoComparacion(
                    titulo:'FOTO CÁMARA',
                    subtitulo:'Capturada actualmente',
                    icon:Icons.photo_camera_outlined,
                    child:FotoConEscaneo(
                      child:Image.file(
                        controller.mGaleryCameraModel.value!.imageFile,
                        fit:BoxFit.cover,
                        width:double.infinity,
                        height:double.infinity,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width:8),

                Expanded(
                  child:_cardFotoComparacion(
                    titulo:'FOTO CREDENCIAL',
                    subtitulo:'Registro institucional',
                    icon:Icons.badge_outlined,
                    child:imgMemory!=null
                        ?FotoConEscaneo(
                      child:Image.memory(
                        imgMemory,
                        fit:BoxFit.cover,
                        width:double.infinity,
                        height:double.infinity,
                      ),
                    )
                        :Container(
                      color:const Color(0xFFF0F3F6),
                      alignment:Alignment.center,
                      child:Column(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children:[
                          Image.asset(
                            AppImages.iconNoImg,
                            width:responsive.anchoP(17),
                          ),

                          const SizedBox(height:5),

                          const Text(
                            'SIN FOTOGRAFÍA',
                            style:TextStyle(
                              color:Color(0xFF8997A5),
                              fontSize:6.5,
                              fontWeight:FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height:9),
          ValidacionFacialVisual(
            onFinalizado:(){
              controller.validacionFacialCompleta.value=true;
            },
          ),
          const SizedBox(height:9),
          Container(
            width:double.infinity,
            padding:const EdgeInsets.symmetric(
              horizontal:10,
              vertical:9,
            ),
            decoration:BoxDecoration(
              color:const Color(0xFFFFF8EA),
              borderRadius:BorderRadius.circular(12),
              border:Border.all(
                color:const Color(0xFFE8B75C).withOpacity(.25),
              ),
            ),
            child:const Row(
              children:[
                Icon(
                  Icons.info_outline_rounded,
                  color:Color(0xFFD68A1F),
                  size:16,
                ),

                SizedBox(width:7),

                Expanded(
                  child:Text(
                    'Verifique visualmente que ambas fotografías correspondan a la misma persona antes de guardar.',
                    style:TextStyle(
                      color:Color(0xFF7C6948),
                      fontSize:12,
                      height:1.2,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height:responsive.altoP(1.5)),

          btnRegistrar(),

          SizedBox(height:responsive.altoP(1)),
        ],
      ),
    );
  }

  Widget _cabeceraValidacion() {
    return Container(
      width:double.infinity,
      padding:const EdgeInsets.fromLTRB(11,10,11,10),
      decoration:BoxDecoration(
        color:Colors.white,
        borderRadius:BorderRadius.circular(16),
        border:Border.all(
          color:const Color(0xFFDCE4EC),
        ),
        boxShadow:[
          BoxShadow(
            color:const Color(0xFF17365D).withOpacity(.05),
            blurRadius:10,
            offset:const Offset(0,3),
          ),
        ],
      ),
      child:Row(
        children:[
          Container(
            width:40,
            height:40,
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
              borderRadius:BorderRadius.circular(11),
            ),
            child:const Icon(
              Icons.face_retouching_natural_outlined,
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
                  'VALIDACIÓN VISUAL ASISTIDA',
                  style:TextStyle(
                    color:Color(0xFF17365D),
                    fontSize:10.5,
                    fontWeight:FontWeight.w900,
                  ),
                ),

                SizedBox(height:2),

                Text(
                  'Compare ambas fotografías antes de finalizar el censo',
                  style:TextStyle(
                    color:Colors.black,
                    fontSize:7.5,
                    height:1.15,
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
              color:const Color(0xFFEAF5EE),
              borderRadius:BorderRadius.circular(20),
            ),
            child:const Row(
              mainAxisSize:MainAxisSize.min,
              children:[
                Icon(
                  Icons.circle,
                  color:Color(0xFF218A61),
                  size:6,
                ),

                SizedBox(width:4),

                Text(
                  'ANÁLISIS',
                  style:TextStyle(
                    color:Color(0xFF218A61),
                    fontSize:6.2,
                    fontWeight:FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardFotoComparacion({
    required String titulo,
    required String subtitulo,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      height:310,
      decoration:BoxDecoration(
        color:Colors.white,
        borderRadius:BorderRadius.circular(15),
        border:Border.all(
          color:const Color(0xFFDCE4EC),
        ),
        boxShadow:[
          BoxShadow(
            color:const Color(0xFF17365D).withOpacity(.05),
            blurRadius:8,
            offset:const Offset(0,3),
          ),
        ],
      ),
      child:Column(
        children:[
          Container(
            width:double.infinity,
            padding:const EdgeInsets.fromLTRB(8,8,8,7),
            decoration:const BoxDecoration(
              color:Color(0xFFF7F9FB),
              borderRadius:BorderRadius.vertical(
                top:Radius.circular(15),
              ),
            ),
            child:Row(
              children:[
                Container(
                  width:29,
                  height:29,
                  decoration:BoxDecoration(
                    color:const Color(0xFFEAF1F8),
                    borderRadius:BorderRadius.circular(8),
                  ),
                  child:Icon(
                    icon,
                    color:const Color(0xFF195496),
                    size:14,
                  ),
                ),

                const SizedBox(width:6),

                Expanded(
                  child:Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children:[
                      Text(
                        titulo,
                        maxLines:1,
                        overflow:TextOverflow.ellipsis,
                        style:const TextStyle(
                          color:Color(0xFF17365D),
                          fontSize:7.8,
                          fontWeight:FontWeight.w900,
                        ),
                      ),

                      const SizedBox(height:1),

                      Text(
                        subtitulo,
                        maxLines:1,
                        overflow:TextOverflow.ellipsis,
                        style:const TextStyle(
                          color:Color(0xFF7A8998),
                          fontSize:5.9,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child:Padding(
              padding:const EdgeInsets.all(5),
              child:ClipRRect(
                borderRadius:BorderRadius.circular(11),
                child:Container(
                  width:double.infinity,
                  height:double.infinity,
                  color:const Color(0xFFF0F3F6),
                  child:child,
                ),
              ),
            ),
          ),

          Container(
            width:double.infinity,
            padding:const EdgeInsets.symmetric(
              horizontal:8,
              vertical:6,
            ),
            decoration:const BoxDecoration(
              color:Color(0xFFFAFBFC),
              borderRadius:BorderRadius.vertical(
                bottom:Radius.circular(15),
              ),
            ),
            child:const Row(
              mainAxisAlignment:MainAxisAlignment.center,
              children:[
                Icon(
                  Icons.visibility_outlined,
                  color:Color(0xFF7A8998),
                  size:12,
                ),

                SizedBox(width:4),

                Text(
                  'VERIFICACIÓN VISUAL',
                  style:TextStyle(
                    color:Color(0xFF7A8998),
                    fontSize:5.8,
                    fontWeight:FontWeight.w800,
                    letterSpacing:.3,
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

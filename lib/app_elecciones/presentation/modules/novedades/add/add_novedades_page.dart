part of '../../pages.dart';

class AddNovedadesPage extends GetView<AddNovedadesController> {
  const AddNovedadesPage({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(
      mostrarBtnAtras:true,
      title:"REGISTRAR NOVEDADES",
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
      padding:const EdgeInsets.fromLTRB(8,6,8,22),
      child:Column(
        crossAxisAlignment:CrossAxisAlignment.stretch,
        children:[
          Obx(
                ()=>controller.showVerNovedades.value
                ?_btnVerNovedades()
                :const SizedBox.shrink(),
          ),

          SizedBox(height:responsive.altoP(1)),

          _cardSeleccionNovedad(),

          SizedBox(height:responsive.altoP(1)),

          Obx(
                ()=>wgCajasTexto(
              controller.selectTipoNovedad.value.descripcion,
            ),
          ),

          Obx(
                ()=>wgCajasTextoNovedades(
              controller.selectNovedad.value.idDgoNovedadesElect,
              responsive,
            ),
          ),

          Obx(
                ()=>controller.mostrarFoto.value
                ?Padding(
              padding:const EdgeInsets.only(top:8),
              child:wgFoto(responsive),
            )
                :const SizedBox.shrink(),
          ),

          SizedBox(height:responsive.altoP(1.5)),

          getBtnGuardar(),

          SizedBox(height:responsive.altoP(2)),
        ],
      ),
    );
  }

  Widget _cabeceraRegistro() {
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
              Icons.add_alert_outlined,
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
                  'REGISTRO DE NOVEDAD',
                  style:TextStyle(
                    color:Color(0xFF17365D),
                    fontSize:12,
                    fontWeight:FontWeight.w900,
                  ),
                ),
                SizedBox(height:2),
                Text(
                  'Seleccione el tipo de novedad e ingrese la información requerida',
                  style:TextStyle(
                    color:Color(0xFF7A8998),
                    fontSize:8,
                    height:1.15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _btnVerNovedades() {
    return Center(
      child:SizedBox(
        width:210,
        child:Material(
          color:Colors.transparent,
          borderRadius:BorderRadius.circular(13),
          clipBehavior:Clip.antiAlias,
          child:InkWell(
            onTap:()=>controller.goToPageReporteNovedades(),
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
                    Icons.assignment_outlined,
                    color:Color(0xFF195496),
                    size:18,
                  ),
                  SizedBox(width:7),
                  Text(
                    'VER NOVEDADES',
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

  Widget _cardSeleccionNovedad() {
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
        crossAxisAlignment:CrossAxisAlignment.stretch,
        children:[
          _tituloSeccion(
            icon:Icons.account_tree_outlined,
            titulo:'CLASIFICACIÓN DE NOVEDAD',
            subtitulo:'Seleccione el tipo y detalle correspondiente',
          ),

          const SizedBox(height:10),

          getComboTipoNovedad(),

          getComboNovedades(),

          getComboDelito(),
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

  Widget getComboTipoNovedad() {
    return Container(
      width:double.infinity,
      padding:const EdgeInsets.fromLTRB(7,7,7,5),
      margin:const EdgeInsets.only(bottom:8),
      decoration:BoxDecoration(
        color:const Color(0xFFF7F9FB),
        borderRadius:BorderRadius.circular(12),
        border:Border.all(
          color:const Color(0xFFE0E7ED),
        ),
      ),
      child:Obx(
            ()=>ComboBusqueda(
          selectValue:controller.selectTipoNovedad.value,
          showClearButton:false,
          datos:controller.listTipoNovedades,
          displayField:(item)=>item.descripcion,
          searchHint:"Tipo Novedad",
          complete:(value){
            controller.selectTipoNovedad.value=NovedadesElectorale.empty();
            controller.selectNovedad.value=NovedadesElectorale.empty();
            controller.selectDelito.value=NovedadesElectorale.empty();

            if(value!=null){
              controller.selectTipoNovedad.value=value;
              controller.getNovedadesHijas(value.idDgoNovedadesElect);
              return;
            }
          },
          textSeleccioneUndato:"Seleccione un Tipo de Novedad",
        ),
      ),
    );
  }

  Widget getComboNovedades() {
    return Obx(
          ()=>controller.selectTipoNovedad.value.idDgoNovedadesElect>0
          ?Container(
        width:double.infinity,
        padding:const EdgeInsets.fromLTRB(7,7,7,5),
        margin:const EdgeInsets.only(bottom:8),
        decoration:BoxDecoration(
          color:const Color(0xFFF7F9FB),
          borderRadius:BorderRadius.circular(12),
          border:Border.all(
            color:const Color(0xFFE0E7ED),
          ),
        ),
        child:ComboBusqueda(
          selectValue:controller.selectNovedad.value,
          showClearButton:false,
          datos:controller.listNovedades,
          displayField:(item)=>item.descripcion,
          searchHint:
          controller.selectTipoNovedad.value.descripcion.isNotEmpty
              ?controller.selectTipoNovedad.value.descripcion[0].toUpperCase()+
              controller.selectTipoNovedad.value.descripcion.substring(1).toLowerCase()
              :'',
          complete:(value){
            controller.selectNovedad.value=NovedadesElectorale.empty();
            controller.selectDelito.value=NovedadesElectorale.empty();

            controller.mostrarBtnGuardar(false);

            if(value!=null){
              controller.selectNovedad.value=value;

              if(value.tieneHijos){
                controller.getNovedadesDelito(value.idDgoNovedadesElect);
              }else if(
              controller.selectNovedad.value.idDgoNovedadesElect>0
              ){
                controller.mostrarBtnGuardar(true);
              }

              return;
            }
          },
          textSeleccioneUndato:"Seleccione una Novedad",
        ),
      )
          :const SizedBox.shrink(),
    );
  }

  Widget getComboDelito() {
    return Obx(
          ()=>controller.selectNovedad.value.idDgoNovedadesElect>0&&
          controller.selectNovedad.value.tieneHijos
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
          selectValue:controller.selectDelito.value,
          showClearButton:false,
          datos:controller.listDelito,
          displayField:(item)=>item.descripcion,
          searchHint:
          controller.selectNovedad.value.descripcion.isNotEmpty
              ?controller.selectNovedad.value.descripcion[0].toUpperCase()+
              controller.selectNovedad.value.descripcion.substring(1).toLowerCase()
              :'',
          complete:(value){
            controller.selectDelito.value=NovedadesElectorale.empty();
            controller.mostrarBtnGuardar(false);

            if(value!=null){
              controller.selectDelito.value=value;

              if(controller.selectDelito.value.idDgoNovedadesElect>0){
                controller.mostrarBtnGuardar(true);
              }

              return;
            }
          },
          textSeleccioneUndato:"Seleccione el Delito",
        ),
      )
          :const SizedBox.shrink(),
    );
  }

  Widget wgCajasTexto(String novedadesPadres) {
    Widget wg=Container();
    final responsive=ResponsiveUtil();

    controller.validarForm=false;
    controller.registrarDatosPersona=false;

    switch((novedadesPadres??'').trim().toUpperCase()){
      case "NOVEDADES":
        controller.registrarDatosPersona=false;
        break;

      case "DELITOS":
        controller.validarForm=true;

        if(controller.selectNovedad.value.idDgoNovedadesElect>0){
          wg=wgTxtCedula(
            responsive:responsive,
          );

          controller.registrarDatosPersona=true;
        }
        break;

      case "DETENIDOS":
        controller.validarForm=true;

        if(controller.selectNovedad.value.idDgoNovedadesElect>0){
          wg=wgTxtCedulaBoleta(responsive);
          controller.registrarDatosPersona=true;
        }
        break;

      case "CITACIONES":
        controller.validarForm=true;
        wg=wgTxtCedulaCitacion(responsive);
        controller.registrarDatosPersona=true;
        break;

      case "VOTO EN CASA":
        controller.validarForm=true;
        wg=wgTxtObservacion(
          responsive:responsive,
        );
        break;

      case "NOV PPL":
        controller.validarForm=true;
        wg=wgTxtObservacion(
          responsive:responsive,
        );
        break;

      case "UMO":
        break;

      default:
        wg=Container();
    }

    if(wg is Container){
      return wg;
    }

    return _cardInformacionAdicional(
      child:wg,
    );
  }

  Widget _cardInformacionAdicional({
    required Widget child,
  }) {
    return Container(
      width:double.infinity,
      margin:const EdgeInsets.only(top:8),
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
            blurRadius:10,
            offset:const Offset(0,3),
          ),
        ],
      ),
      child:Column(
        crossAxisAlignment:CrossAxisAlignment.stretch,
        children:[
          _tituloSeccion(
            icon:Icons.description_outlined,
            titulo:'INFORMACIÓN ADICIONAL',
            subtitulo:'Complete los datos requeridos para esta novedad',
          ),

          const SizedBox(height:10),

          child,
        ],
      ),
    );
  }

  Widget wgCajasTextoNovedades(
      int idDgoNovedadesElect,
      ResponsiveUtil responsive,
      ) {
    Widget wg=Container();

    bool mostrarFoto=false;

    switch(idDgoNovedadesElect){
      case 17:
        wg=Container();
        break;

      case 18:
        controller.validarForm=true;
        wg=wgTxtObservacion(
          responsive:responsive,
        );
        break;

      case 19:
        wg=wgTxtHora(responsive);
        controller.validarForm=true;
        break;

      case 20:
        wg=wgTxtMotivo(responsive);
        controller.validarForm=true;
        mostrarFoto=true;
        break;

      case 21:
        wg=wgTxtCedula(
          responsive:responsive,
          title:SiipneStrings.cedulaSP,
        );

        controller.validarForm=true;
        mostrarFoto=true;
        controller.registrarDatosPersona=true;
        break;

      case 22:
        wg=Column(
          children:[
            wgTxtNumeroManifestantes(responsive),
            SizedBox(height:responsive.altoP(1)),
            _escalaCantidad(responsive),
          ],
        );

        controller.validarForm=true;
        mostrarFoto=true;
        break;

      case 23:
        controller.validarForm=true;
        mostrarFoto=true;

        wg=Column(
          children:[
            wgTxtNumeroQuemaUrnas(responsive),
            SizedBox(height:responsive.altoP(1)),
            _escalaCantidad(responsive),
          ],
        );
        break;

      case 28:
        controller.validarForm=true;
        mostrarFoto=true;

        wg=Column(
          children:[
            wgTxtNumeroTomaRecintos(responsive),
            SizedBox(height:responsive.altoP(1)),
            _escalaCantidad(responsive),
          ],
        );
        break;

      case 29:
        wg=Container();
        mostrarFoto=true;
        break;

      case 30:
        controller.validarForm=true;
        mostrarFoto=true;
        controller.registrarDatosPersona=true;

        wg=wgTxtCedulaTelefono(
          responsive:responsive,
        );
        break;

      case 31:
        controller.validarForm=true;

        wg=wgTxtCedulaTelefono(
          responsive:responsive,
          title:SiipneStrings.cedulaSP,
        );
        break;

      case 32:
        wg=wgTxtNumerico(responsive);
        controller.validarForm=true;
        break;

      case 33:
        wg=wgTxtNumericoPersonal(responsive);
        controller.validarForm=true;
        break;

      case 34:
      case 35:
      case 36:
      case 37:
        wg=wgorganizacionDirigenteCantidad(responsive);
        controller.validarForm=true;
        break;

      case 45:
      case 46:
        wg=wgTxtDesplazamientosAutoridades(responsive);
        controller.validarForm=true;
        break;

      case 47:
        wg=wgTxtApoyoMediosComunicacion(responsive);
        controller.validarForm=true;
        break;

      case 41:
        wg=wgTxtSeguridadPersonasImportantes(responsive);
        controller.validarForm=true;
        break;

      case 42:
        wg=wgTxtSeguridadInstalaciones(responsive);
        controller.validarForm=true;
        mostrarFoto=true;
        break;

      case 43:
        wg=wgTxtExplosivos(responsive);
        controller.validarForm=true;
        mostrarFoto=true;
        break;

      case 44:
        wg=wgTxtApoyoUnidadesPoliciales(responsive);
        controller.validarForm=true;
        break;

      case 49:
      case 50:
      case 51:
      case 52:
      case 53:
        wg=wgTxtNumerico(responsive);
        controller.validarForm=true;
        break;

      case 54:
      case 55:
        wg=wgTxtHora(responsive);
        controller.validarForm=true;
        break;

      default:
        mostrarFoto=false;
        wg=Container();
    }

    if(controller.mostrarFoto.value!=mostrarFoto){
      WidgetsBinding.instance.addPostFrameCallback((_){
        controller.mostrarFoto.value=mostrarFoto;
      });
    }

    print("asigno registrarDatosPersona ${controller.registrarDatosPersona}");
    print("wgCajasTextoNovedades validarForm ${controller.validarForm}");

    if(wg is Container){
      return wg;
    }

    return _cardInformacionAdicional(
      child:wg,
    );
  }

  Widget _escalaCantidad(
      ResponsiveUtil responsive,
      ) {
    return Container(
      width:double.infinity,
      padding:const EdgeInsets.all(9),
      decoration:BoxDecoration(
        color:const Color(0xFFF7F9FB),
        borderRadius:BorderRadius.circular(12),
        border:Border.all(
          color:const Color(0xFFE1E7ED),
        ),
      ),
      child:Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children:[
          const Text(
            'ESCALA DE REFERENCIA',
            style:TextStyle(
              color:Color(0xFF68798A),
              fontSize:7,
              fontWeight:FontWeight.w900,
              letterSpacing:.4,
            ),
          ),

          const SizedBox(height:7),

          Row(
            children:[
              Expanded(
                child:getBtnColores(
                  responsive:responsive,
                  color:Colors.green.withOpacity(.8),
                  title:"1-50",
                ),
              ),

              const SizedBox(width:5),

              Expanded(
                child:getBtnColores(
                  responsive:responsive,
                  color:Colors.yellow.withOpacity(.8),
                  title:"51-200",
                ),
              ),

              const SizedBox(width:5),

              Expanded(
                child:getBtnColores(
                  responsive:responsive,
                  color:Colors.orange.withOpacity(.8),
                  title:"201-500",
                ),
              ),

              const SizedBox(width:5),

              Expanded(
                child:getBtnColores(
                  responsive:responsive,
                  color:Colors.red.withOpacity(.8),
                  title:"501-Más",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getBtnColores({
    required ResponsiveUtil responsive,
    required String title,
    required Color color,
  }) {
    return Container(
      height:30,
      alignment:Alignment.center,
      decoration:BoxDecoration(
        color:color,
        borderRadius:BorderRadius.circular(9),
        border:Border.all(
          color:Colors.black.withOpacity(.06),
        ),
      ),
      child:Text(
        title,
        textAlign:TextAlign.center,
        style:const TextStyle(
          color:Color(0xFF263238),
          fontSize:7.5,
          fontWeight:FontWeight.w800,
        ),
      ),
    );
  }

  Widget wgorganizacionDirigenteCantidad(
      ResponsiveUtil responsive,
      ) {
    return Column(
      children:[
        wgTxtNumeroManifestantes(responsive),

        SizedBox(height:responsive.altoP(1)),

        _escalaCantidad(responsive),
      ],
    );
  }

  Widget wgFoto(
      ResponsiveUtil responsive,
      ) {
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
        crossAxisAlignment:CrossAxisAlignment.stretch,
        children:[
          _tituloSeccion(
            icon:Icons.photo_camera_outlined,
            titulo:'EVIDENCIA FOTOGRÁFICA',
            subtitulo:'Adjunte una imagen relacionada con la novedad',
            color:const Color(0xFFD68A1F),
            fondo:const Color(0xFFFFF3E4),
          ),

          const SizedBox(height:11),

          Obx(
                ()=>controller.mGaleryCameraModel.value==null
                ?_btnTomarFoto(responsive)
                :Column(
              children:[
                ClipRRect(
                  borderRadius:BorderRadius.circular(14),
                  child:Image.file(
                    controller.mGaleryCameraModel.value!.imageFile,
                    fit:BoxFit.cover,
                    width:double.infinity,
                    height:responsive.altoP(26),
                  ),
                ),

                const SizedBox(height:8),

                Center(
                  child:SizedBox(
                    width:180,
                    child:_btnCambiarFoto(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _btnTomarFoto(
      ResponsiveUtil responsive,
      ) {
    return Material(
      color:Colors.transparent,
      borderRadius:BorderRadius.circular(13),
      clipBehavior:Clip.antiAlias,
      child:InkWell(
        onTap:() async {
          controller.mGaleryCameraModel.value=
          await PhotoHelper.getDesingPictureGaleryOrCamera(
            initPeticion:(value){
              controller.peticionServerState(value);
            },
            titleImg:
            "ImgRecElectNovedades_id_${controller.selectNovedad.value.idDgoNovedadesElect}",
          );
        },
        child:Ink(
          height:74,
          decoration:BoxDecoration(
            color:const Color(0xFFF7F9FB),
            borderRadius:BorderRadius.circular(13),
            border:Border.all(
              color:const Color(0xFFDCE4EC),
            ),
          ),
          child:Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children:[
              Container(
                width:42,
                height:42,
                decoration:BoxDecoration(
                  color:const Color(0xFFEAF1F8),
                  borderRadius:BorderRadius.circular(11),
                ),
                child:const Icon(
                  Icons.add_a_photo_outlined,
                  color:Color(0xFF195496),
                  size:21,
                ),
              ),

              const SizedBox(width:9),

              const Column(
                mainAxisAlignment:MainAxisAlignment.center,
                crossAxisAlignment:CrossAxisAlignment.start,
                children:[
                  Text(
                    'REGISTRAR IMAGEN',
                    style:TextStyle(
                      color:Color(0xFF17365D),
                      fontSize:9.5,
                      fontWeight:FontWeight.w900,
                    ),
                  ),
                  SizedBox(height:2),
                  Text(
                    'Cámara o galería',
                    style:TextStyle(
                      color:Color(0xFF7A8998),
                      fontSize:7.4,
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

  Widget _btnCambiarFoto() {
    return Material(
      color:Colors.transparent,
      borderRadius:BorderRadius.circular(11),
      clipBehavior:Clip.antiAlias,
      child:InkWell(
        onTap:() async {
          controller.mGaleryCameraModel.value=
          await PhotoHelper.getDesingPictureGaleryOrCamera(
            initPeticion:(value){
              controller.peticionServerState(value);
            },
            titleImg:
            "ImgRecElectNovedades_id_${controller.selectNovedad.value.idDgoNovedadesElect}",
          );
        },
        child:Ink(
          height:39,
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
                'CAMBIAR IMAGEN',
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
    );
  }

  Widget getBtnGuardar() {
    return Obx(
          ()=>controller.mostrarBtnGuardar.value&&
          controller.selectTipoNovedad.value.idDgoNovedadesElect>0
          ?Center(
        child:SizedBox(
          width:215,
          child:Material(
            color:Colors.transparent,
            borderRadius:BorderRadius.circular(14),
            clipBehavior:Clip.antiAlias,
            child:InkWell(
              onTap:(){
                String descripcion=
                    controller.selectNovedad.value.descripcion;

                if(controller.selectDelito.value.idDgoNovedadesElect>0){
                  descripcion=
                      controller.selectDelito.value.descripcion;
                }

                DialogosAwesome.getWarningSiNo(
                  title:'¿Desea continuar con el registro?',
                  descripcion:
                  'Registro de Novedad:\n\n• ${descripcion.capitalizeFirst}',
                  btnOkOnPress:(){
                    controller.eventoRegistrarNovedadesElectorales();
                  },
                );
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
                      Icons.save_outlined,
                      color:Colors.white,
                      size:18,
                    ),
                    SizedBox(width:8),
                    Text(
                      'GUARDAR NOVEDAD',
                      style:TextStyle(
                        color:Colors.white,
                        fontSize:10,
                        fontWeight:FontWeight.w900,
                        letterSpacing:.6,
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

  // ==================== FORM ====================

  Widget getForm({
    required Widget child,
  }) {
    return Form(
      key:controller.formKey,
      child:child,
    );
  }

  Widget wgTxtCedula({
    required ResponsiveUtil responsive,
    String title=SiipneStrings.cedula,
  }) {
    return getForm(
      child:Column(
        children:[
          getWgCedulaWithFind(responsive),
        ],
      ),
    );
  }

  Widget wgTxtCedulaTelefono({
    required ResponsiveUtil responsive,
    String title=SiipneStrings.cedula,
  }) {
    return getForm(
      child:Column(
        children:[
          getWgCedulaWithFind(responsive),
          WgTxtTelefono(
            controllerTelefono:controller.controllerTelefono,
          ),
        ],
      ),
    );
  }

  Widget wgTxtObservacion({
    required ResponsiveUtil responsive,
    String title=SiipneStrings.cedula,
  }) {
    return getForm(
      child:Column(
        crossAxisAlignment:CrossAxisAlignment.stretch,
        children:[
          const Text(
            'OBSERVACIÓN',
            style:TextStyle(
              color:Color(0xFF17365D),
              fontSize:8.5,
              fontWeight:FontWeight.w900,
            ),
          ),

          const SizedBox(height:7),

          MyTextAreaWidget(
            hintText:"Ingrese la Observación",
            maxLength:100,
            controller:controller.controllerObservacion,
            onChanged:(texto){},
          ),
        ],
      ),
    );
  }

  Widget getSelectNacionalExtranjero() {
    return Obx(
          ()=>RadioGroup<String>(
        groupValue:controller.selectedOptionNAcionalExtranjero.value,
        onChanged:(String? value){
          if(value!=null){
            controller.selectedOptionNAcionalExtranjero.value=value;
          }
        },
        child:Container(
          margin:const EdgeInsets.only(bottom:8),
          padding:const EdgeInsets.all(6),
          decoration:BoxDecoration(
            color:const Color(0xFFF7F9FB),
            borderRadius:BorderRadius.circular(12),
            border:Border.all(
              color:const Color(0xFFE1E7ED),
            ),
          ),
          child:Row(
            children:[
              Expanded(
                child:ListTile(
                  dense:true,
                  contentPadding:const EdgeInsets.symmetric(horizontal:4),
                  title:const Text(
                    'Nacional',
                    style:TextStyle(
                      color:Color(0xFF17365D),
                      fontSize:8.5,
                      fontWeight:FontWeight.w700,
                    ),
                  ),
                  leading:const Radio<String>(
                    value:'Nacional',
                  ),
                ),
              ),

              Expanded(
                child:ListTile(
                  dense:true,
                  contentPadding:const EdgeInsets.symmetric(horizontal:4),
                  title:const Text(
                    'Extranjero',
                    style:TextStyle(
                      color:Color(0xFF17365D),
                      fontSize:8.5,
                      fontWeight:FontWeight.w700,
                    ),
                  ),
                  leading:const Radio<String>(
                    value:'Extranjero',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget wgTxtCedulaBoleta(
      ResponsiveUtil responsive,
      ) {
    return getForm(
      child:Column(
        children:[
          wgFoto(responsive),

          getSelectNacionalExtranjero(),

          ImputTextWidget(
            keyboardType:TextInputType.text,
            controller:controller.controllerNumBoleta,
            icono:Icon(
              Icons.assignment_sharp,
              color:AppColors.colorIcons,
              size:controller.sizeIcons,
            ),
            label:SiipneStrings.numBoleta,
            fonSize:responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar:Validate.validateNumBoleta,
          ),

          getWgCedulaWithFind(responsive),
        ],
      ),
    );
  }

  Widget getWgCedulaWithFind(
      ResponsiveUtil responsive,{
        bool validar=true,
      }) {
    return Column(
      children:[
        Row(
          crossAxisAlignment:CrossAxisAlignment.start,
          children:[
            Expanded(
              child:ImputTextWidget(
                keyboardType:TextInputType.number,
                controller:controller.controllerCedula,
                icono:Icon(
                  Icons.assignment_sharp,
                  color:AppColors.colorIcons,
                  size:controller.sizeIcons,
                ),
                label:SiipneStrings.cedula,
                fonSize:responsive.diagonalP(AppConfig.tamTextoTitulo),
                validar:
                controller.selectedOptionNAcionalExtranjero=="Nacional"
                    ?Validate.validateCedula
                    :null,
              ),
            ),

            const SizedBox(width:8),

            Material(
              color:Colors.transparent,
              borderRadius:BorderRadius.circular(12),
              clipBehavior:Clip.antiAlias,
              child:InkWell(
                onTap:(){
                  bool validar=
                  controller.selectedOptionNAcionalExtranjero=="Nacional"
                      ?true
                      :false;

                  if(controller.selectTipoNovedad.value.descripcion!="DETENIDOS"){
                    validar=false;
                  }

                  controller.getDatosPersona(
                    permitirAll:true,
                  );
                },
                child:Ink(
                  width:47,
                  height:47,
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
                    Icons.search_rounded,
                    color:Colors.white,
                    size:20,
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height:responsive.altoP(1)),

        wgDatosPersona(),
      ],
    );
  }

  Widget wgTxtCedulaCitacion(
      ResponsiveUtil responsive,
      ) {
    return getForm(
      child:Column(
        children:[
          ImputTextWidget(
            keyboardType:TextInputType.text,
            controller:controller.controllerNumCitacion,
            icono:Icon(
              Icons.assignment_sharp,
              color:AppColors.colorIcons,
              size:controller.sizeIcons,
            ),
            label:SiipneStrings.numCitacion,
            fonSize:responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar:Validate.validateNumCitacion,
          ),

          getWgCedulaWithFind(responsive),
        ],
      ),
    );
  }

  Widget wgTxtMotivo(
      ResponsiveUtil responsive,
      ) {
    return getForm(
      child:ImputTextWidget(
        keyboardType:TextInputType.text,
        controller:controller.controllerMotivo,
        icono:Icon(
          Icons.assignment_sharp,
          color:AppColors.colorIcons,
          size:controller.sizeIcons,
        ),
        label:"Motivo",
        fonSize:responsive.diagonalP(AppConfig.tamTextoTitulo),
        validar:Validate.validateMotivo,
      ),
    );
  }

  Widget wgTxtNumericoPersonal(
      ResponsiveUtil responsive,
      ) {
    return getForm(
      child:ImputTextWidget(
        keyboardType:TextInputType.number,
        controller:controller.controllerNumericoPersonal,
        icono:Icon(
          Icons.assignment_sharp,
          color:AppColors.colorIcons,
          size:controller.sizeIcons,
        ),
        label:"Númerico del Personal",
        fonSize:responsive.diagonalP(AppConfig.tamTextoTitulo),
        validar:Validate.validateNumPersonal,
      ),
    );
  }

  Widget wgTxtNumeroManifestantes(
      responsive,
      ) {
    return getForm(
      child:Column(
        children:[
          ImputTextWidget(
            keyboardType:TextInputType.text,
            controller:controller.controllerOrganizacion,
            icono:Icon(
              Icons.category,
              color:AppColors.colorIcons,
              size:controller.sizeIcons,
            ),
            label:"Organización Social o Política",
            fonSize:responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar:Validate.validateOrganizacion,
          ),

          ImputTextWidget(
            keyboardType:TextInputType.text,
            controller:controller.controllerDirigente,
            icono:Icon(
              Icons.category,
              color:AppColors.colorIcons,
              size:controller.sizeIcons,
            ),
            label:"Dirigente",
            fonSize:responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar:Validate.validateDirigente,
          ),

          ImputTextWidget(
            keyboardType:TextInputType.number,
            controller:controller.controllerCantidad,
            onChanged:(valor){
              if(valor!=null){
                if(int.parse(valor)>100){}
              }
            },
            icono:Icon(
              Icons.assignment_sharp,
              color:AppColors.colorIcons,
              size:controller.sizeIcons,
            ),
            label:"Cantidad",
            fonSize:responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar:Validate.validateCantidad,
          ),
        ],
      ),
    );
  }

  Widget wgTxtNumeroQuemaUrnas(
      responsive,
      ) {
    return getForm(
      child:Column(
        children:[
          ImputTextWidget(
            keyboardType:TextInputType.text,
            controller:controller.controllerOrganizacion,
            icono:Icon(
              Icons.category,
              color:AppColors.colorIcons,
              size:controller.sizeIcons,
            ),
            label:"Organización Social o Política",
            fonSize:responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar:Validate.validateOrganizacion,
          ),

          ImputTextWidget(
            keyboardType:TextInputType.text,
            controller:controller.controllerDirigente,
            icono:Icon(
              Icons.category,
              color:AppColors.colorIcons,
              size:controller.sizeIcons,
            ),
            label:"Dirigente",
            fonSize:responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar:Validate.validateDirigente,
          ),

          ImputTextWidget(
            keyboardType:TextInputType.number,
            controller:controller.controllerCantidad,
            icono:Icon(
              Icons.assignment_sharp,
              color:AppColors.colorIcons,
              size:controller.sizeIcons,
            ),
            label:"Cantidad",
            fonSize:responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar:Validate.validateCantidad,
          ),
        ],
      ),
    );
  }

  Widget wgTxtNumeroTomaRecintos(
      responsive,
      ) {
    return getForm(
      child:Column(
        children:[
          ImputTextWidget(
            keyboardType:TextInputType.text,
            controller:controller.controllerOrganizacion,
            icono:Icon(
              Icons.category,
              color:AppColors.colorIcons,
              size:controller.sizeIcons,
            ),
            label:"Organización Social o Política",
            fonSize:responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar:Validate.validateOrganizacion,
          ),

          ImputTextWidget(
            keyboardType:TextInputType.text,
            controller:controller.controllerDirigente,
            icono:Icon(
              Icons.category,
              color:AppColors.colorIcons,
              size:controller.sizeIcons,
            ),
            label:"Dirigente",
            fonSize:responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar:Validate.validateDirigente,
          ),

          ImputTextWidget(
            keyboardType:TextInputType.number,
            controller:controller.controllerCantidad,
            icono:Icon(
              Icons.assignment_sharp,
              color:AppColors.colorIcons,
              size:controller.sizeIcons,
            ),
            label:"Cantidad",
            fonSize:responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar:Validate.validateCantidad,
          ),
        ],
      ),
    );
  }

  Widget wgTxtDesplazamientosAutoridades(
      responsive,
      ) {
    return getForm(
      child:Column(
        children:[
          ImputTextWidget(
            keyboardType:TextInputType.text,
            controller:controller.controllerNombre,
            icono:Icon(
              Icons.assignment_sharp,
              color:AppColors.colorIcons,
              size:controller.sizeIcons,
            ),
            label:"Nombre",
            fonSize:responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar:Validate.validateNombre,
          ),

          ImputTextWidget(
            keyboardType:TextInputType.text,
            controller:controller.controllerCargo,
            icono:Icon(
              Icons.category,
              color:AppColors.colorIcons,
              size:controller.sizeIcons,
            ),
            label:"Cargo/Función",
            fonSize:responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar:Validate.validateCargo,
          ),

          ImputTextWidget(
            keyboardType:TextInputType.text,
            controller:controller.controllerGrado,
            icono:Icon(
              Icons.assignment_sharp,
              color:AppColors.colorIcons,
              size:controller.sizeIcons,
            ),
            label:"Grado (Opcional)",
            fonSize:responsive.diagonalP(AppConfig.tamTextoTitulo),
          ),
        ],
      ),
    );
  }

  Widget wgTxtApoyoMediosComunicacion(
      responsive,
      ) {
    return getForm(
      child:Column(
        children:[
          ImputTextWidget(
            keyboardType:TextInputType.text,
            controller:controller.controllerNombre,
            icono:Icon(
              Icons.assignment_sharp,
              color:AppColors.colorIcons,
              size:controller.sizeIcons,
            ),
            label:"Nombre",
            fonSize:responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar:Validate.validateNombre,
          ),

          ImputTextWidget(
            keyboardType:TextInputType.text,
            controller:controller.controllerMedioComunicacion,
            icono:Icon(
              Icons.category,
              color:AppColors.colorIcons,
              size:controller.sizeIcons,
            ),
            label:"Medio de Comunicación",
            fonSize:responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar:Validate.validateMedioComunicacion,
          ),
        ],
      ),
    );
  }

  Widget wgTxtSeguridadPersonasImportantes(
      responsive,
      ) {
    return getForm(
      child:Column(
        children:[
          ImputTextWidget(
            keyboardType:TextInputType.text,
            controller:controller.controllerFuncion,
            icono:Icon(
              Icons.assignment_sharp,
              color:AppColors.colorIcons,
              size:controller.sizeIcons,
            ),
            label:"Función",
            fonSize:responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar:Validate.validateFuncion,
          ),

          ImputTextWidget(
            keyboardType:TextInputType.text,
            controller:controller.controllerNombre,
            icono:Icon(
              Icons.assignment_sharp,
              color:AppColors.colorIcons,
              size:controller.sizeIcons,
            ),
            label:"Nombres",
            fonSize:responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar:Validate.validateNombre,
          ),
        ],
      ),
    );
  }

  Widget wgTxtSeguridadInstalaciones(
      responsive,
      ) {
    return getForm(
      child:Column(
        children:[
          ImputTextWidget(
            keyboardType:TextInputType.text,
            controller:controller.controllerInstalacion,
            icono:Icon(
              Icons.assignment_sharp,
              color:AppColors.colorIcons,
              size:controller.sizeIcons,
            ),
            label:"Nombre Instalación",
            fonSize:responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar:Validate.validateInstalacion,
          ),

          ImputTextWidget(
            keyboardType:TextInputType.text,
            controller:controller.controllerDescripcion,
            icono:Icon(
              Icons.assignment_sharp,
              color:AppColors.colorIcons,
              size:controller.sizeIcons,
            ),
            label:"Descripción",
            fonSize:responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar:Validate.validateDescripcion,
          ),
        ],
      ),
    );
  }

  Widget wgTxtExplosivos(
      responsive,
      ) {
    return getForm(
      child:Column(
        children:[
          ImputTextWidget(
            keyboardType:TextInputType.text,
            controller:controller.controllerDireccion,
            icono:Icon(
              Icons.assignment_sharp,
              color:AppColors.colorIcons,
              size:controller.sizeIcons,
            ),
            label:"Dirección",
            fonSize:responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar:Validate.validateDireccion,
          ),

          ImputTextWidget(
            keyboardType:TextInputType.text,
            controller:controller.controllerDescripcion,
            icono:Icon(
              Icons.assignment_sharp,
              color:AppColors.colorIcons,
              size:controller.sizeIcons,
            ),
            label:"Descripción",
            fonSize:responsive.diagonalP(AppConfig.tamTextoTitulo),
            validar:Validate.validateDescripcion,
          ),
        ],
      ),
    );
  }

  Widget wgTxtApoyoUnidadesPoliciales(
      responsive,
      ) {
    return getForm(
      child:ImputTextWidget(
        keyboardType:TextInputType.text,
        controller:controller.controllerUnidad,
        icono:Icon(
          Icons.assignment_sharp,
          color:AppColors.colorIcons,
          size:controller.sizeIcons,
        ),
        label:"Unidad",
        fonSize:responsive.diagonalP(AppConfig.tamTextoTitulo),
        validar:Validate.validateUnidad,
      ),
    );
  }

  Widget wgTxtHora(
      ResponsiveUtil responsive,
      ) {
    return getForm(
      child:Row(
        children:[
          Expanded(
            child:getComboHora(responsive),
          ),

          const SizedBox(width:8),

          Expanded(
            child:getComboMinuto(responsive),
          ),
        ],
      ),
    );
  }

  Widget getComboHora(
      ResponsiveUtil responsive,
      ) {
    List<String> datos=controller.datosHora;

    return ComboBusqueda(
      selectValue:controller.selectHora,
      showClearButton:false,
      datos:datos,
      displayField:(item)=>item,
      searchHint:"Hora",
      complete:(value){
        if(value!=null){
          controller.selectHora=value;
          return;
        }
      },
      textSeleccioneUndato:"Seleccione la Hora",
    );
  }

  Widget getComboMinuto(
      ResponsiveUtil responsive,
      ) {
    List<String> datos=controller.datosMinuto;

    return ComboBusqueda(
      selectValue:controller.selectMinuto,
      showClearButton:false,
      datos:datos,
      displayField:(item)=>item,
      searchHint:"Minuto",
      complete:(value){
        if(value!=null){
          controller.selectMinuto=value;
          return;
        }
      },
      textSeleccioneUndato:"Seleccione Minuto",
    );
  }

  Widget wgTxtNumerico(
      responsive,
      ) {
    return getForm(
      child:ImputTextWidget(
        keyboardType:TextInputType.number,
        controller:controller.controllerNumerico,
        icono:Icon(
          Icons.assignment_sharp,
          color:AppColors.colorIcons,
          size:controller.sizeIcons,
        ),
        label:"Numérico",
        fonSize:responsive.diagonalP(AppConfig.tamTextoTitulo),
        validar:Validate.validateNumerico,
      ),
    );
  }

  Widget wgDatosPersona() {
    return Obx(
          ()=>controller.datosPerson.value.idGenPersona>0
          ?Container(
        width:double.infinity,
        padding:const EdgeInsets.all(10),
        decoration:BoxDecoration(
          color:const Color(0xFFF0F5FB),
          borderRadius:BorderRadius.circular(13),
          border:Border.all(
            color:const Color(0xFF195496).withOpacity(.18),
          ),
        ),
        child:Row(
          children:[
            Container(
              width:39,
              height:39,
              decoration:BoxDecoration(
                color:Colors.white,
                shape:BoxShape.circle,
                border:Border.all(
                  color:const Color(0xFF195496).withOpacity(.16),
                ),
              ),
              child:const Icon(
                Icons.person_rounded,
                color:Color(0xFF195496),
                size:19,
              ),
            ),

            const SizedBox(width:8),

            Expanded(
              child:Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children:[
                  const Text(
                    'PERSONA IDENTIFICADA',
                    style:TextStyle(
                      color:Color(0xFF195496),
                      fontSize:6.5,
                      fontWeight:FontWeight.w900,
                      letterSpacing:.4,
                    ),
                  ),

                  const SizedBox(height:3),

                  Text(
                    controller.datosPerson.value.siglas.length>0
                        ?"${controller.datosPerson.value.siglas}.${controller.datosPerson.value.apenom}"
                        :controller.datosPerson.value.apenom,
                    maxLines:3,
                    overflow:TextOverflow.ellipsis,
                    style:const TextStyle(
                      color:Color(0xFF17365D),
                      fontSize:9.5,
                      fontWeight:FontWeight.w900,
                      height:1.10,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.verified_rounded,
              color:Color(0xFF218A61),
              size:19,
            ),
          ],
        ),
      )
          :const SizedBox.shrink(),
    );
  }
}
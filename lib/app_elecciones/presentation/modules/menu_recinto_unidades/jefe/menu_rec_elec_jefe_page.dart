part of '../../pages.dart';

class MenuRecElecJefePage extends GetView<MenuRecElecJefeController> {
  const MenuRecElecJefePage({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(
      title:"${controller.recintosElectoralesAbiertos.nomRecintoElec}",
      showGps:true,
      mostrarDatosServidor:true,
      mostrarBtnAtras: false,
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
          _cabeceraProceso(),
          SizedBox(height:responsive.altoP(1.2)),
          _wgCodigoRecinto(responsive),
          SizedBox(height:responsive.altoP(1.4)),
          _tituloAcciones(),
          SizedBox(height:responsive.altoP(1)),
          _getMenuJefe(responsive),
          SizedBox(height:responsive.altoP(2.3)),
          _botonSalir(),
        ],
      ),
    );
  }

  Widget _cabeceraProceso() {
    return Container(
      width:double.infinity,
      padding:const EdgeInsets.fromLTRB(12,10,12,10),
      decoration:BoxDecoration(
        color:Colors.white.withOpacity(.96),
        borderRadius:BorderRadius.circular(16),
        border:Border.all(color:const Color(0xFF195496).withOpacity(.09)),
        boxShadow:[BoxShadow(color:const Color(0xFF17365D).withOpacity(.06),blurRadius:13,offset:const Offset(0,4))],
      ),
      child:Row(
        children:[
          Container(
            width:40,
            height:40,
            decoration:BoxDecoration(
              gradient:const LinearGradient(begin:Alignment.topLeft,end:Alignment.bottomRight,colors:[Color(0xFF123F75),Color(0xFF2869AC)]),
              borderRadius:BorderRadius.circular(12),
            ),
            child:const Icon(Icons.how_to_vote_outlined,color:Colors.white,size:20),
          ),
          const SizedBox(width:10),
          Expanded(
            child:Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children:[
                const Text('PROCESO ELECTORAL',style:TextStyle(color:Color(0xFF195496),fontSize:7.5,fontWeight:FontWeight.w900,letterSpacing:.8)),
                const SizedBox(height:4),
                Text(
                  "${controller.recintosElectoralesAbiertos.descProcElecc}",
                  maxLines:2,
                  overflow:TextOverflow.ellipsis,
                  style:const TextStyle(color:Color(0xFF17365D),fontSize:12.5,fontWeight:FontWeight.w800,height:1.15),
                ),
              ],
            ),
          ),
          const SizedBox(width:8),
          Container(
            padding:const EdgeInsets.symmetric(horizontal:8,vertical:5),
            decoration:BoxDecoration(color:const Color(0xFFEAF5EE),borderRadius:BorderRadius.circular(20)),
            child:const Row(
              mainAxisSize:MainAxisSize.min,
              children:[
                Icon(Icons.circle,color:Color(0xFF319461),size:6),
                SizedBox(width:4),
                Text('ABIERTO',style:TextStyle(color:Color(0xFF287850),fontSize:6.8,fontWeight:FontWeight.w900,letterSpacing:.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _wgCodigoRecinto(ResponsiveUtil responsive) {
    return Container(
      width:double.infinity,
      decoration:BoxDecoration(
        color:Colors.white.withOpacity(.97),
        borderRadius:BorderRadius.circular(18),
        border:Border.all(color:const Color(0xFF195496).withOpacity(.10)),
        boxShadow:[BoxShadow(color:const Color(0xFF17365D).withOpacity(.07),blurRadius:14,offset:const Offset(0,5))],
      ),
      child:Column(
        children:[
          Container(
            height:4,
            decoration:const BoxDecoration(
              borderRadius:BorderRadius.only(topLeft:Radius.circular(18),topRight:Radius.circular(18)),
              gradient:LinearGradient(colors:[Color(0xFF123F75),Color(0xFF195496),Color(0xFF2869AC)]),
            ),
          ),
          Padding(
            padding:const EdgeInsets.fromLTRB(12,10,12,10),
            child:Row(
              children:[
                Container(
                  width:56,
                  height:56,
                  decoration:BoxDecoration(
                    color:const Color(0xFFEAF1F8),
                    borderRadius:BorderRadius.circular(15),
                    border:Border.all(color:const Color(0xFF195496).withOpacity(.10)),
                  ),
                  child:const Icon(Icons.numbers_rounded,color:Color(0xFF195496),size:27),
                ),
                const SizedBox(width:11),
                Expanded(
                  child:Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children:[
                      const Text('CÓDIGO DEL RECINTO',style:TextStyle(color:Color(0xFF748596),fontSize:7.5,fontWeight:FontWeight.w800,letterSpacing:.8)),
                      const SizedBox(height:3),
                      Text(
                        "${controller.recintosElectoralesAbiertos.idDgoCreaOpReci}",
                        style:const TextStyle(color:Color(0xFF17365D),fontSize:21,fontWeight:FontWeight.w900,letterSpacing:1.5),
                      ),
                      const SizedBox(height:4),
                      Text(
                        "${controller.recintosElectoralesAbiertos.descripcion}",
                        maxLines:2,
                        overflow:TextOverflow.ellipsis,
                        style:const TextStyle(color:Color(0xFF667789),fontSize:9.2,fontWeight:FontWeight.w500,height:1.15),
                      ),
                    ],
                  ),
                ),
                Container(
                  width:34,
                  height:34,
                  decoration:BoxDecoration(color:const Color(0xFFF2F6FA),borderRadius:BorderRadius.circular(10)),
                  child:const Icon(Icons.verified_rounded,color:Color(0xFF195496),size:18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tituloAcciones() {
    return Padding(
      padding:const EdgeInsets.symmetric(horizontal:2),
      child:Row(
        children:[
          Container(width:3,height:27,decoration:BoxDecoration(color:const Color(0xFF195496),borderRadius:BorderRadius.circular(20))),
          const SizedBox(width:8),
          const Expanded(
            child:Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children:[
                Text('Gestión del recinto',style:TextStyle(color:Color(0xFF17365D),fontSize:14,fontWeight:FontWeight.w800)),
                SizedBox(height:1),
                Text('Seleccione la acción que desea realizar',style:TextStyle(color:Color(0xFF7A8998),fontSize:9)),
              ],
            ),
          ),
          Container(
            width:30,
            height:30,
            decoration:const BoxDecoration(color:Color(0xFFEAF1F8),borderRadius:BorderRadius.all(Radius.circular(9))),
            child:const Icon(Icons.dashboard_customize_outlined,color:Color(0xFF195496),size:16),
          ),
        ],
      ),
    );
  }

  Widget _getMenuJefe(ResponsiveUtil responsive) {
    return Column(
      children:[
        Row(
          crossAxisAlignment:CrossAxisAlignment.start,
          children:[
            Expanded(
              child:_moduloAccion(
                img:SiipneEleccionesImages.icon_agregar_personal,
                title:SiipneStrings.recElecAgregarpersonal,
                subtitle:'Personal',
                icon:Icons.person_add_alt_1_rounded,
                color:const Color(0xFF218A61),
                colorSuave:const Color(0xFFEAF5EF),
                onTap:(){
                  Get.toNamed(
                    EleccionesRoutes.ADD_PERSONAL,
                    arguments:{
                      "recintosElectoralesAbiertos":controller.recintosElectoralesAbiertos,
                    },
                  );
                },
              ),
            ),
            SizedBox(width:responsive.anchoP(2.5)),
            Expanded(
              child:_moduloAccion(
                img:SiipneEleccionesImages.icon_registrar_novedades_rec_elec,
                title:SiipneStrings.recElecRegistrarNovedades,
                subtitle:'Novedades',
                icon:Icons.assignment_outlined,
                color:const Color(0xFF195496),
                colorSuave:const Color(0xFFEAF1F8),
                onTap:(){
                  Get.toNamed(
                    EleccionesRoutes.ADD_NOVEDADES,
                    arguments:{
                      "recintosElectoralesAbiertos":controller.recintosElectoralesAbiertos,
                    },
                  );
                },
              ),
            ),
          ],
        ),
        SizedBox(height:responsive.altoP(1.1)),
        Row(
          crossAxisAlignment:CrossAxisAlignment.start,
          children:[
            Expanded(
              child:_moduloAccion(
                img:SiipneEleccionesImages.icon_finalizar_rec_elec,
                title:"FINALIZAR RECINTO",
                subtitle:'Cerrar operativo',
                icon:Icons.task_alt_rounded,
                color:const Color(0xFFE4772E),
                colorSuave:const Color(0xFFFFF1E7),
                onTap:(){
                  _dialogoFinalizarRecinto(nameRecinto:"${controller.recintosElectoralesAbiertos.nomRecintoElec}");
                },
              ),
            ),
            SizedBox(width:responsive.anchoP(2.5)),
            Expanded(
              child:_moduloAccion(
                img:SiipneEleccionesImages.icon_eliminar_rec_elec,
                title:"ELIMINAR CÓDIGO",
                subtitle:'Eliminar operativo',
                icon:Icons.delete_outline_rounded,
                color:const Color(0xFFB74949),
                colorSuave:const Color(0xFFF9ECEC),
                onTap:(){
                  String msj="Si abrió por error el Operativo se recomienda eliminarlo.  \n\nRecuerde [rojo]todo será registrado[/rojo] para verificar el correcto uso del aplicativo.\n\n¿Está seguro/a que desea eliminar el Operativo.?";
                  String title="ELIMINAR CÓDIGO ${controller.recintosElectoralesAbiertos.idDgoCreaOpReci}";

                  DialogosAwesome.getWarningSiNoContador(
                    title:title,
                    descripcion:msj,
                    btnOkOnPress:(){
                      DialogosAwesome.getDesingChangePass(
                        idDgoCreaOpReci:controller.recintosElectoralesAbiertos.idDgoCreaOpReci,
                        onPressed:(){
                          Get.back();
                          controller.eliminarCodigoRecinto();
                        },
                        formKey:controller.formKeyPass,
                        controllerPass:controller.controllerPass,
                        title:title,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _moduloAccion({required String img,required String title,required String subtitle,required IconData icon,required Color color,required Color colorSuave,required VoidCallback onTap}) {
    return Container(
      decoration:BoxDecoration(
        borderRadius:BorderRadius.circular(17),
        boxShadow:[BoxShadow(color:const Color(0xFF17365D).withOpacity(.07),blurRadius:13,offset:const Offset(0,5))],
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
            height:145,
            decoration:BoxDecoration(
              color:Colors.white.withOpacity(.97),
              borderRadius:BorderRadius.circular(17),
              border:Border.all(color:color.withOpacity(.13)),
            ),
            child:Stack(
              children:[
                Positioned(
                  right:-35,
                  top:-35,
                  child:Container(width:95,height:95,decoration:BoxDecoration(shape:BoxShape.circle,color:color.withOpacity(.045))),
                ),
                Padding(
                  padding:const EdgeInsets.fromLTRB(10,10,10,10),
                  child:Column(
                    children:[
                      Row(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        children:[
                          Container(
                            padding:const EdgeInsets.symmetric(horizontal:6,vertical:3),
                            decoration:BoxDecoration(color:colorSuave,borderRadius:BorderRadius.circular(20)),
                            child:Text('ACCIÓN',style:TextStyle(color:color,fontSize:6.3,fontWeight:FontWeight.w900,letterSpacing:.7)),
                          ),
                          Container(
                            width:27,
                            height:27,
                            decoration:BoxDecoration(color:color,borderRadius:BorderRadius.circular(8)),
                            child:const Icon(Icons.arrow_forward_rounded,color:Colors.white,size:14),
                          ),
                        ],
                      ),
                      const SizedBox(height:4),
                      Expanded(
                        child:Container(
                          width:62,
                          padding:const EdgeInsets.all(7),
                          decoration:BoxDecoration(
                            color:colorSuave,
                            borderRadius:BorderRadius.circular(14),
                            border:Border.all(color:color.withOpacity(.08)),
                          ),
                          child:Image.asset(
                            img,
                            fit:BoxFit.contain,
                            errorBuilder:(context,error,stackTrace)=>Icon(icon,color:color,size:29),
                          ),
                        ),
                      ),
                      const SizedBox(height:6),
                      Text(
                        title,
                        textAlign:TextAlign.center,
                        maxLines:2,
                        overflow:TextOverflow.ellipsis,
                        style:const TextStyle(color:Color(0xFF17365D),fontSize:10.3,fontWeight:FontWeight.w900,height:1.05),
                      ),
                      const SizedBox(height:2),
                      Text(
                        subtitle,
                        textAlign:TextAlign.center,
                        maxLines:1,
                        overflow:TextOverflow.ellipsis,
                        style:const TextStyle(color:Color(0xFF758596),fontSize:7.5,fontWeight:FontWeight.w400),
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

  Widget _botonSalir() {
    return Align(
      alignment:Alignment.center,
      child:Material(
        color:Colors.transparent,
        borderRadius:BorderRadius.circular(12),
        clipBehavior:Clip.antiAlias,
        child:InkWell(
          onTap:()=>controller.cerrarSession(),
          splashColor:const Color(0xFFC34A4A).withOpacity(.08),
          child:Ink(
            padding:const EdgeInsets.symmetric(horizontal:17,vertical:9),
            decoration:BoxDecoration(
              color:const Color(0xFFF9F4F4),
              borderRadius:BorderRadius.circular(12),
              border:Border.all(color:const Color(0xFFE8DADA)),
            ),
            child:const Row(
              mainAxisSize:MainAxisSize.min,
              children:[
                Icon(Icons.logout_rounded,color:Color(0xFFA84A4A),size:16),
                SizedBox(width:7),
                Text('CERRAR SESIÓN',style:TextStyle(color:Color(0xFF9D4646),fontSize:9.5,fontWeight:FontWeight.w800,letterSpacing:.5)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _dialogoFinalizarRecinto({required String nameRecinto}) {
    String title="FINALIZAR RECINTO";

    DialogosAwesome.getWarningSiNoContador(
      title:title,
      descripcion:"¿Está seguro/a que desea finalizar el Recinto?\nNOMBRE:${nameRecinto}",
      btnOkOnPress:(){
        DialogosAwesome.getDesingChangePass(
          idDgoCreaOpReci:controller.recintosElectoralesAbiertos.idDgoCreaOpReci,
          onPressed:(){
            Get.back();
            controller.finalizarRecinto();
          },
          formKey:controller.formKeyPass,
          controllerPass:controller.controllerPass,
          title:title,
          descripcion:"Para Finalizar el recinto con el código ${controller.recintosElectoralesAbiertos.idDgoCreaOpReci}, ingrese su clave de seguridad",
        );
      },
    );
  }
}
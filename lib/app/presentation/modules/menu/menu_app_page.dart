part of '../pages.dart';

class MenuAppPage extends GetView<MenuAppController> {
  const MenuAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationsBloc>().requestPermission(appName:NamApps.todas,idGenUsuario:controller.user.idGenUsuario);
    });

    return WorkAreaPageWidget(
      showBtnNotificacione:true,
      mostrarDatosServidor:true,
      title:"MENÚ PRINCIPAL",
      imgPerfil:controller.user.foto,
      nombresServidor:controller.user.nombres?.toString(),
      sexoServidor:controller.user.sexo?.toString(),
      contenido:_getContenidoConRefresh(),
      peticionServer:controller.peticionServerState,
    );
  }

  Widget _getContenidoConRefresh() {
    final responsive=ResponsiveUtil();

    return RefreshIndicator(
      color:const Color(0xFF195496),
      backgroundColor:Colors.white,
      onRefresh:() async {
        await controller.getDatosMenuApp();
      },
      child:SingleChildScrollView(
        physics:const AlwaysScrollableScrollPhysics(),
        padding:const EdgeInsets.fromLTRB(10,4,10,20),
        child:Column(
          crossAxisAlignment:CrossAxisAlignment.stretch,
          children:[
            _tituloModulos(),
            SizedBox(height:responsive.altoP(1.1)),
            _getMenu(responsive),
            SizedBox(height:responsive.altoP(2)),
            _botonSalir(),
          ],
        ),
      ),
    );
  }
  Widget _tituloModulos() {
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
                Text('Servicios disponibles',style:TextStyle(color:Color(0xFF17365D),fontSize:14,fontWeight:FontWeight.w800)),
                SizedBox(height:1),
                Text('Seleccione el módulo institucional',style:TextStyle(color:Color(0xFF7A8998),fontSize:9)),
              ],
            ),
          ),
          Container(
            width:30,
            height:30,
            decoration:const BoxDecoration(color:Color(0xFFEAF1F8),borderRadius:BorderRadius.all(Radius.circular(9))),
            child:const Icon(Icons.grid_view_rounded,color:Color(0xFF195496),size:16),
          ),
        ],
      ),
    );
  }

  Widget _getMenu(ResponsiveUtil responsive) {
    return Obx((){
      final bool elecciones=controller.showMenuElecciones.value;
      final bool censo=controller.showMenuCenso.value;

      if(!elecciones&&!censo)return const SizedBox.shrink();

      return Row(
        crossAxisAlignment:CrossAxisAlignment.start,
        children:[
          if(elecciones)
            Expanded(
              child:_moduloMenu(
                img:SiipneEleccionesImages.ic_elecciones,
                title:"ELECCIONES",
                subtitle:"Procesos electorales",
                icon:Icons.how_to_vote_outlined,
                onTap:(){
                  Get.toNamed(EleccionesRoutes.MENU_APP);
                },
              ),
            ),
          if(elecciones&&censo)const SizedBox(width:10),
          if(censo)
            Expanded(
              child:_moduloMenu(
                img:AppCensoImages.ic_censo,
                title:"CENSO POLICIAL",
                subtitle:"Registro institucional",
                icon:Icons.assignment_ind_outlined,
                onTap:()=>controller.verificarNovedadesUdgaPolicialRegistradas(),
              ),
            ),
        ],
      );
    });
  }

  Widget _moduloMenu({required String img,required String title,required String subtitle,required IconData icon,required VoidCallback onTap}) {
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
          splashColor:const Color(0xFF195496).withOpacity(.07),
          highlightColor:const Color(0xFF195496).withOpacity(.03),
          child:Ink(
            height:142,
            decoration:BoxDecoration(
              color:Colors.white.withOpacity(.96),
              borderRadius:BorderRadius.circular(17),
              border:Border.all(color:const Color(0xFFDCE4EC)),
            ),
            child:Stack(
              children:[
                Positioned(
                  right:-35,
                  top:-35,
                  child:Container(width:95,height:95,decoration:BoxDecoration(shape:BoxShape.circle,color:const Color(0xFF195496).withOpacity(.045))),
                ),
                Padding(
                  padding:const EdgeInsets.fromLTRB(10,11,10,10),
                  child:Column(
                    crossAxisAlignment:CrossAxisAlignment.center,
                    children:[
                      Row(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        children:[
                          Container(
                            padding:const EdgeInsets.symmetric(horizontal:6,vertical:3),
                            decoration:BoxDecoration(color:const Color(0xFF195496).withOpacity(.06),borderRadius:BorderRadius.circular(20)),
                            child:const Text('MÓDULO',style:TextStyle(color:Color(0xFF195496),fontSize:6.5,fontWeight:FontWeight.w900,letterSpacing:.7)),
                          ),
                          Container(
                            width:26,
                            height:26,
                            decoration:BoxDecoration(
                              gradient:const LinearGradient(begin:Alignment.topLeft,end:Alignment.bottomRight,colors:[Color(0xFF123F75),Color(0xFF2869AC)]),
                              borderRadius:BorderRadius.circular(8),
                            ),
                            child:const Icon(Icons.arrow_forward_rounded,color:Colors.white,size:14),
                          ),
                        ],
                      ),
                      const SizedBox(height:3),
                      Expanded(
                        child:Container(
                          width:58,
                          padding:const EdgeInsets.all(7),
                          decoration:BoxDecoration(
                            color:const Color(0xFFF2F6FA),
                            borderRadius:BorderRadius.circular(13),
                            border:Border.all(color:const Color(0xFF195496).withOpacity(.06)),
                          ),
                          child:Image.asset(img,fit:BoxFit.contain,errorBuilder:(context,error,stackTrace)=>Icon(icon,color:const Color(0xFF195496),size:28)),
                        ),
                      ),
                      const SizedBox(height:6),
                      Text(
                        title,
                        textAlign:TextAlign.center,
                        maxLines:1,
                        overflow:TextOverflow.ellipsis,
                        style:const TextStyle(color:Color(0xFF17365D),fontSize:11,fontWeight:FontWeight.w900,letterSpacing:.15),
                      ),
                      const SizedBox(height:2),
                      Text(
                        subtitle,
                        textAlign:TextAlign.center,
                        maxLines:1,
                        overflow:TextOverflow.ellipsis,
                        style:const TextStyle(color:Color(0xFF758596),fontSize:7.8,fontWeight:FontWeight.w400),
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
}
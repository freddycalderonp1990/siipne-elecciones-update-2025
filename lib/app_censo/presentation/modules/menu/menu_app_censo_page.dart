part of '../pages.dart';

class MenuAppCensoPage extends GetView<MenuAppCensoController> {
  const MenuAppCensoPage({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_){
      context.read<NotificationsBloc>().requestPermission(
        appName:NamApps.Censo,
        idGenUsuario:controller.user.idGenUsuario,
      );
    });

    return WorkAreaPageCensoWidget(
      showBtnNotificacione:false,
      mostrarDatosServidor:true,
      mostrarBtnAtras: true,
      title:"MENÚ CENSO",
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
      physics:const BouncingScrollPhysics(),
      padding:const EdgeInsets.fromLTRB(10,8,10,24),
      child:Column(
        crossAxisAlignment:CrossAxisAlignment.stretch,
        children:[

          _cabeceraModulo(),

          SizedBox(height:responsive.altoP(1.2)),

          _getMenu(responsive),

          SizedBox(height:responsive.altoP(2.2)),

          _btnSalir(),

          SizedBox(height:responsive.altoP(2)),
        ],
      ),
    );
  }

  Widget _cabeceraModulo() {
    return Container(
      width:double.infinity,
      padding:const EdgeInsets.fromLTRB(12,11,12,11),
      decoration:BoxDecoration(
        color:Colors.white.withOpacity(.97),
        borderRadius:BorderRadius.circular(17),
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
            width:44,
            height:44,
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
            ),
            child:const Icon(
              Icons.how_to_reg_outlined,
              color:Colors.white,
              size:22,
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
                    letterSpacing:.3,
                  ),
                ),

                SizedBox(height:2),

                Text(
                  'Seleccione la opción que desea realizar',
                  style:TextStyle(
                    color:Color(0xFF7A8998),
                    fontSize:8,
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
              color:const Color(0xFFEAF1F8),
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
                  'ACTIVO',
                  style:TextStyle(
                    color:Color(0xFF195496),
                    fontSize:6.5,
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

  Widget _getMenu(ResponsiveUtil responsive) {
    return Obx((){
      final List<Widget> botones=[];

      if(controller.showBtnIniciarCenso.value){
        botones.add(
          _menuModulo(
            img:AppCensoImages.ic_iniciar_censo,
            titulo:'INICIAR CENSO',
            subtitulo:'Registrar información censal',
            onTap:(){
              if(controller.isCensista.value){
                DialogosDesingWidget.getDialogoX(
                  title:"Iniciar Censo",
                  contenido:_getOpcionesParaCensista(responsive),
                );
              }else{
                controller.goToPageIniciarCenso();
              }
            },
          ),
        );
      }

      botones.add(
        _menuModulo(
          img:AppCensoImages.ic_historial_censo,
          titulo:'HISTORIAL CENSOS',
          subtitulo:'Consultar registros realizados',
          onTap:()=>Get.toNamed(
            AppCensoRoutes.HISTORIAL_CENSO,
          ),
        ),
      );

      return _gridBotones(botones);
    });
  }

  Widget _gridBotones(List<Widget> botones) {
    if(botones.isEmpty)return const SizedBox.shrink();

    return LayoutBuilder(
      builder:(context,constraints){
        const double separacionHorizontal=10;
        const double separacionVertical=10;

        final double anchoBoton=
            (constraints.maxWidth-separacionHorizontal)/2;

        final List<Widget> filas=[];

        for(int i=0;i<botones.length;i+=2){
          final bool tieneSegundo=i+1<botones.length;

          if(tieneSegundo){
            filas.add(
              Row(
                crossAxisAlignment:CrossAxisAlignment.start,
                children:[
                  SizedBox(
                    width:anchoBoton,
                    child:botones[i],
                  ),
                  const SizedBox(
                    width:separacionHorizontal,
                  ),
                  SizedBox(
                    width:anchoBoton,
                    child:botones[i+1],
                  ),
                ],
              ),
            );
          }else{
            filas.add(
              Center(
                child:SizedBox(
                  width:anchoBoton,
                  child:botones[i],
                ),
              ),
            );
          }

          if(i+2<botones.length){
            filas.add(
              const SizedBox(
                height:separacionVertical,
              ),
            );
          }
        }

        return Column(
          children:filas,
        );
      },
    );
  }

  Widget _menuModulo({
    required String img,
    required String titulo,
    required String subtitulo,
    required VoidCallback onTap,
  }) {
    return Material(
      color:Colors.transparent,
      borderRadius:BorderRadius.circular(17),
      clipBehavior:Clip.antiAlias,
      child:InkWell(
        onTap:onTap,
        splashColor:const Color(0xFF195496).withOpacity(.08),
        child:Ink(
          height:145,
          padding:const EdgeInsets.all(10),
          decoration:BoxDecoration(
            color:Colors.white,
            borderRadius:BorderRadius.circular(17),
            border:Border.all(
              color:const Color(0xFFDCE4EC),
            ),
            boxShadow:[
              BoxShadow(
                color:const Color(0xFF17365D).withOpacity(.06),
                blurRadius:10,
                offset:const Offset(0,4),
              ),
            ],
          ),
          child:Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children:[
              Row(
                children:[
                  Container(
                    padding:const EdgeInsets.symmetric(
                      horizontal:6,
                      vertical:3,
                    ),
                    decoration:BoxDecoration(
                      color:const Color(0xFFEAF1F8),
                      borderRadius:BorderRadius.circular(20),
                    ),
                    child:const Text(
                      'CENSO',
                      style:TextStyle(
                        color:Color(0xFF195496),
                        fontSize:6.3,
                        fontWeight:FontWeight.w900,
                        letterSpacing:.4,
                      ),
                    ),
                  ),

                  const Spacer(),

                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color:Color(0xFF9AA7B4),
                    size:13,
                  ),
                ],
              ),

              const Spacer(),

              Center(
                child:Image.asset(
                  img,
                  width:48,
                  height:48,
                  fit:BoxFit.contain,
                ),
              ),

              const Spacer(),

              Text(
                titulo,
                maxLines:2,
                textAlign:TextAlign.left,
                style:const TextStyle(
                  color:Color(0xFF17365D),
                  fontSize:9.7,
                  fontWeight:FontWeight.w900,
                  height:1.1,
                ),
              ),

              const SizedBox(height:3),

              Text(
                subtitulo,
                maxLines:2,
                overflow:TextOverflow.ellipsis,
                style:const TextStyle(
                  color:Color(0xFF7A8998),
                  fontSize:6.9,
                  height:1.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _btnSalir() {
    return Center(
      child:SizedBox(
        width:210,
        child:Material(
          color:Colors.transparent,
          borderRadius:BorderRadius.circular(13),
          clipBehavior:Clip.antiAlias,
          child:InkWell(
            onTap:()=>controller.cerrarSession(),
            splashColor:const Color(0xFFC94C4C).withOpacity(.08),
            child:Ink(
              height:44,
              decoration:BoxDecoration(
                color:Colors.white,
                borderRadius:BorderRadius.circular(13),
                border:Border.all(
                  color:const Color(0xFFC94C4C).withOpacity(.22),
                ),
              ),
              child:const Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children:[
                  Icon(
                    Icons.logout_rounded,
                    color:Color(0xFFC94C4C),
                    size:17,
                  ),

                  SizedBox(width:7),

                  Text(
                    'SALIR',
                    style:TextStyle(
                      color:Color(0xFFC94C4C),
                      fontSize:9.5,
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
    );
  }

  Widget _getOpcionesParaCensista(ResponsiveUtil responsive) {
    return Obx((){
      final List<Widget> botones=[];

      botones.add(
        _menuModulo(
          img:AppCensoImages.ic_censista,
          titulo:'QUIERO CENSAR',
          subtitulo:'Registrar información de otras personas',
          onTap:(){
            Get.back();
            controller.validarMesasCenso(
              controller.dataMesasList,
            );
          },
        ),
      );

      if(controller.showBtnQuieroSerCensado.value){
        botones.add(
          _menuModulo(
            img:AppCensoImages.ic_censo,
            titulo:'QUIERO SER CENSADO',
            subtitulo:'Registrar mi información censal',
            onTap:(){
              Get.back();
              controller.goToPageIniciarCenso();
            },
          ),
        );
      }

      return Container(
        width:double.infinity,
        padding:const EdgeInsets.fromLTRB(6,4,6,10),
        child:Column(
          crossAxisAlignment:CrossAxisAlignment.stretch,
          children:[
            Container(
              width:double.infinity,
              padding:const EdgeInsets.all(10),
              decoration:BoxDecoration(
                color:const Color(0xFFEAF1F8),
                borderRadius:BorderRadius.circular(13),
                border:Border.all(
                  color:const Color(0xFF195496).withOpacity(.10),
                ),
              ),
              child:const Row(
                children:[
                  Icon(
                    Icons.info_outline_rounded,
                    color:Color(0xFF195496),
                    size:18,
                  ),
                  SizedBox(width:8),
                  Expanded(
                    child:Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children:[
                        Text(
                          'PARTICIPACIÓN EN EL CENSO',
                          style:TextStyle(
                            color:Color(0xFF17365D),
                            fontSize:9,
                            fontWeight:FontWeight.w900,
                          ),
                        ),
                        SizedBox(height:2),
                        Text(
                          'Seleccione cómo desea participar',
                          style:TextStyle(
                            color:Color(0xFF7A8998),
                            fontSize:7.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height:12),

            _gridBotones(botones),

            const SizedBox(height:3),
          ],
        ),
      );
    });
  }

}
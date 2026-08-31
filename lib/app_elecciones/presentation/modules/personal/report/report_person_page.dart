part of '../../pages.dart';

class ReportPersonPage extends GetView<ReportPersonController> {
  const ReportPersonPage({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(
      mostrarBtnAtras:true,
      title:"REPORTE DEL PERSONAL",
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
      padding:const EdgeInsets.fromLTRB(8,6,8,20),
      child:Column(
        crossAxisAlignment:CrossAxisAlignment.stretch,
        children:[
          _cabeceraRecinto(),
          SizedBox(height:responsive.altoP(1)),
          _resumenPersonal(),
          SizedBox(height:responsive.altoP(1)),
          Obx(()=>_wgJefe(controller.encargado.value)),
          SizedBox(height:responsive.altoP(1)),
          _PersonalActivo(),
          SizedBox(height:responsive.altoP(2)),
        ],
      ),
    );
  }

  Widget _cabeceraRecinto() {
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
              Icons.location_city_outlined,
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
                  'RECINTO ELECTORAL',
                  style:TextStyle(
                    color:Color(0xFF195496),
                    fontSize:7,
                    fontWeight:FontWeight.w900,
                    letterSpacing:.5,
                  ),
                ),
                const SizedBox(height:3),
                Text(
                  controller.recintosElectoralesAbiertos.nomRecintoElec,
                  maxLines:3,
                  overflow:TextOverflow.ellipsis,
                  style:const TextStyle(
                    color:Color(0xFF17365D),
                    fontSize:11.5,
                    fontWeight:FontWeight.w900,
                    height:1.12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _resumenPersonal() {
    return Obx((){
      final int total=controller.listPersonalActivo.value.length+1;

      return Container(
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
              width:46,
              height:46,
              decoration:BoxDecoration(
                color:Colors.white,
                borderRadius:BorderRadius.circular(13),
                border:Border.all(
                  color:const Color(0xFF195496).withOpacity(.14),
                ),
              ),
              child:const Icon(
                Icons.groups_2_outlined,
                color:Color(0xFF195496),
                size:22,
              ),
            ),
            const SizedBox(width:10),
            const Expanded(
              child:Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children:[
                  Text(
                    'PERSONAL REGISTRADO',
                    style:TextStyle(
                      color:Color(0xFF17365D),
                      fontSize:10.5,
                      fontWeight:FontWeight.w900,
                    ),
                  ),
                  SizedBox(height:2),
                  Text(
                    'Servidores policiales asignados al operativo',
                    style:TextStyle(
                      color:Color(0xFF7A8998),
                      fontSize:7.8,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              constraints:const BoxConstraints(
                minWidth:46,
                minHeight:38,
              ),
              padding:const EdgeInsets.symmetric(
                horizontal:10,
                vertical:7,
              ),
              decoration:BoxDecoration(
                color:const Color(0xFF195496),
                borderRadius:BorderRadius.circular(12),
              ),
              child:Column(
                mainAxisSize:MainAxisSize.min,
                children:[
                  Text(
                    '$total',
                    style:const TextStyle(
                      color:Colors.white,
                      fontSize:15,
                      fontWeight:FontWeight.w900,
                    ),
                  ),
                  const Text(
                    'TOTAL',
                    style:TextStyle(
                      color:Colors.white70,
                      fontSize:5.8,
                      fontWeight:FontWeight.w800,
                      letterSpacing:.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _wgJefe(PersonalRecintoElectoral data) {
    return Container(
      width:double.infinity,
      decoration:BoxDecoration(
        color:Colors.white,
        borderRadius:BorderRadius.circular(16),
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
          childrenPadding:const EdgeInsets.fromLTRB(10,0,10,10),
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
              Icons.workspace_premium_outlined,
              color:Color(0xFF195496),
              size:19,
            ),
          ),
          title:const Text(
            'ENCARGADO',
            style:TextStyle(
              color:Color(0xFF17365D),
              fontSize:10.8,
              fontWeight:FontWeight.w900,
            ),
          ),
          subtitle:const Text(
            'Responsable del recinto electoral',
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
                  _filaDetalle(
                    icon:Icons.calendar_month_outlined,
                    titulo:'Fecha inicio',
                    detalle:controller.encargado.value.fechaIni,
                  ),
                  const SizedBox(height:7),
                  Container(
                    height:1,
                    color:const Color(0xFFE1E7ED),
                  ),
                  const SizedBox(height:7),
                  _filaDetalle(
                    icon:Icons.badge_outlined,
                    titulo:'Servidor policial',
                    detalle:data.personal,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filaDetalle({
    required IconData icon,
    required String titulo,
    required String detalle,
  }) {
    return Row(
      crossAxisAlignment:CrossAxisAlignment.start,
      children:[
        Container(
          width:30,
          height:30,
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
                  fontSize:6.5,
                  fontWeight:FontWeight.w800,
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

  Widget _PersonalActivo() {
    return Obx((){
      final listPersonal=controller.listPersonalActivo.value;

      return Container(
        width:double.infinity,
        decoration:BoxDecoration(
          color:Colors.white,
          borderRadius:BorderRadius.circular(16),
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
            childrenPadding:const EdgeInsets.fromLTRB(10,0,10,10),
            collapsedIconColor:const Color(0xFF195496),
            iconColor:const Color(0xFF195496),
            leading:Container(
              width:38,
              height:38,
              decoration:BoxDecoration(
                color:const Color(0xFFEAF5EE),
                borderRadius:BorderRadius.circular(11),
              ),
              child:const Icon(
                Icons.groups_outlined,
                color:Color(0xFF218A61),
                size:19,
              ),
            ),
            title:const Text(
              'PERSONAL ACTIVO',
              style:TextStyle(
                color:Color(0xFF17365D),
                fontSize:10.8,
                fontWeight:FontWeight.w900,
              ),
            ),
            subtitle:Text(
              '${controller.listPersonalActivo.length} servidores registrados',
              style:const TextStyle(
                color:Color(0xFF7A8998),
                fontSize:7.4,
              ),
            ),
            trailing:Row(
              mainAxisSize:MainAxisSize.min,
              children:[
                Container(
                  padding:const EdgeInsets.symmetric(
                    horizontal:7,
                    vertical:4,
                  ),
                  decoration:BoxDecoration(
                    color:const Color(0xFFEAF5EE),
                    borderRadius:BorderRadius.circular(20),
                  ),
                  child:Text(
                    '${controller.listPersonalActivo.length}',
                    style:const TextStyle(
                      color:Color(0xFF218A61),
                      fontSize:7.5,
                      fontWeight:FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(width:4),
                const Icon(
                  Icons.expand_more_rounded,
                  color:Color(0xFF195496),
                ),
              ],
            ),
            children:[
              if(listPersonal.isEmpty)
                _sinPersonal()
              else
                ListView.builder(
                  reverse:true,
                  shrinkWrap:true,
                  physics:const NeverScrollableScrollPhysics(),
                  itemCount:controller.listPersonalActivo.length,
                  itemBuilder:(BuildContext context,int i){
                    PersonalRecintoElectoral data=listPersonal[i];

                    return _itemPersonal(
                      data:data,
                      index:i+1,
                    );
                  },
                ),
            ],
          ),
        ),
      );
    });
  }

  Widget _sinPersonal() {
    return Container(
      width:double.infinity,
      padding:const EdgeInsets.symmetric(
        horizontal:10,
        vertical:18,
      ),
      decoration:BoxDecoration(
        color:const Color(0xFFF7F9FB),
        borderRadius:BorderRadius.circular(13),
      ),
      child:const Column(
        children:[
          Icon(
            Icons.person_off_outlined,
            color:Color(0xFF8997A5),
            size:28,
          ),
          SizedBox(height:6),
          Text(
            'No existe personal activo registrado',
            textAlign:TextAlign.center,
            style:TextStyle(
              color:Color(0xFF68798A),
              fontSize:8.5,
              fontWeight:FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemPersonal({
    required PersonalRecintoElectoral data,
    required int index,
  }) {
    return Padding(
      padding:const EdgeInsets.only(bottom:7),
      child:Material(
        color:Colors.transparent,
        borderRadius:BorderRadius.circular(13),
        clipBehavior:Clip.antiAlias,
        child:InkWell(
          onTap:(){
            DialogosAwesome.getWarningSiNoContador(
              descripcion:
              "¿Está  seguro/a que desea eliminar a ${data.personal} del operarivo.?\n\n"
                  "[rojo]Si elimina, no será considerado para el justificativo ante el CNE.[/rojo]"
                  "\nDeberá anexarse a un nuevo código y no abandonar, ya que esta acción es automática al finalizar el proceso electoral"
                  "\n\n¿ESTÁ SEGURO/A?",
              btnOkOnPress:(){
                DialogosAwesome.getDesingChangePass(
                  idDgoCreaOpReci:controller.recintosElectoralesAbiertos.idDgoCreaOpReci,
                  onPressed:(){
                    controller.removePersonalOperativo(data);
                  },
                  formKey:controller.formKeyPass,
                  controllerPass:controller.controllerPass,
                  title:"ABANDONAR CÓDIGO",
                );
              },
            );
          },
          child:Ink(
            padding:const EdgeInsets.all(9),
            decoration:BoxDecoration(
              color:const Color(0xFFF9FAFC),
              borderRadius:BorderRadius.circular(13),
              border:Border.all(
                color:const Color(0xFFE1E7ED),
              ),
            ),
            child:Row(
              children:[
                Container(
                  width:38,
                  height:38,
                  alignment:Alignment.center,
                  decoration:BoxDecoration(
                    color:const Color(0xFFEAF1F8),
                    borderRadius:BorderRadius.circular(11),
                  ),
                  child:Text(
                    '$index',
                    style:const TextStyle(
                      color:Color(0xFF195496),
                      fontSize:10.5,
                      fontWeight:FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(width:9),
                Expanded(
                  child:Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children:[
                      const Text(
                        'SERVIDOR POLICIAL',
                        style:TextStyle(
                          color:Color(0xFF7A8998),
                          fontSize:6.2,
                          fontWeight:FontWeight.w800,
                          letterSpacing:.4,
                        ),
                      ),
                      const SizedBox(height:2),
                      Text(
                        data.personal,
                        maxLines:3,
                        overflow:TextOverflow.ellipsis,
                        style:const TextStyle(
                          color:Color(0xFF17365D),
                          fontSize:9.5,
                          fontWeight:FontWeight.w800,
                          height:1.12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width:6),
                Container(
                  width:31,
                  height:31,
                  decoration:BoxDecoration(
                    color:const Color(0xFFFFF0F0),
                    borderRadius:BorderRadius.circular(9),
                  ),
                  child:const Icon(
                    Icons.logout_rounded,
                    color:Color(0xFFC94C4C),
                    size:16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getDesingExpandible({
    required String title,
    required List<Widget> children,
  }) {
    return ExpansionTile(
      collapsedIconColor:AppColors.colorAzul,
      iconColor:AppColors.colorAzul,
      initiallyExpanded:true,
      title:Text(
        title,
        style:TextStyle(
          color:AppColors.colorAzul,
          fontSize:ResponsiveUtil().diagonalP(AppConfig.tamTextoTitulo),
        ),
      ),
      children:children,
    );
  }
}
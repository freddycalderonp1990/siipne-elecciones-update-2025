part of '../pages.dart';

class ValidateRecintoPage extends GetView<ValidateRecintoController> {
  const ValidateRecintoPage({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    Widget wg=Obx(
          ()=>DesingMapaRecinto(
        showNoEncuentyroMiRecinto:controller.selectProcesosOperativo.permitirAgregarRecintos,
        listRecintosElectorales:controller.listRecintosElectorales,
        onPressedSave:(){
          _mostrarDialogoGuardar();
        },
        ubicacion:controller.ubicacion.value,
        mapController:controller.mapController,
        tapComplete:(value){
          controller.ubicacion.value=value;
          controller.mapController.move(value,18);
        },
        ontapMyUbicacion:() async {
          await controller.getUbicacionActual();
        },
        onRecintoSeleccionado:(recinto){
          print("Seleccionado: ${recinto.nomRecintoElecOnly}");
          controller.selectRecintosElectoral.value=recinto;
        },
        cargando:controller.peticionServerState.value,
      ),
    );

    return GpsAccessScreen(
      useSafeArea:true,
      contenido:wg,
      namApps:NamApps.Elecciones,
    );
  }

  void _mostrarDialogoGuardar() {
    DialogosDesingWidget.getDialogoX(
      contenido:Container(
        width:double.infinity,
        padding:const EdgeInsets.fromLTRB(14,12,14,14),
        decoration:BoxDecoration(
          color:Colors.white,
          borderRadius:BorderRadius.circular(18),
        ),
        child:Column(
          mainAxisSize:MainAxisSize.min,
          crossAxisAlignment:CrossAxisAlignment.stretch,
          children:[
            _cabeceraDialogo(),
            const SizedBox(height:14),
            Container(
              width:double.infinity,
              padding:const EdgeInsets.fromLTRB(10,10,10,8),
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
            const SizedBox(height:14),
            Center(
              child:SizedBox(
                width:210,
                child:_botonGuardar(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cabeceraDialogo() {
    return Row(
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
            boxShadow:[
              BoxShadow(
                color:const Color(0xFF195496).withOpacity(.18),
                blurRadius:9,
                offset:const Offset(0,3),
              ),
            ],
          ),
          child:const Icon(
            Icons.location_on_outlined,
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
                'VALIDAR RECINTO',
                style:TextStyle(
                  color:Color(0xFF17365D),
                  fontSize:13,
                  fontWeight:FontWeight.w900,
                ),
              ),
              SizedBox(height:2),
              Text(
                'Confirme la información antes de guardar la ubicación',
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
    );
  }

  Widget _botonGuardar() {
    return Material(
      color:Colors.transparent,
      borderRadius:BorderRadius.circular(14),
      clipBehavior:Clip.antiAlias,
      child:InkWell(
        onTap:(){
          Get.back();
          controller.updateRecintoCoordinates();
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
                size:19,
              ),
              SizedBox(width:8),
              Text(
                'GUARDAR',
                style:TextStyle(
                  color:Colors.white,
                  fontSize:10.5,
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
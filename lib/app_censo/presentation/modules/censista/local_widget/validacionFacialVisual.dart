import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ValidacionFacialVisual extends StatefulWidget {
  final VoidCallback onFinalizado;

  const ValidacionFacialVisual({
    super.key,
    required this.onFinalizado,
  });

  @override
  State<ValidacionFacialVisual> createState()=>_ValidacionFacialVisualState();
}

class _ValidacionFacialVisualState extends State<ValidacionFacialVisual> {
  double _progreso=0;
  String _estado='Preparando análisis visual...';
  bool _terminado=false;
  bool _notificado=false;
  bool _analisisIniciado=false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_){
      if(!_analisisIniciado){
        _analisisIniciado=true;
        _iniciarAnalisis();
      }
    });
  }

  Future<void> _iniciarAnalisis() async {
    await _actualizar(
      valor:.16,
      texto:'Inicializando imágenes...',
      espera:350,
    );

    await _actualizar(
      valor:.34,
      texto:'Localizando zonas faciales...',
      espera:450,
    );

    await _actualizar(
      valor:.52,
      texto:'Analizando calidad de fotografías...',
      espera:500,
    );

    await _actualizar(
      valor:.70,
      texto:'Preparando puntos de referencia...',
      espera:550,
    );

    await _actualizar(
      valor:.88,
      texto:'Preparando comparación visual...',
      espera:500,
    );

    await _actualizar(
      valor:1,
      texto:'Imágenes listas para verificación visual',
      espera:450,
    );

    if(!mounted)return;

    setState((){
      _terminado=true;
      _progreso=1;
    });

    if(!_notificado){
      _notificado=true;
      widget.onFinalizado();
    }
  }

  Future<void> _actualizar({
    required double valor,
    required String texto,
    required int espera,
  }) async {
    await Future.delayed(
      Duration(milliseconds:espera),
    );

    if(!mounted)return;

    setState((){
      _progreso=valor;
      _estado=texto;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration:const Duration(milliseconds:300),
      width:double.infinity,
      padding:const EdgeInsets.all(11),
      decoration:BoxDecoration(
        color:_terminado
            ?const Color(0xFFEAF5EE)
            :const Color(0xFFEAF1F8),
        borderRadius:BorderRadius.circular(14),
        border:Border.all(
          color:_terminado
              ?const Color(0xFF218A61).withOpacity(.20)
              :const Color(0xFF195496).withOpacity(.15),
        ),
      ),
      child:Column(
        children:[
          Row(
            children:[
              Container(
                width:39,
                height:39,
                decoration:BoxDecoration(
                  color:Colors.white,
                  borderRadius:BorderRadius.circular(11),
                ),
                child:Icon(
                  _terminado
                      ?Icons.check_circle_outline_rounded
                      :Icons.face_retouching_natural_outlined,
                  color:_terminado
                      ?const Color(0xFF218A61)
                      :const Color(0xFF195496),
                  size:20,
                ),
              ),

              const SizedBox(width:9),

              Expanded(
                child:Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children:[
                    Text(
                      _terminado
                          ?'ANÁLISIS VISUAL COMPLETADO'
                          :'ANALIZANDO FOTOGRAFÍAS',
                      style:TextStyle(
                        color:_terminado
                            ?const Color(0xFF218A61)
                            :const Color(0xFF17365D),
                        fontSize:10,
                        fontWeight:FontWeight.w900,
                      ),
                    ),

                    const SizedBox(height:2),

                    Text(
                      _estado,
                      style:const TextStyle(
                        color:Color(0xFF7A8998),
                        fontSize:12,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                constraints:const BoxConstraints(
                  minWidth:50,
                ),
                padding:const EdgeInsets.symmetric(
                  horizontal:8,
                  vertical:6,
                ),
                decoration:BoxDecoration(
                  color:Colors.white,
                  borderRadius:BorderRadius.circular(10),
                ),
                child:Text(
                  '${(_progreso*100).round()}%',
                  textAlign:TextAlign.center,
                  style:TextStyle(
                    color:_terminado
                        ?const Color(0xFF218A61)
                        :const Color(0xFF195496),
                    fontSize:10,
                    fontWeight:FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height:10),

          ClipRRect(
            borderRadius:BorderRadius.circular(20),
            child:LinearProgressIndicator(
              value:_progreso,
              minHeight:6,
              backgroundColor:Colors.white,
              valueColor:AlwaysStoppedAnimation<Color>(
                _terminado
                    ?const Color(0xFF218A61)
                    :const Color(0xFF195496),
              ),
            ),
          ),

          if(_terminado)...[
            const SizedBox(height:9),

            Container(
              width:double.infinity,
              padding:const EdgeInsets.symmetric(
                horizontal:9,
                vertical:8,
              ),
              decoration:BoxDecoration(
                color:Colors.white.withOpacity(.88),
                borderRadius:BorderRadius.circular(10),
              ),
              child:const Row(
                children:[
                  Icon(
                    Icons.check_circle_rounded,
                    color:Color(0xFF218A61),
                    size:15,
                  ),

                  SizedBox(width:6),

                  Expanded(
                    child:Text(
                        'Análisis finalizado. Ya puede realizar la verificación visual y guardar el registro.',
                      style:TextStyle(
                        color:Color(0xFF526474),
                        fontSize:12,
                        height:1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
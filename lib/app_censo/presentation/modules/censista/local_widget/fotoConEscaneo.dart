import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:math' as math;
import 'package:flutter/material.dart';

class FotoConEscaneo extends StatefulWidget {
  final Widget child;
  final bool finalizado;

  const FotoConEscaneo({
    super.key,
    required this.child,
    this.finalizado=false,
  });

  @override
  State<FotoConEscaneo> createState()=>_FotoConEscaneoState();
}

class _FotoConEscaneoState extends State<FotoConEscaneo> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState(){
    super.initState();
    _controller=AnimationController(vsync:this,duration:const Duration(milliseconds:3200));
    if(!widget.finalizado)_controller.repeat();
  }

  @override
  void didUpdateWidget(covariant FotoConEscaneo oldWidget){
    super.didUpdateWidget(oldWidget);
    if(oldWidget.finalizado==widget.finalizado)return;
    if(widget.finalizado){
      _controller.stop();
    }else{
      _controller.repeat();
    }
  }

  @override
  Widget build(BuildContext context){
    return LayoutBuilder(
      builder:(context,constraints){
        final double alto=constraints.maxHeight;
        return AnimatedContainer(
          duration:const Duration(milliseconds:500),
          curve:Curves.easeOutCubic,
          decoration:BoxDecoration(
            borderRadius:BorderRadius.circular(14),
            border:Border.all(
              color:widget.finalizado
                  ?const Color(0xFF218A61).withOpacity(.85)
                  :const Color(0xFF69C0FF).withOpacity(.30),
              width:widget.finalizado?2:1,
            ),
            boxShadow:[
              BoxShadow(
                color:widget.finalizado
                    ?const Color(0xFF218A61).withOpacity(.20)
                    :const Color(0xFF195496).withOpacity(.10),
                blurRadius:widget.finalizado?14:8,
                spreadRadius:widget.finalizado?1:0,
              ),
            ],
          ),
          child:ClipRRect(
            borderRadius:BorderRadius.circular(12),
            child:Stack(
              fit:StackFit.expand,
              children:[
                AnimatedScale(
                  scale:widget.finalizado?1.015:1,
                  duration:const Duration(milliseconds:650),
                  curve:Curves.easeOutCubic,
                  child:widget.child,
                ),
                AnimatedContainer(
                  duration:const Duration(milliseconds:500),
                  color:widget.finalizado
                      ?const Color(0xFF063D2B).withOpacity(.06)
                      :const Color(0xFF071B2E).withOpacity(.025),
                ),
                if(!widget.finalizado)...[
                  Positioned.fill(
                    child:IgnorePointer(
                      child:AnimatedBuilder(
                        animation:_controller,
                        builder:(context,child)=>CustomPaint(
                          painter:_FaceFramePainter(progreso:_controller.value),
                        ),
                      ),
                    ),
                  ),
                  AnimatedBuilder(
                    animation:_controller,
                    builder:(context,child){
                      final double recorrido=_controller.value<=.5?_controller.value*2:(1-_controller.value)*2;
                      final double y=recorrido*(alto>3?alto-3:alto);
                      return Positioned(
                        left:7,
                        right:7,
                        top:y,
                        child:Container(
                          height:2,
                          decoration:BoxDecoration(
                            gradient:LinearGradient(
                              colors:[
                                Colors.transparent,
                                const Color(0xFF5DB6FF).withOpacity(.20),
                                const Color(0xFF8BE8FF),
                                Colors.white.withOpacity(.95),
                                const Color(0xFF8BE8FF),
                                const Color(0xFF5DB6FF).withOpacity(.20),
                                Colors.transparent,
                              ],
                            ),
                            boxShadow:[
                              BoxShadow(
                                color:const Color(0xFF5DB6FF).withOpacity(.75),
                                blurRadius:10,
                                spreadRadius:1,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
                Positioned.fill(
                  child:IgnorePointer(
                    child:AnimatedSwitcher(
                      duration:const Duration(milliseconds:550),
                      switchInCurve:Curves.easeOutCubic,
                      switchOutCurve:Curves.easeInCubic,
                      transitionBuilder:(child,animation){
                        return FadeTransition(
                          opacity:animation,
                          child:ScaleTransition(
                            scale:Tween<double>(
                              begin:.96,
                              end:1,
                            ).animate(
                              CurvedAnimation(
                                parent:animation,
                                curve:Curves.easeOutCubic,
                              ),
                            ),
                            child:child,
                          ),
                        );
                      },
                      child:widget.finalizado
                          ?const SizedBox.expand(
                        key:ValueKey('resultado-final'),
                        child:CustomPaint(
                          painter:_ResultadoFacialPainter(),
                        ),
                      )
                          :const SizedBox.expand(
                        key:ValueKey('analisis-activo'),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left:7,
                  top:7,
                  child:AnimatedContainer(
                    duration:const Duration(milliseconds:450),
                    padding:const EdgeInsets.symmetric(horizontal:7,vertical:4),
                    decoration:BoxDecoration(
                      color:widget.finalizado
                          ?const Color(0xFF176B4B).withOpacity(.94)
                          :const Color(0xFF102A43).withOpacity(.86),
                      borderRadius:BorderRadius.circular(8),
                      border:Border.all(
                        color:widget.finalizado
                            ?const Color(0xFF8DE0B9).withOpacity(.55)
                            :const Color(0xFF69C0FF).withOpacity(.40),
                      ),
                      boxShadow:[
                        BoxShadow(
                          color:widget.finalizado
                              ?const Color(0xFF176B4B).withOpacity(.30)
                              :Colors.black.withOpacity(.10),
                          blurRadius:7,
                        ),
                      ],
                    ),
                    child:Row(
                      mainAxisSize:MainAxisSize.min,
                      children:[
                        Icon(
                          widget.finalizado
                              ?Icons.verified_rounded
                              :Icons.center_focus_strong_rounded,
                          color:widget.finalizado
                              ?const Color(0xFFB8F3D3)
                              :const Color(0xFF69C0FF),
                          size:10,
                        ),
                        const SizedBox(width:4),
                        Text(
                          widget.finalizado?'VERIFICADO':'ANALIZANDO',
                          style:const TextStyle(
                            color:Colors.white,
                            fontSize:5.7,
                            fontWeight:FontWeight.w900,
                            letterSpacing:.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
}

class _ResultadoFacialPainter extends CustomPainter {
  const _ResultadoFacialPainter();

  static const List<Offset> _puntos=[
    Offset(.38,.31),Offset(.46,.29),Offset(.54,.29),Offset(.62,.31),
    Offset(.40,.40),Offset(.46,.39),Offset(.54,.39),Offset(.60,.40),
    Offset(.50,.46),Offset(.47,.53),Offset(.53,.53),
    Offset(.42,.61),Offset(.50,.64),Offset(.58,.61),
  ];

  static const List<List<int>> _conexiones=[
    [0,1],[1,2],[2,3],[0,4],[3,7],[4,5],[6,7],
    [5,8],[6,8],[8,9],[8,10],[9,11],[9,12],
    [10,12],[10,13],[11,12],[12,13],
  ];

  @override
  void paint(Canvas canvas,Size size){
    if(size.width<=0||size.height<=0)return;

    final List<Offset> posiciones=_puntos.map((p)=>Offset(p.dx*size.width,p.dy*size.height)).toList();

    final Paint marco=Paint()
      ..color=const Color(0xFF65D49D).withOpacity(.90)
      ..strokeWidth=1.7
      ..style=PaintingStyle.stroke
      ..strokeCap=StrokeCap.round;

    final Paint conexion=Paint()
      ..color=const Color(0xFF65D49D).withOpacity(.30)
      ..strokeWidth=.75
      ..style=PaintingStyle.stroke;

    final Paint halo=Paint()
      ..color=const Color(0xFF65D49D).withOpacity(.18)
      ..style=PaintingStyle.fill;

    final Paint punto=Paint()
      ..color=const Color(0xFFA7F1C9)
      ..style=PaintingStyle.fill;

    final Rect rect=Rect.fromCenter(
      center:Offset(size.width/2,size.height*.49),
      width:size.width*.68,
      height:size.height*.70,
    );

    const double esquina=18;
    final Path path=Path()
      ..moveTo(rect.left,rect.top+esquina)
      ..lineTo(rect.left,rect.top)
      ..lineTo(rect.left+esquina,rect.top)
      ..moveTo(rect.right-esquina,rect.top)
      ..lineTo(rect.right,rect.top)
      ..lineTo(rect.right,rect.top+esquina)
      ..moveTo(rect.right,rect.bottom-esquina)
      ..lineTo(rect.right,rect.bottom)
      ..lineTo(rect.right-esquina,rect.bottom)
      ..moveTo(rect.left+esquina,rect.bottom)
      ..lineTo(rect.left,rect.bottom)
      ..lineTo(rect.left,rect.bottom-esquina);

    canvas.drawPath(path,marco);

    for(final List<int> conexionItem in _conexiones){
      canvas.drawLine(
        posiciones[conexionItem[0]],
        posiciones[conexionItem[1]],
        conexion,
      );
    }

    for(final Offset posicion in posiciones){
      canvas.drawCircle(posicion,4,halo);
      canvas.drawCircle(posicion,1.55,punto);
      canvas.drawCircle(
        posicion,
        .45,
        Paint()
          ..color=Colors.white
          ..style=PaintingStyle.fill,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate)=>false;
}

class _FaceFramePainter extends CustomPainter {
  final double progreso;

  _FaceFramePainter({
    required this.progreso,
  });

  /*
   * Posiciones posibles de análisis.
   *
   * IMPORTANTE:
   * Ya no se dibujan todas.
   * En cada intervalo solamente se seleccionan
   * entre 4 y 7 posiciones.
   */
  static const List<Offset> _puntosBase=[
    Offset(.38,.30),
    Offset(.46,.28),
    Offset(.54,.28),
    Offset(.62,.30),

    Offset(.36,.38),
    Offset(.42,.37),
    Offset(.47,.39),

    Offset(.53,.39),
    Offset(.58,.37),
    Offset(.64,.38),

    Offset(.40,.45),
    Offset(.45,.44),

    Offset(.55,.44),
    Offset(.60,.45),

    Offset(.50,.45),
    Offset(.48,.51),
    Offset(.50,.55),
    Offset(.52,.51),

    Offset(.39,.54),
    Offset(.44,.57),

    Offset(.56,.57),
    Offset(.61,.54),

    Offset(.42,.63),
    Offset(.46,.62),
    Offset(.50,.63),
    Offset(.54,.62),
    Offset(.58,.63),

    Offset(.39,.67),
    Offset(.44,.71),
    Offset(.50,.73),
    Offset(.56,.71),
    Offset(.61,.67),
  ];

  @override
  void paint(Canvas canvas,Size size) {
    if(size.width<=0||size.height<=0){
      return;
    }

    final double recorrido=
    progreso<=.5
        ?progreso*2
        :(1-progreso)*2;

    final double scanY=
        size.height*recorrido;

    _dibujarMarco(
      canvas,
      size,
    );

    final List<_PuntoFacial> puntos=
    _generarPuntosAleatorios(
      size,
      scanY,
    );

    _dibujarPuntos(
      canvas,
      size,
      puntos,
      scanY,
    );
  }

  /*
   * Genera grupos estables de puntos.
   *
   * El valor de progreso se divide en pequeños intervalos.
   * De esta forma los puntos NO cambian en cada frame,
   * evitando un efecto de parpadeo excesivo.
   */
  List<_PuntoFacial> _generarPuntosAleatorios(
      Size size,
      double scanY,
      ) {

    /*
     * 9 grupos durante cada ciclo.
     *
     * Con duración de 3200 ms:
     * aproximadamente un cambio cada 355 ms.
     */
    final int bloque=
    (progreso*9).floor();

    final int semilla=
        1947+(bloque*7919);

    final math.Random random=
    math.Random(semilla);

    /*
     * Se seleccionan solamente entre
     * 4 y 7 puntos.
     */
    final int cantidad=
        4+random.nextInt(4);

    final List<int> indices=
    List<int>.generate(
      _puntosBase.length,
          (index)=>index,
    );

    indices.shuffle(random);

    final List<_PuntoFacial> resultado=[];

    /*
     * Primero damos preferencia a posiciones
     * cercanas a la línea de escaneo.
     */
    indices.sort((a,b){
      final double ya=
          _puntosBase[a].dy*size.height;

      final double yb=
          _puntosBase[b].dy*size.height;

      final double distanciaA=
      (ya-scanY).abs();

      final double distanciaB=
      (yb-scanY).abs();

      /*
       * Agregamos un pequeño factor aleatorio
       * para que la selección no sea totalmente
       * predecible.
       */
      final double valorA=
          distanciaA+(math.Random(semilla+a).nextDouble()*45);

      final double valorB=
          distanciaB+(math.Random(semilla+b).nextDouble()*45);

      return valorA.compareTo(valorB);
    });

    for(int i=0;i<cantidad&&i<indices.length;i++){
      final int indice=
      indices[i];

      final Offset base=
      _puntosBase[indice];

      /*
       * Movimiento muy leve para evitar
       * puntos completamente estáticos.
       */
      final double fase=
          (progreso*math.pi*2)+(indice*.63);

      final double movimientoX=
          math.sin(fase)*1.4;

      final double movimientoY=
          math.cos(fase*.82)*1.2;

      resultado.add(
        _PuntoFacial(
          posicion:Offset(
            (base.dx*size.width)+movimientoX,
            (base.dy*size.height)+movimientoY,
          ),
          indice:indice,
          intensidad:.55+(random.nextDouble()*.45),
        ),
      );
    }

    return resultado;
  }

  void _dibujarMarco(
      Canvas canvas,
      Size size,
      ) {

    final double pulso=
        .5+
            (.5*
                math.sin(
                  progreso*math.pi*2,
                ));

    final Paint marco=Paint()
      ..color=const Color(0xFF69C0FF).withOpacity(
        .58+(pulso*.20),
      )
      ..strokeWidth=1.55
      ..style=PaintingStyle.stroke
      ..strokeCap=StrokeCap.round;

    final double ancho=
        size.width*.68;

    final double alto=
        size.height*.70;

    final Rect rect=
    Rect.fromCenter(
      center:Offset(
        size.width/2,
        size.height*.50,
      ),
      width:ancho,
      height:alto,
    );

    const double esquina=18;

    final Path path=Path();

    path.moveTo(
      rect.left,
      rect.top+esquina,
    );

    path.lineTo(
      rect.left,
      rect.top,
    );

    path.lineTo(
      rect.left+esquina,
      rect.top,
    );

    path.moveTo(
      rect.right-esquina,
      rect.top,
    );

    path.lineTo(
      rect.right,
      rect.top,
    );

    path.lineTo(
      rect.right,
      rect.top+esquina,
    );

    path.moveTo(
      rect.right,
      rect.bottom-esquina,
    );

    path.lineTo(
      rect.right,
      rect.bottom,
    );

    path.lineTo(
      rect.right-esquina,
      rect.bottom,
    );

    path.moveTo(
      rect.left+esquina,
      rect.bottom,
    );

    path.lineTo(
      rect.left,
      rect.bottom,
    );

    path.lineTo(
      rect.left,
      rect.bottom-esquina,
    );

    canvas.drawPath(
      path,
      marco,
    );
  }

  void _dibujarPuntos(
      Canvas canvas,
      Size size,
      List<_PuntoFacial> puntos,
      double scanY,
      ) {

    for(final _PuntoFacial puntoFacial in puntos){
      final Offset posicion=
          puntoFacial.posicion;

      final int indice=
          puntoFacial.indice;

      final double distancia=
      (posicion.dy-scanY).abs();

      /*
       * Mayor intensidad cuando la línea
       * está cerca del punto.
       */
      final bool lineaCerca=
          distancia<32;

      final double fase=
          (progreso*math.pi*5)+
              (indice*.92);

      final double pulso=
          (math.sin(fase)+1)/2;

      final double radioBase=
      size.width<180
          ?1.35
          :1.70;

      final double radio=
      lineaCerca
          ?radioBase+1.3+(pulso*.45)
          :radioBase+(pulso*.35);

      /*
       * Halo exterior discreto.
       */
      final Paint halo=Paint()
        ..style=PaintingStyle.fill
        ..color=const Color(0xFF69C0FF).withOpacity(
          lineaCerca
              ?0.25*puntoFacial.intensidad
            :.09*puntoFacial.intensidad,
        );

      canvas.drawCircle(
        posicion,
        radio+
            (lineaCerca?4.5:2.7),
        halo,
      );

      /*
       * Anillo adicional únicamente cuando
       * la línea de escaneo pasa cerca.
       */
      if(lineaCerca){
        final Paint anillo=Paint()
          ..style=PaintingStyle.stroke
          ..strokeWidth=.65
          ..color=const Color(0xFF8BE8FF).withOpacity(
            .34*puntoFacial.intensidad,
          );

        canvas.drawCircle(
          posicion,
          radio+4.8,
          anillo,
        );
      }

      /*
       * Punto principal.
       */
      final Paint punto=Paint()
        ..style=PaintingStyle.fill
        ..color=lineaCerca
            ?Color.lerp(
          const Color(0xFF69C0FF),
          const Color(0xFFD8FAFF),
          pulso,
        )!
            :Color.lerp(
          const Color(0xFF298DD2),
          const Color(0xFF8BE8FF),
          pulso,
        )!.withOpacity(
          .70+
              (.25*puntoFacial.intensidad),
        );

      canvas.drawCircle(
        posicion,
        radio,
        punto,
      );

      /*
       * Pequeño centro blanco.
       */
      final Paint centro=Paint()
        ..style=PaintingStyle.fill
        ..color=Colors.white.withOpacity(
          lineaCerca
              ?0.88
          :.48,
        );

      canvas.drawCircle(
        posicion,
        lineaCerca
            ?0.70
        :.40,
        centro,
      );
    }
  }

  @override
  bool shouldRepaint(
      covariant _FaceFramePainter oldDelegate,
      ){
    return oldDelegate.progreso!=progreso;
  }
}

/*
 * Modelo interno utilizado únicamente
 * por el efecto visual.
 */
class _PuntoFacial {
  final Offset posicion;
  final int indice;
  final double intensidad;

  const _PuntoFacial({
    required this.posicion,
    required this.indice,
    required this.intensidad,
  });
}
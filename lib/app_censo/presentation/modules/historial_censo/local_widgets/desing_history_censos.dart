import 'package:flutter/material.dart';

import '../../../../../app/core/values/app_colors.dart';
import '../../../../../app/presentation/widgets/custom_app_widgets.dart';
import '../../../../data/models/models_censo.dart';
import '../../../../domain/request/request_censo.dart';
import '../../controllers.dart';

class DesingHistoryCensos extends StatelessWidget {
  final DataHistoryCenso data;
  final int index;
  final VoidCallback onPressed;

  const DesingHistoryCensos({
    super.key,
    required this.data,
    required this.index,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return _getDesingHistorialCenso(
      data:data,
      i:index,
    );
  }

  Widget _getDesingHistorialCenso({
    required DataHistoryCenso data,
    required int i,
  }) {
    final bool censado=
        data.estadoCenso.toUpperCase()=="FINALIZADO";

    return Container(
      width:double.infinity,
      margin:const EdgeInsets.only(bottom:5),
      decoration:BoxDecoration(
        color:Colors.white,
        boxShadow:[
          BoxShadow(
            color:const Color(0x8A4A1414).withOpacity(.05),
            blurRadius:8,
            offset:const Offset(0,3),
          ),
        ],
      ),
      child:Column(
        crossAxisAlignment:CrossAxisAlignment.stretch,
        children:[
          /* =====================================================
             CABECERA
             ===================================================== */
          Container(
            padding:const EdgeInsets.symmetric(
              horizontal:10,
              vertical:8,
            ),
            decoration:const BoxDecoration(
              color:Color(0xFFF5F8FB),
              borderRadius:BorderRadius.vertical(
                top:Radius.circular(15),
              ),
            ),
            child:Row(
              children:[
                Container(
                  width:34,
                  height:34,
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
                    borderRadius:BorderRadius.circular(10),
                  ),
                  alignment:Alignment.center,
                  child:Text(
                    '$i',
                    style:const TextStyle(
                      color:Colors.white,
                      fontSize:11,
                      fontWeight:FontWeight.w900,
                    ),
                  ),
                ),

                const SizedBox(width:8),

                const Expanded(
                  child:Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children:[
                      Text(
                        'REGISTRO DE CENSO',
                        style:TextStyle(
                          color:Color(0xFF17365D),
                          fontSize:9.5,
                          fontWeight:FontWeight.w900,
                          letterSpacing:.2,
                        ),
                      ),

                      SizedBox(height:1),

                      Text(
                        'Detalle del registro realizado',
                        style:TextStyle(
                          color:Color(0xFF7A8998),
                          fontSize:6.8,
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
                    color:censado
                        ?const Color(0xFFEAF5EE)
                        :const Color(0xFFFFF3E4),
                    borderRadius:BorderRadius.circular(20),
                  ),
                  child:Row(
                    mainAxisSize:MainAxisSize.min,
                    children:[
                      Icon(
                        censado
                            ?Icons.check_circle_rounded
                            :Icons.schedule_rounded,
                        size:10,
                        color:censado
                            ?const Color(0xFF218A61)
                            :const Color(0xFFD68A1F),
                      ),

                      const SizedBox(width:4),

                      Text(
                        censado
                            ?'FINALIZADO'
                            :'PENDIENTE',
                        style:TextStyle(
                          color:censado
                              ?const Color(0xFF218A61)
                              :const Color(0xFFD68A1F),
                          fontSize:5.9,
                          fontWeight:FontWeight.w900,
                          letterSpacing:.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /* =====================================================
             CONTENIDO
             ===================================================== */

          Padding(
            padding:const EdgeInsets.all(9),
            child:Column(
              children:[

                _campoPrincipal(
                  icon:Icons.event_note_outlined,
                  titulo:'PROCESO',
                  detalle:data.proceso,
                ),

                const SizedBox(height:8),

                Row(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children:[
                    Expanded(
                      child:_campoCompacto(
                        icon:Icons.location_city_outlined,
                        titulo:'RECINTO',
                        detalle:data.recintoCenso,
                      ),
                    ),

                    const SizedBox(width:7),

                    Expanded(
                      child:_campoCompacto(
                        icon:Icons.table_restaurant_outlined,
                        titulo:'MESA',
                        detalle:data.mesaCensado,
                      ),
                    ),
                  ],
                ),

                if(censado)...[
                  const SizedBox(height:8),

                  _campoPrincipal(
                    icon:Icons.person_outline_rounded,
                    titulo:'CENSADO POR',
                    detalle:data.nameCensista,
                    colorIcon:const Color(0xFF218A61),
                    fondoIcon:const Color(0xFFEAF5EE),
                  ),

                  const SizedBox(height:8),

                  Row(
                    children:[
                      Expanded(
                        child:_campoCompacto(
                          icon:Icons.calendar_month_outlined,
                          titulo:'FECHA CENSO',
                          detalle:data.fechaRegistroCenso,
                        ),
                      ),

                      const SizedBox(width:7),

                      Expanded(
                        child:_campoEstadoCensado(
                          censado:data.censado,
                        ),
                      ),
                    ],
                  ),
                ]else...[
                  const SizedBox(height:8),

                  _campoEstadoCensado(
                    censado:data.censado,
                  ),
                ],

                if(censado)...[
                  const SizedBox(height:10),

                  Container(
                    width:double.infinity,
                    height:1,
                    color:const Color(0xFFE5EBF0),
                  ),

                  const SizedBox(height:9),

                  Row(
                    children:[
                      const Expanded(
                        child:Row(
                          children:[
                            Icon(
                              Icons.picture_as_pdf_outlined,
                              color:Color(0xFF7A8998),
                              size:14,
                            ),

                            SizedBox(width:5),

                            Expanded(
                              child:Text(
                                'Comprobante disponible',
                                style:TextStyle(
                                  color:Color(0xFF7A8998),
                                  fontSize:6.8,
                                  fontWeight:FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width:8),

                      Material(
                        color:Colors.transparent,
                        borderRadius:BorderRadius.circular(10),
                        clipBehavior:Clip.antiAlias,
                        child:InkWell(
                          onTap:onPressed,
                          splashColor:const Color(0xFFD84B4B)
                              .withOpacity(.08),
                          child:Ink(
                            height:36,
                            padding:const EdgeInsets.symmetric(
                              horizontal:10,
                            ),
                            decoration:BoxDecoration(
                              color:const Color(0xFFFFF1F1),
                              borderRadius:BorderRadius.circular(10),
                              border:Border.all(
                                color:const Color(0xFFD84B4B)
                                    .withOpacity(.15),
                              ),
                            ),
                            child:const Row(
                              mainAxisSize:MainAxisSize.min,
                              children:[
                                Icon(
                                  Icons.picture_as_pdf_rounded,
                                  color:Color(0xFFD84B4B),
                                  size:15,
                                ),

                                SizedBox(width:5),

                                Text(
                                  'VER PDF',
                                  style:TextStyle(
                                    color:Color(0xFFD84B4B),
                                    fontSize:7.2,
                                    fontWeight:FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _campoPrincipal({
    required IconData icon,
    required String titulo,
    required String detalle,
    Color colorIcon=const Color(0xFF195496),
    Color fondoIcon=const Color(0xFFEAF1F8),
  }) {
    return Container(
      width:double.infinity,
      padding:const EdgeInsets.symmetric(
        horizontal:8,
        vertical:8,
      ),
      decoration:BoxDecoration(
        color:const Color(0xFFF8FAFC),
        borderRadius:BorderRadius.circular(11),
        border:Border.all(
          color:const Color(0xFFE3E9EF),
        ),
      ),
      child:Row(
        crossAxisAlignment:CrossAxisAlignment.start,
        children:[
          Container(
            width:30,
            height:30,
            decoration:BoxDecoration(
              color:fondoIcon,
              borderRadius:BorderRadius.circular(8),
            ),
            child:Icon(
              icon,
              color:colorIcon,
              size:15,
            ),
          ),

          const SizedBox(width:7),

          Expanded(
            child:Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children:[
                Text(
                  titulo,
                  style:const TextStyle(
                    color:Color(0xFF7A8998),
                    fontSize:5.8,
                    fontWeight:FontWeight.w900,
                    letterSpacing:.45,
                  ),
                ),

                const SizedBox(height:2),

                Text(
                  detalle,
                  style:const TextStyle(
                    color:Color(0xFF17365D),
                    fontSize:8.7,
                    fontWeight:FontWeight.w800,
                    height:1.18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _campoCompacto({
    required IconData icon,
    required String titulo,
    required String detalle,
  }) {
    return Container(
      constraints:const BoxConstraints(
        minHeight:68,
      ),
      padding:const EdgeInsets.all(8),
      decoration:BoxDecoration(
        color:const Color(0xFFF8FAFC),
        borderRadius:BorderRadius.circular(11),
        border:Border.all(
          color:const Color(0xFFE3E9EF),
        ),
      ),
      child:Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children:[
          Row(
            children:[
              Container(
                width:25,
                height:25,
                decoration:BoxDecoration(
                  color:const Color(0xFFEAF1F8),
                  borderRadius:BorderRadius.circular(7),
                ),
                child:Icon(
                  icon,
                  color:const Color(0xFF195496),
                  size:13,
                ),
              ),

              const SizedBox(width:5),

              Expanded(
                child:Text(
                  titulo,
                  maxLines:1,
                  overflow:TextOverflow.ellipsis,
                  style:const TextStyle(
                    color:Color(0xFF7A8998),
                    fontSize:5.7,
                    fontWeight:FontWeight.w900,
                    letterSpacing:.3,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height:6),

          Text(
            detalle,
            maxLines:3,
            overflow:TextOverflow.ellipsis,
            style:const TextStyle(
              color:Color(0xFF17365D),
              fontSize:8,
              fontWeight:FontWeight.w800,
              height:1.15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _campoEstadoCensado({
    required bool censado,
  }) {
    return Container(
      constraints:const BoxConstraints(
        minHeight:68,
      ),
      padding:const EdgeInsets.all(8),
      decoration:BoxDecoration(
        color:censado
            ?const Color(0xFFF0F8F4)
            :const Color(0xFFFFF8EA),
        borderRadius:BorderRadius.circular(11),
        border:Border.all(
          color:censado
              ?const Color(0xFF218A61).withOpacity(.15)
              :const Color(0xFFD68A1F).withOpacity(.15),
        ),
      ),
      child:Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children:[
          Row(
            children:[
              Container(
                width:25,
                height:25,
                decoration:BoxDecoration(
                  color:censado
                      ?const Color(0xFFE1F2E9)
                      :const Color(0xFFFFEDD4),
                  borderRadius:BorderRadius.circular(7),
                ),
                child:Icon(
                  censado
                      ?Icons.verified_user_outlined
                      :Icons.person_off_outlined,
                  color:censado
                      ?const Color(0xFF218A61)
                      :const Color(0xFFD68A1F),
                  size:13,
                ),
              ),

              const SizedBox(width:5),

              const Expanded(
                child:Text(
                  'CENSADO',
                  style:TextStyle(
                    color:Color(0xFF7A8998),
                    fontSize:5.7,
                    fontWeight:FontWeight.w900,
                    letterSpacing:.3,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height:6),

          Row(
            children:[
              Icon(
                censado
                    ?Icons.check_circle_rounded
                    :Icons.cancel_outlined,
                color:censado
                    ?const Color(0xFF218A61)
                    :const Color(0xFFD68A1F),
                size:14,
              ),

              const SizedBox(width:5),

              Text(
                censado
                    ?'SÍ'
                    :'NO',
                style:TextStyle(
                  color:censado
                      ?const Color(0xFF218A61)
                      :const Color(0xFFD68A1F),
                  fontSize:9,
                  fontWeight:FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

import '../../../../app/core/utils/photo_helper.dart';
import '../../../../app/core/utils/utilidadesUtil.dart';
import '../../../../app/presentation/widgets/custom_app_widgets.dart';
import '../../core/utils/qr_scanner.dart';

class QrViewWidget extends StatefulWidget {
  final ValueChanged<String> dataQrChange;

  const QrViewWidget({
    super.key,
    required this.dataQrChange,
  });

  @override
  State<QrViewWidget> createState()=>_QrViewWidgetState();
}

class _QrViewWidgetState extends State<QrViewWidget> {
  Barcode? result;
  QRViewController? controller;

  bool cargando=false;
  bool procesandoQr=false;

  final GlobalKey qrKey=GlobalKey(
    debugLabel:'QR',
  );

  @override
  void reassemble() {
    super.reassemble();

    if(controller==null)return;

    if(UtilidadesUtil.plataformaIsAndroid){
      controller!.pauseCamera();
    }

    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:CrossAxisAlignment.stretch,
      children:[
        _cabeceraScanner(),

        const SizedBox(height:10),

        _scannerCard(context),

        const SizedBox(height:10),

        _controlesScanner(),

       // const SizedBox(height:10),

        //_btnGaleria(),

        if(result!=null&&result!.code!=null)...[
          const SizedBox(height:10),
          _estadoLectura(),
        ],
      ],
    );
  }

  Widget _cabeceraScanner() {
    return Container(
      width:double.infinity,
      padding:const EdgeInsets.fromLTRB(11,10,11,10),
      decoration:BoxDecoration(
        color:Colors.white,
        borderRadius:BorderRadius.circular(16),
        border:Border.all(
          color:const Color(0xFF195496).withOpacity(.10),
        ),
        boxShadow:[
          BoxShadow(
            color:const Color(0xFF17365D).withOpacity(.06),
            blurRadius:10,
            offset:const Offset(0,3),
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
              Icons.qr_code_scanner_rounded,
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
                  'ESCANEAR CÓDIGO QR',
                  style:TextStyle(
                    color:Color(0xFF17365D),
                    fontSize:11.5,
                    fontWeight:FontWeight.w900,
                  ),
                ),

                SizedBox(height:2),

                Text(
                  'Ubique el código dentro del área de lectura',
                  style:TextStyle(
                    color:Color(0xFF7A8998),
                    fontSize:7.8,
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
                  'CÁMARA',
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

  Widget _scannerCard(BuildContext context) {
    return Container(
      width:double.infinity,
      height:MediaQuery.of(context).size.height*.42,
      decoration:BoxDecoration(
        color:const Color(0xFF0B1724),
        borderRadius:BorderRadius.circular(20),
        border:Border.all(
          color:const Color(0xFFDCE4EC),
        ),
        boxShadow:[
          BoxShadow(
            color:const Color(0xFF17365D).withOpacity(.16),
            blurRadius:14,
            offset:const Offset(0,5),
          ),
        ],
      ),
      clipBehavior:Clip.antiAlias,
      child:Stack(
        children:[
          Positioned.fill(
            child:_buildQrView(context),
          ),

          Positioned(
            left:0,
            right:0,
            top:13,
            child:Center(
              child:Container(
                padding:const EdgeInsets.symmetric(
                  horizontal:10,
                  vertical:5,
                ),
                decoration:BoxDecoration(
                  color:Colors.black.withOpacity(.50),
                  borderRadius:BorderRadius.circular(20),
                ),
                child:const Row(
                  mainAxisSize:MainAxisSize.min,
                  children:[
                    Icon(
                      Icons.center_focus_strong_rounded,
                      color:Colors.white,
                      size:13,
                    ),
                    SizedBox(width:5),
                    Text(
                      'CENTRE EL CÓDIGO QR',
                      style:TextStyle(
                        color:Colors.white,
                        fontSize:7,
                        fontWeight:FontWeight.w900,
                        letterSpacing:.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          if(cargando||procesandoQr)
            Positioned.fill(
              child:Container(
                color:Colors.black.withOpacity(.62),
                child:const Center(
                  child:Column(
                    mainAxisSize:MainAxisSize.min,
                    children:[
                      SizedBox(
                        width:30,
                        height:30,
                        child:CircularProgressIndicator(
                          strokeWidth:3,
                          color:Colors.white,
                        ),
                      ),

                      SizedBox(height:10),

                      Text(
                        'PROCESANDO CÓDIGO...',
                        style:TextStyle(
                          color:Colors.white,
                          fontSize:8.5,
                          fontWeight:FontWeight.w900,
                          letterSpacing:.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _controlesScanner() {
    return Row(
      children:[
        Expanded(
          child:_botonControl(
            icon:Icons.flash_on_rounded,
            titulo:'FLASH',
            subtitulo:'Iluminar código',
            onTap:() async {
              await controller?.toggleFlash();

              if(mounted){
                setState((){});
              }
            },
            trailing:FutureBuilder<bool?>(
              future:controller?.getFlashStatus(),
              builder:(context,snapshot){
                final bool activo=snapshot.data??false;

                return Icon(
                  activo
                      ?Icons.toggle_on_rounded
                      :Icons.toggle_off_rounded,
                  color:activo
                      ?const Color(0xFF218A61)
                      :const Color(0xFF9AA7B4),
                  size:28,
                );
              },
            ),
          ),
        ),

        const SizedBox(width:9),

        Expanded(
          child:_botonControl(
            icon:Icons.cameraswitch_rounded,
            titulo:'CÁMARA',
            subtitulo:'Cambiar cámara',
            onTap:() async {
              await controller?.flipCamera();

              if(mounted){
                setState((){});
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _botonControl({
    required IconData icon,
    required String titulo,
    required String subtitulo,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return Material(
      color:Colors.transparent,
      borderRadius:BorderRadius.circular(14),
      clipBehavior:Clip.antiAlias,
      child:InkWell(
        onTap:onTap,
        splashColor:const Color(0xFF195496).withOpacity(.08),
        child:Ink(
          padding:const EdgeInsets.all(9),
          decoration:BoxDecoration(
            color:Colors.white,
            borderRadius:BorderRadius.circular(14),
            border:Border.all(
              color:const Color(0xFFDCE4EC),
            ),
          ),
          child:Row(
            children:[
              Container(
                width:37,
                height:37,
                decoration:BoxDecoration(
                  color:const Color(0xFFEAF1F8),
                  borderRadius:BorderRadius.circular(10),
                ),
                child:Icon(
                  icon,
                  color:const Color(0xFF195496),
                  size:18,
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
                        color:Color(0xFF17365D),
                        fontSize:8.5,
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
                        fontSize:6.5,
                      ),
                    ),
                  ],
                ),
              ),

              if(trailing!=null)
                trailing,
            ],
          ),
        ),
      ),
    );
  }

  Widget _btnGaleria() {
    return Material(
      color:Colors.transparent,
      borderRadius:BorderRadius.circular(15),
      clipBehavior:Clip.antiAlias,
      child:InkWell(
        onTap:cargando
            ?null
            :() async {
          setState((){
            cargando=true;
          });

          await getImageGallery();

          if(mounted){
            setState((){
              cargando=false;
            });
          }
        },
        splashColor:const Color(0xFF195496).withOpacity(.08),
        child:Ink(
          width:double.infinity,
          padding:const EdgeInsets.fromLTRB(10,9,9,9),
          decoration:BoxDecoration(
            color:Colors.white,
            borderRadius:BorderRadius.circular(15),
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
          child:Row(
            children:[
              Container(
                width:46,
                height:46,
                decoration:BoxDecoration(
                  color:const Color(0xFFF0F5FB),
                  borderRadius:BorderRadius.circular(12),
                ),
                child:const Icon(
                  Icons.photo_library_outlined,
                  color:Color(0xFF195496),
                  size:21,
                ),
              ),
              const SizedBox(width:10),
              Expanded(
                child:Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children:[
                    Container(
                      padding:const EdgeInsets.symmetric(
                        horizontal:6,
                        vertical:2,
                      ),
                      decoration:const BoxDecoration(
                        color:Color(0xFFEAF1F8),
                        borderRadius:BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child:const Text(
                        'CENSO',
                        style:TextStyle(
                          color:Color(0xFF195496),
                          fontSize:6,
                          fontWeight:FontWeight.w900,
                        ),
                      ),
                    ),

                    const SizedBox(height:4),

                    const Text(
                      'QR DESDE GALERÍA',
                      style:TextStyle(
                        color:Color(0xFF17365D),
                        fontSize:9.5,
                        fontWeight:FontWeight.w900,
                      ),
                    ),

                    const SizedBox(height:2),

                    const Text(
                      'Seleccionar una imagen que contenga el código QR',
                      style:TextStyle(
                        color:Color(0xFF7A8998),
                        fontSize:7,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width:31,
                height:31,
                decoration:BoxDecoration(
                  color:Color(0xFFEAF1F8),
                  borderRadius:BorderRadius.all(
                    Radius.circular(9),
                  ),
                ),
                child:const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color:Color(0xFF195496),
                  size:12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _estadoLectura() {
    return Container(
      width:double.infinity,
      padding:const EdgeInsets.all(9),
      decoration:BoxDecoration(
        color:const Color(0xFFEAF5EE),
        borderRadius:BorderRadius.circular(13),
        border:Border.all(
          color:const Color(0xFF218A61).withOpacity(.18),
        ),
      ),
      child:const Row(
        children:[
          Icon(
            Icons.qr_code_2_rounded,
            color:Color(0xFF218A61),
            size:19,
          ),

          SizedBox(width:8),

          Expanded(
            child:Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children:[
                Text(
                  'CÓDIGO QR DETECTADO',
                  style:TextStyle(
                    color:Color(0xFF218A61),
                    fontSize:8,
                    fontWeight:FontWeight.w900,
                  ),
                ),

                SizedBox(height:1),

                Text(
                  'La información está siendo validada',
                  style:TextStyle(
                    color:Color(0xFF68798A),
                    fontSize:6.8,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;

    /*
      Mucho mejor que 400:
      evita que el marco QR se salga de pantallas pequeñas.
    */
    final double scanArea=
    width<380
        ?220
        :width<450
        ?250
        :280;

    return QRView(
      key:qrKey,
      onQRViewCreated:_onQRViewCreated,
      overlay:QrScannerOverlayShape(
        borderColor:const Color(0xFF4FA3F7),
        borderRadius:18,
        borderLength:34,
        borderWidth:6,
        cutOutSize:scanArea,
      ),
      onPermissionSet:(ctrl,p)=>_onPermissionSet(
        context,
        ctrl,
        p,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller=controller;

    controller.scannedDataStream.listen(
          (scanData) async {
        if(procesandoQr)return;

        final String? codigo=scanData.code;

        if(codigo==null||codigo.trim().isEmpty){
          return;
        }

        /*
          Evitamos procesar repetidamente el mismo QR.
        */
        if(result?.code==codigo)return;

        if(mounted){
          setState((){
            result=scanData;
            procesandoQr=true;
          });
        }

        await controller.pauseCamera();

        try{
          widget.dataQrChange(codigo);
        }finally{
          /*
            Dejamos una pequeña pausa para que la validación
            no se dispare varias veces seguidas.
          */
          await Future.delayed(
            const Duration(milliseconds:900),
          );

          if(mounted){
            setState((){
              procesandoQr=false;
            });
          }
        }
      },
    );
  }

  Future<void> getImageGallery() async {
    GaleryCameraModel? mGaleryCameraModel;

    try{
      mGaleryCameraModel=
      await PhotoHelper.getImageGallery(
        "QR-",
      );

      if(mGaleryCameraModel==null)return;

      final String? qrData=
      await QrScanner.decodeQRCodeFromFile(
        mGaleryCameraModel.image,
      );

      if(qrData==null||qrData.trim().isEmpty){
        DialogosAwesome.getWarning(
          descripcion:
          "El código QR no es válido. Por favor, intenta escanear uno nuevo.",
        );
        return;
      }

      try{
        Uint8List bytes=
        Uint8List.fromList(
          qrData.codeUnits,
        );

        String decodedText=
        utf8.decode(bytes);

        print(
          "Texto decodificado: $decodedText",
        );
      }catch(e){
        print(
          "Error al decodificar UTF-8: $e",
        );

        print(
          "Texto original: $qrData",
        );
      }

      print(
        "Datos del código QR desde galeria: $qrData",
      );

      widget.dataQrChange(qrData);
    }catch(e){
      DialogosAwesome.getWarning(
        descripcion:
        "No se pudo cargar el QR, por favor vuelva a intentar",
      );
    }
  }

  void _onPermissionSet(
      BuildContext context,
      QRViewController ctrl,
      bool p,
      ) {
    log(
      '${DateTime.now().toIso8601String()}_onPermissionSet $p',
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
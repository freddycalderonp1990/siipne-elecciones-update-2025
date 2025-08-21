

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

import '../../../../app/core/utils/photo_helper.dart';
import '../../../../app/core/utils/responsiveUtil.dart';
import '../../../../app/core/utils/utilidadesUtil.dart';
import '../../../../app/core/values/app_colors.dart';
import '../../../../app/presentation/widgets/custom_app_widgets.dart';
import '../../core/utils/qr_scanner.dart';

class QrViewWidget extends StatefulWidget {
  final ValueChanged<String> dataQrChange;


  const QrViewWidget({super.key, required this.dataQrChange});

  @override
  State<QrViewWidget> createState() => _QrViewWidgetState();
}

class _QrViewWidgetState extends State<QrViewWidget> {
  Barcode? result;
  QRViewController? controller;
  bool cargando=false;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (UtilidadesUtil.plataformaIsAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();

    print("data del qr es en show qr ${result}");
    if (result != null && result!.code != null) {

      print("data del qr es en show qr ${result!.code!}");
      widget.dataQrChange(result!.code!);
    }
    return Container(
      height: responsive.altoP(50),
      child: Column(
        children: <Widget>[
          Expanded(flex: 2, child:cargando?Center(child: Text("Espere....")): _buildQrView(context)),
          Flexible(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Text('Barcode Type: ${describeEnum(result!.format)}')
                  else
                    TituloTextWidget(title: "Escanea el código QR"),

                  Row(
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            AppColors.colorBotones,
                          ), // Cambia el color de fondo del botón
                          // Puedes ajustar otros atributos del botón aquí, como la forma, el borde, etc.
                        ),
                        onPressed: () async {
                          await controller?.toggleFlash();
                          setState(() {});
                        },
                        child: FutureBuilder(
                          future: controller?.getFlashStatus(),
                          builder: (context, snapshot) {
                            IconData icon = Icons.flash_off;
                            if (snapshot.data != null) {
                              if (snapshot.data!) {
                                icon = Icons.flash_on;
                              }
                            }

                            return Icon(icon, color: Colors.white);
                          },
                        ),
                      ),
                      SizedBox(width: 5, height: 5),

                      Container(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.colorBotones,
                            ), // Cambia el color de fondo del botón
                            // Puedes ajustar otros atributos del botón aquí, como la forma, el borde, etc.
                          ),
                          onPressed: () async {
                            await controller?.flipCamera();
                            setState(() {});
                          },
                          child: FutureBuilder(
                            future: controller?.getCameraInfo(),
                            builder: (context, snapshot) {
                              IconData icon = Icons.photo_camera_front_outlined;

                              if (snapshot.data == CameraFacing.front) {
                                icon = Icons.camera_front;
                              }

                              return Icon(icon, color: Colors.white);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 5, width: 5),

                  BotonesWidget(
                    title: 'QR desde Galeria',
                    onPressed: () async {
                     setState(() {
                       cargando=true;
                     });
                    await  getImageGallery();
                     setState(() {
                       cargando=false;
                     });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget desingBtn({required String title, VoidCallback? onPressed}) {
    return Container(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            AppColors.colorBotones,
          ), // Cambia el color de fondo del botón
          // Puedes ajustar otros atributos del botón aquí, como la forma, el borde, etc.
        ),
        onPressed: onPressed,
        child: FutureBuilder(
          future: controller?.getCameraInfo(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return TituloTextWidget(
                colorTitulo: Colors.white,
                title: title + " ${describeEnum(snapshot.data!)}",
              );
            } else {
              return const Text('loading');
            }
          },
        ),
      ),
    );
  }

  Future getImageGallery() async {
    GaleryCameraModel? mGaleryCameraModel;
    try {
      mGaleryCameraModel = await PhotoHelper.getImageGallery("QR-");

      if (mGaleryCameraModel != null) {
        //nomImg = mGaleryCameraModel!.nombreImg;
        // Ahora, decodifica el código QR desde la imagen
        // final String? qrData = await Scan.parse(mGaleryCameraModel!.imageFile.path);
        // Uso:

        final String? qrData = await QrScanner.decodeQRCodeFromFile(
          mGaleryCameraModel.image,
        );

        if (qrData != null) {

          try {
            // Convierte el string a bytes y luego intenta decodificarlo como UTF-8
            Uint8List bytes = Uint8List.fromList(qrData.codeUnits);
            String decodedText = utf8.decode(bytes);
            print("Texto decodificado: $decodedText");
            widget.dataQrChange(qrData);
          } catch (e) {
            print("Error al decodificar UTF-8: $e");
            print("Texto original: $qrData");
          }




          print("Datos del código QR desde galeria: $qrData");


        } else {
          DialogosAwesome.getWarning(
            descripcion: "El código QR no es válido. Por favor, intenta escanear uno nuevo.",

          );
        }
      }
    } catch (e) {
      String msj = "No se pudo cargar el QR, por favor vuelva a intentar";
      DialogosAwesome.getWarning(descripcion: msj);
    }
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea =
        (MediaQuery.of(context).size.width < 400 ||
                MediaQuery.of(context).size.height < 400)
            ? 250.0
            : 400.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      /*  ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('NO TIENE PERMISOS')),
      );*/
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

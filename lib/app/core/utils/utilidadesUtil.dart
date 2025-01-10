
import 'dart:typed_data';
import 'dart:ui';


import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';



import 'package:flutter/material.dart';





import '../../../app_elecciones/presentation/widgets/customWidgets.dart';

class UtilidadesUtil {

  static Future<Uint8List>  captureToImg(GlobalKey keyWidgetShared) async {

    Uint8List data=await Future.delayed(const Duration(milliseconds: 40), () async {
      RenderRepaintBoundary boundary =
      keyWidgetShared.currentContext!.findRenderObject() as RenderRepaintBoundary;

      var image = await boundary.toImage(pixelRatio: 2.0);
      var byteData = await image.toByteData(format: ImageByteFormat.png);

      return byteData!.buffer.asUint8List();

    });


    return data;
  }

  static Future<void> goToAppMap2(double lat, double lng) async {
    print("geo:$lat,$lng");

    Uri url = Uri.parse('geo:$lat,$lng?q=$lat,$lng');
    try {
      await launchUrl(url);
    } catch (e) {
      DialogosAwesome.getWarning(
          descripcion: "No se completo la operación de cargar la ruta" );
    }


  }

  //esta arreglado para que funcione en Android e Ios
  static Future<void> goToAppMap(double lat, double lng) async {
    final Uri androidUri = Uri.parse('geo:$lat,$lng?q=$lat,$lng');
    final Uri iosUri = Uri.parse('http://maps.apple.com/?q=$lat,$lng');

    try {
      // Verificar plataforma
      if (await canLaunchUrl(androidUri)) {
        await launchUrl(androidUri, mode: LaunchMode.externalApplication);
      } else if (await canLaunchUrl(iosUri)) {
        await launchUrl(iosUri, mode: LaunchMode.externalApplication);
      } else {
        throw Exception("No se pudo abrir el mapa");
      }
    } catch (e) {
      DialogosAwesome.getWarning(
        descripcion: "No se completó la operación de cargar la ruta",
      );
    }
  }
  static Future<void> lanzarLlamada(String num) async {
    try {
      String url =
          'tel://$num'; //donde $phoneNumber es el numero de teléfono que queremos marcar

      abrirUrl(url);
    } catch (e) {
      DialogosAwesome.getWarning(
          descripcion: "No se pudo realizar la llamada al número:" + num);
    }
  }
  static compartirImgCapture(GlobalKey keyWidgetShared) async{
    //se comparte
    var pngBytes = await captureToImg(keyWidgetShared);

    final shareResult = await Share.shareXFiles(
      [
        XFile.fromData(
          pngBytes,
          name: 'img_pagme.png',
          mimeType: 'image/png',
        ),
      ],

    );

  }
  static  bool get plataformaIsAndroid {
    return GetPlatform.isAndroid;

  }

  static bool get plataformaIsIos {
    return GetPlatform.isIOS;
  }

  //utilizada en el parseModel
  static double redondearDouble(double value, {int decimales = 4}) {
    String r = value.toStringAsFixed(decimales);

    return double.parse(r);
  }

  static MaterialColor convertirAColorMaterial(Color color) {
    return MaterialColor(color.value, <int, Color>{
      50: color.withOpacity(0.1),
      100: color.withOpacity(0.2),
      200: color.withOpacity(0.3),
      300: color.withOpacity(0.4),
      400: color.withOpacity(0.5),
      500: color.withOpacity(0.6),
      600: color.withOpacity(0.7),
      700: color.withOpacity(0.8),
      800: color.withOpacity(0.9),
      900: color.withOpacity(1.0),
    });
  }



  static void ocultarTeclado(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }






  static abrirUrl(String url) async {
    try {
      Uri urlUri = Uri.parse(url.trim());

      await launchUrl(urlUri);
    } catch (e) {
      DialogosAwesome.getWarning(descripcion: "No se pudo cargar la página");
    }
  }


}

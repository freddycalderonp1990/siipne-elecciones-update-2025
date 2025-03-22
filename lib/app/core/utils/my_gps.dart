import 'dart:async';

import '../../../../../app/core/utils/responsiveUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as myGeolocator;
import 'package:get/get.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:latlong2/latlong.dart';

import '../../../app_elecciones/presentation/widgets/customWidgets.dart';
import '../../presentation/widgets/custom_app_widgets.dart';
import '../app_config.dart';

class MyGps {
  static myGeolocator.LocationSettings get getConfig {
    final myGeolocator.LocationSettings locationSettings =
        myGeolocator.LocationSettings(
      accuracy: myGeolocator.LocationAccuracy.high,
      distanceFilter: 3,
    );
    return locationSettings;
  }

  static Future<bool> verificarGPS() async {
    cancelarSeguimiento();
    AppConfig.ubicacionLista.value = false;

    final status = await Permission.location.request();
    if (status == PermissionStatus.permanentlyDenied) {
      //await  openAppSettings();

      String msj =
          "\nPara que la aplicación pueda funcionar correctamente, necesitamos acceder a la ubicación de su dispositivo con la finalidad de mostrarle los beneficios cercanos a su ubicación.";
      DialogosAwesome.getWarningSiNo(
          descripcion: msj + "\n\n ¿Desea activar la ubicación?",
          title: "Permisos de Ubicación",
          btnOkOnPress: () async {
            await  openAppSettings();
          },
          btnCancelOnPress: () {});
      return false;
    }

    //permisos denegas por completo
    //Redirecciona al usuario para que de manuera manual asigne los permisos

    // PermisoGPS verifica si el usuario ya dio permisos
    bool permisoGPS = await Permission.location.isGranted;

    //True el usuario dio permisos
    if (!permisoGPS) {
      String msj =
          "Necesitamos acceder a la ubicación del Dispositivo.\n\n ¿Desea activar los Permisos de la Ubicación?";

      DialogosDesingWidget.getDialogo(contenido: DesingPermisosGps(
        onPressed: () async {
          permisoGPS = await _checkGpsPermisoStatus2();
          Get.back();
        },
      ));

      return false;
    }

    //verificamos que el GPS del dispositivo este encendido
    final gpsActivo = await myGeolocator.Geolocator.isLocationServiceEnabled();
    if (!gpsActivo) {
      String msj =
          "Necesitamos acceder a la ubicación del Dispositivo.\n\n Por favor active el GPS - Ubicación  de su dispositivo";
      DialogosAwesome.getWarning(
          descripcion: msj,
          btnOkOnPress: () {
            Get.back();
          });
      return false;
    }

    if (permisoGPS && gpsActivo) {
      return true;
    } else {
      DialogosAwesome.getError(
          descripcion:
              "No se puede obtener información del GSP. Es necesario los permisos del Gps para continuar",
          title: "Error Gps");
      return false;
    }
  }

  static Future<bool> _checkGpsPermisoStatus2() async {
    final status = await Permission.location.request();

    print("status");
    print(status);

    bool result = false;
    switch (status) {
      case PermissionStatus.granted:
        // GPS está activo verifica si el gps del dispositivo se encuentra activo
        final gpsActivo =
            await myGeolocator.Geolocator.isLocationServiceEnabled();
        result = true;

        break;

      case PermissionStatus.limited:
      //indeterminado

      case PermissionStatus.denied:
      //denegado

      case PermissionStatus.restricted:
      //restringida

      case PermissionStatus.permanentlyDenied:
        //permisos denegas por completo
        //Redirecciona al usuario para que de manuera manual asigne los permisos
        result = await openAppSettings();
      case PermissionStatus.provisional:
      // TODO: Handle this case.
    }

    return result;
  }

  static Future iniciarSeguimiento() async {
    bool gpsListo = await verificarGPS();
    if (!gpsListo) {
      return;
    }

    if (AppConfig.positionSubscription == null) {
      print("iniciarSeguimiento");

      final positionStream = myGeolocator.Geolocator.getPositionStream(
          locationSettings: MyGps.getConfig);
      AppConfig.positionSubscription = positionStream.handleError((error) {
        print("tcambia ubicacion ${error}");
        AppConfig.positionSubscription!.cancel();
        AppConfig.positionSubscription = null;
      }).listen((position) {
       /* AppConfig.ubicacion.value =
            LatLng(position.latitude, position.longitude);
        print(
            "cambia ubicacion ${AppConfig.ubicacion.value.latitude}, ${AppConfig.ubicacion.value.longitude}");*/
        AppConfig.ubicacionLista.value = true;
      });
    }
  }

  static void cancelarSeguimiento() {
    AppConfig.positionSubscription?.cancel();
    AppConfig.positionSubscription = null;
  }
}

class DesingPermisosGps extends StatefulWidget {
  final VoidCallback? onPressed;

  const DesingPermisosGps({super.key, this.onPressed});

  @override
  State<DesingPermisosGps> createState() => _DesingPermisosGpsState();
}

class _DesingPermisosGpsState extends State<DesingPermisosGps> {
  @override
  Widget build(BuildContext context) {
    return desing();
  }

  Widget desing() {
    final responsive = ResponsiveUtil();
    return Container(
        margin: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            getTitle(),
            Icon(
                size: responsive.diagonalP(4),
                Icons.location_on,
                color: Colors.red),
            SizedBox(
              height: 10,
            ),
            getDerscripcion(),
            SizedBox(
              height: 10,
            ),

            getIconText(
                "Acceder a tu ubicación nos ayuda a mostrarte los beneficios cercanos a tu ubicación"),
            SizedBox(
              height: responsive.altoP(6),
            ),
            BotonesWidget(
              title: 'Continuar',
              onPressed: widget.onPressed,
            )
          ],
        ));
  }

  Widget getTitle() {
    final responsive = ResponsiveUtil();
    return getTextSombra("PERMISOS DE UBICACIÓN", responsive.diagonalP(2));
  }

  Widget getDerscripcion() {
    final responsive = ResponsiveUtil();
    return Text(
      "Necesitamos acceder a la ubicación del Dispositivo.",
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: responsive.diagonalP(1.5),
      ),
    );
  }

  Widget getTextSombra(String text, double size) {
    Color colorTexto = Colors.black;
    Color colorSombra = Colors.white;

    return Text(
      text,
      style: TextStyle(
          color: colorTexto,
          shadows: [
            Shadow(
              blurRadius: 10,
              color: colorSombra,
              offset: Offset(2, 2),
            ),
            Shadow(
              blurRadius: 10,
              color: colorSombra,
              offset: Offset(-2, 2),
            ),
          ],
          fontWeight: FontWeight.bold,
          fontSize: size),
    );
  }

  Widget getIconText(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Icon(
            Icons.check_circle,
            color: Color.fromRGBO(22, 73, 135, 1),
          ),
        ),
        Expanded(
            flex: 8,
            child: Text(
              text,
              textAlign: TextAlign.justify,
            ))
      ],
    );
  }
}

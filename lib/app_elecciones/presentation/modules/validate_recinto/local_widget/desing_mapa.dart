import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'package:siipnemovil2/app/core/utils/utilidadesUtil.dart';

import '../../../../../../app/core/utils/responsiveUtil.dart';
import '../../../../../../app/core/values/app_colors.dart';
import '../../../../../../app/presentation/widgets/custom_app_widgets.dart';
import '../../../../../feactures/mapas/openstreetmap.dart';
import '../../../../../feactures/mapas/widgets/custom_btn_map.dart';
import '../../../../../feactures/mapas/widgets/custom_marker.dart';
import '../../../../data/models/models.dart';

class DesingMapaRecinto extends StatefulWidget {
  final LatLng ubicacion;
  final MapController mapController;
  final ValueChanged<LatLng> tapComplete;
  final VoidCallback? onPressedSave;

  final List<RecintosElectoral> listRecintosElectorales;

  final GestureTapCallback ontapMyUbicacion;
  final bool cargando;

  const DesingMapaRecinto({
    super.key,
    required this.ubicacion,

    required this.mapController,
    required this.tapComplete,
    required this.ontapMyUbicacion,
    required this.listRecintosElectorales,
     this.onPressedSave,
    this.cargando = false,
  });

  @override
  State<DesingMapaRecinto> createState() => _DesingMapaRecintoState();
}

class _DesingMapaRecintoState extends State<DesingMapaRecinto> {
  final _mapKey = GlobalKey(); // 👈 clave para el FlutterMap
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.colorPrimary, // color sólido
        statusBarIconBrightness: Brightness.light, // íconos claros
      ),
    );
    return Scaffold(
      backgroundColor: AppColors.colorPrimary,
      body: Stack(
        children: <Widget>[
          FlutterMap(
            key: _mapKey, // 👈 importante
            mapController: widget.mapController,
            options: MapOptions(
              onTap: (tapPosition, point) {
                print("Tap en mapa");

               // widget.tapComplete(point);
                //   widget.mapController.move(point, 18);
              },
              initialCenter: widget.ubicacion,
              minZoom: 5.0,
              maxZoom: 25.0,
              initialZoom: 18,
            ),
            children: [Openstreetmap.getMapa(), getMarker(), getMarkerRecinto()],
          ),

          getBtnAtras(),
          getBotonera(),


          CargandoWidget(mostrar: widget.cargando),
        ],
      ),
    );
  }





  MarkerLayer getMarker() {
    return MarkerLayer(
      markers: [
        Marker(
          height: 90,
          width: 90,
          rotate: true,
          point: widget.ubicacion,
          child: CustomMarker(
            colorIcon: Colors.red,
            icon: Icons.person_pin_circle_rounded,
            onTap: () {}, zoom:widget. mapController.camera.zoom,
          ),
        ),
      ],
    );
  }


  MarkerLayer getMarkerRecinto() {
    List<Marker> markers = widget.listRecintosElectorales.map((recinto) {
      return Marker(
        width: 70,
        height: 70,
        point: LatLng(recinto.latitud, recinto.longitud),
        child: CustomMarker(
          zoom:widget. mapController.camera.zoom, // 👈 aquí está la clave
label: recinto.nomRecintoElecOnly,
          colorIcon: recinto.validado?Colors.green:Colors.white,
          icon: Icons.home_work,
          onTap: () {
            print("Recinto: ${recinto.nomRecintoElec}");
          },
        ),
      );
    }).toList();

    return MarkerLayer(markers: markers);
  }



  Widget getBotonera() {
    final responsive = ResponsiveUtil();
    return Stack(
      children: [
        /// Botones a la derecha (ubicación + zoom)
        Positioned(
          bottom: responsive.altoP(1),
          right: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              getBtnMyUbicacion(),
              SizedBox(height: responsive.altoP(2)),
              getBtnZoom(),
            ],
          ),
        ),

        /// Botones centrados (lat/long + guardar)
        Positioned(
          bottom: responsive.altoP(1),
          left: 0,
          right: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getTextLatLongitud(),
              btnGuardar(),
              SizedBox(height: responsive.altoP(2)),
            ],
          ),
        ),
      ],
    );
  }


  Widget btnGuardar(){
    return
      BtnIconWidget(
        icon: Icons.save,
        titulo: "GUARDAR",
        onPressed: widget.onPressedSave,

      );
  }
  Widget getBtnZoom() {
    double padding = 2.0;
    Widget wgZoom = Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: padding, top: padding, right: padding),
          child: CustomBtnMap(
            icon: Icons.zoom_in,
            onTap: () {
              final zoomActual = widget.mapController.camera.zoom;
              widget.mapController.move(
                widget.mapController.camera.center,
                zoomActual + 1, // zoom in
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(padding),
          child: CustomBtnMap(
            icon: Icons.zoom_out,
            onTap: () {
              final zoomActual = widget.mapController.camera.zoom;
              widget.mapController.move(
                widget.mapController.camera.center,
                zoomActual - 1, // zoom out
              );
            },
          ),
        ),
      ],
    );

    return wgZoom;
  }

  Widget getBtnMyUbicacion() {
    final responsive = ResponsiveUtil();
    return CustomBtnMap(
      icon: Icons.my_location,
      onTap: widget.ontapMyUbicacion,
    );
  }

  Widget getBtnAtras() {
    final responsive = ResponsiveUtil();
    return Positioned(
      top: responsive.altoP(5),
      left: 0,
      child: CustomBtnMap(
        icon: Icons.arrow_back,

        onTap: () {
          Get.back();
        },
      ),
    );
  }

  Widget getTextLatLongitud() {
    final responsive = ResponsiveUtil();
    return Container(
      width: responsive.anchoP(100),
      color: Colors.transparent,
      child: TextSombrasWidget(
        colorSombra: Colors.white,
        title:
            "Latitud: ${UtilidadesUtil.redondearDouble(widget.ubicacion.latitude, decimales: 6)} - Longitud: ${UtilidadesUtil.redondearDouble(widget.ubicacion.longitude, decimales: 6)}",
      ),
    );
  }


}

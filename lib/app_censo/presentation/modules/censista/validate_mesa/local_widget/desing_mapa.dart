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

class DesingMapa extends StatefulWidget {
  final LatLng ubicacion;
  final MapController mapController;
  final ValueChanged<LatLng> tapComplete;
  final VoidCallback? onPressedSave;

  final GestureTapCallback ontapMyUbicacion;
  final bool cargando;

  const DesingMapa({
    super.key,
    required this.ubicacion,

    required this.mapController,
    required this.tapComplete,
    required this.ontapMyUbicacion,
     this.onPressedSave,
    this.cargando = false,
  });

  @override
  State<DesingMapa> createState() => _DesingMapaState();
}

class _DesingMapaState extends State<DesingMapa> {
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

                widget.tapComplete(point);
                //   widget.mapController.move(point, 18);
              },
              initialCenter: widget.ubicacion,
              minZoom: 5.0,
              maxZoom: 25.0,
              initialZoom: 18,
            ),
            children: [getMapa(), getMarker()],
          ),

          getBtnAtras(),
          getBotonera(),


          CargandoWidget(mostrar: widget.cargando),
        ],
      ),
    );
  }

  TileLayer getMapa() {
    return new TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
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
          child: GestureDetector(
            onPanUpdate: (details) {
              // POSICIÓN DEL DEDO -> OFFSET LOCAL DEL MAPA
              final box =
                  _mapKey.currentContext!.findRenderObject() as RenderBox;
              final local = box.globalToLocal(details.globalPosition);

              // OFFSET -> LatLng (API nueva)
              final latLng = widget.mapController.camera.offsetToCrs(local);

              widget.tapComplete(latLng); // actualiza tu estado arriba
            },
            child: getBtnCustomIcon(
              icon: Icons.person_pin_circle_rounded,
              ontap: () {},
            ),
          ),
        ),
      ],
    );
  }

  getMarker2() {
    return MarkerLayer(
      markers: [
        Marker(
          height: 90,
          width: 90,
          rotate: true,
          point: widget.ubicacion,
          child: getBtnCustomIcon(
            icon: Icons.person_pin_circle_rounded,
            ontap: () {},
          ),
        ),
      ],
    );
  }

  Widget getBotonera2() {
    final responsive = ResponsiveUtil();
    return Positioned(
      bottom: responsive.altoP(1),
      right: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
            getBtnMyUbicacion(),
            SizedBox(height: responsive.altoP(2)),
            getBtnZoom(),

          ],),
          getTextLatLongitud(),
          btnGuardar(),

          SizedBox(height: responsive.altoP(2)),


        ],
      ),
    );
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
          child: getBtnCustomIcon(
            icon: Icons.zoom_in,
            ontap: () {
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
          child: getBtnCustomIcon(
            icon: Icons.zoom_out,
            ontap: () {
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
    return getBtnCustomIcon(
      icon: Icons.my_location,
      ontap: widget.ontapMyUbicacion,
    );
  }

  Widget getBtnAtras() {
    final responsive = ResponsiveUtil();
    return Positioned(
      top: responsive.altoP(5),
      left: 0,
      child: getBtnCustomIcon(
        icon: Icons.arrow_back,
        ontap: () {
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

  Widget getBtnCustomIcon({
    GestureTapCallback? ontap,
    double size = 45,
    Color colorIcon = Colors.white,
    required IconData icon,
  }) {
    return CupertinoButton(
      borderRadius: BorderRadius.circular(20),
      padding: EdgeInsets.all(1),
      onPressed: ontap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.colorBotones, width: 0.5),
            color: Colors.white10,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Container(
            child:
                size > 38
                    ? Icon(icon, color: colorIcon, size: size - 20)
                    : Container(),
            margin: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: AppColors.colorBotones,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
      ),
    );
  }
}

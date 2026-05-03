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
    this.onPressedSave,
    this.cargando = false,
    required this.listRecintosElectorales,
  });

  @override
  State<DesingMapaRecinto> createState() => _DesingMapaRecintoState();
}

class _DesingMapaRecintoState extends State<DesingMapaRecinto> {
  final _mapKey = GlobalKey(); // 👈 clave para el FlutterMap
  int? selectedIndex;
  RecintosElectoral? recintoSeleccionado;
  final ScrollController _listController = ScrollController();
  ScrollController? _internalScrollController;


  final DraggableScrollableController _sheetController =
  DraggableScrollableController();

  final iconRecinto = Icons.location_city;
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
            children: [Openstreetmap.getMapa(), getMarkes()],
          ),

          getReciontoDraggableScrollableSheet(),
          getBtnAtras(),
          getBotonera(),

          CargandoWidget(mostrar: widget.cargando),
        ],
      ),
    );
  }

  Widget getReciontoDraggableScrollableSheet() {


    double minChildSize=0.25;
    return
    // BOTTOM SHEET DESLIZABLE
    DraggableScrollableSheet(
      controller: _sheetController,
      initialChildSize: 0.50,
      minChildSize: minChildSize,
      maxChildSize: 0.50,
      builder: (context, scrollController) {

        List<RecintosElectoral> listaOrdenada = List.from(widget.listRecintosElectorales);

        if (selectedIndex != null) {
          final seleccionado = listaOrdenada.removeAt(selectedIndex!);
          listaOrdenada.insert(0, seleccionado);
        }

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // 🔹 Indicador (opcional pero bonito)
              SizedBox(height: 10),
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),


            Expanded(
              child: Builder(
                builder: (context) {
                  List<RecintosElectoral> listaOrdenada =
                  List.from(widget.listRecintosElectorales);

                  if (selectedIndex != null &&
                      selectedIndex! < listaOrdenada.length) {
                    final seleccionado = listaOrdenada.removeAt(selectedIndex!);
                    listaOrdenada.insert(0, seleccionado);
                  }

                  _internalScrollController = scrollController; // 👈 GUARDAS EL REAL



                  return ListView.builder(
                    controller: scrollController, // 👈 IMPORTANTE (NO cambiar)
                    itemCount: listaOrdenada.length,
                    itemBuilder: (context, index) {
                      RecintosElectoral recinto = listaOrdenada[index];

                      bool esSeleccionado =
                      (selectedIndex != null && index == 0);

                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: esSeleccionado
                              ? AppColors.colorAzul
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: esSeleccionado
                                ? Colors.black
                                : Colors.grey.shade300,
                            width: esSeleccionado ? 1.5 : 0.5,
                          ),
                        ),
                        child: ListTile(
                          leading: Icon(
                            esSeleccionado
                                ? Icons.check_circle
                                : Icons.location_city,
                            color: esSeleccionado
                                ? Colors.white
                                : AppColors.colorAzul,
                          ),
                          title: Text(
                            recinto.nomRecintoElecOnly,
                            style: TextStyle(
                              color: esSeleccionado
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            "Distancia: ${recinto.distance}m",
                            style: TextStyle(
                              color: esSeleccionado
                                  ? Colors.white70
                                  : Colors.black54,
                            ),
                          ),
                          onTap: () {
                            final originalIndex =
                            widget.listRecintosElectorales.indexOf(recinto);

                            final point = LatLng(
                              recinto.latitud,
                              recinto.longitud,
                            );

                            setState(() {
                              selectedIndex = originalIndex;
                              recintoSeleccionado = recinto;
                            });

                            ajustarMapaParaVerAmbos(point);

                            // 🔥 SCROLL AL INICIO (CORRECTO)
                            Future.delayed(Duration(milliseconds: 100), () {
                              if (_internalScrollController != null &&
                                  _internalScrollController!.hasClients) {
                                _internalScrollController!.animateTo(
                                  0,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                            });

                            // 🔥 MINIMIZAR SHEET
                            _sheetController.animateTo(
                              minChildSize,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),

              // 🔥 BOTÓN FIJO ABAJO
              Padding(
                padding: const EdgeInsets.all(10),
                child: Opacity(
                  opacity: selectedIndex != null ? 1 : 0.5,
                  child: IgnorePointer(
                    ignoring: selectedIndex == null,
                    child: BtnIconWidget(
                      icon: Icons.save,
                      titulo: "GUARDAR",
                      onPressed: (){

                        String msj =
                            "¿Está seguro/a de registrar la ubicacion actual para el recinto ${recintoSeleccionado!.nomRecintoElecOnly}?"
                            "\n\nVerifique que se encuentre exactamente en el lugar del recinto electoral, ya que estas coordenadas serán utilizadas para las registro de las elecciones."
                            "\nEn caso de presentar inconvenientes, comuníquese con el administrador.";
                        DialogosAwesome.getWarningSiNo(
                          title: "Guardar Recinto Electoral \n ${recintoSeleccionado!.nomRecintoElecOnly}",
                          descripcion: msj,
                          btnOkOnPress:           widget.onPressedSave,
                        );
                      }




                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void ajustarMapaParaVerAmbos(LatLng destino) {
    final bounds = LatLngBounds.fromPoints([
      widget.ubicacion, // 📍 usuario
      destino, // 📍 recinto
    ]);

    widget.mapController.fitCamera(
      CameraFit.bounds(
        bounds: bounds,
        padding: EdgeInsets.all(50), // espacio en bordes
      ),
    );
  }

  MarkerLayer getMarkes() {
    List<Marker> markers = [];

    // 📍 Usuario
    markers.add(
      Marker(
        height: 90,
        width: 90,
        point: widget.ubicacion,
        child: Icon(Icons.location_on, color: Colors.red, size: 40),
      ),
    );

    // 📍 Recinto seleccionado
    if (recintoSeleccionado != null) {
      final point = LatLng(
        recintoSeleccionado!.latitud,
        recintoSeleccionado!.longitud,
      );
      markers.add(
        Marker(
          height: 90,
          width: 90,
          point: point,
          child: getBtnCustomIcon(icon: iconRecinto, ontap: () {}),
        ),
      );
    }

    return MarkerLayer(markers: markers);
  }

  MarkerLayer getMarkerRecinto(LatLng point) {
    return MarkerLayer(
      markers: [
        Marker(
          height: 90,
          width: 90,
          rotate: true,
          point: point,
          child: getBtnCustomIcon(icon: Icons.location_city, ontap: () {}),
        ),
      ],
    );
  }

  Widget getBotonera() {
    final responsive = ResponsiveUtil();
    return Stack(
      children: [
        /// Botones a la derecha (ubicación + zoom)
        Positioned(
          top: responsive.altoP(5),
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


      ],
    );
  }

  Widget btnGuardar() {
    return BtnIconWidget(
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
            child: size > 38
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

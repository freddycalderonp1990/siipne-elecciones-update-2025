import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/extension_api.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';

import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'package:siipnemovil2/app/core/utils/utilidadesUtil.dart';

import '../../../../../../app/core/utils/responsiveUtil.dart';
import '../../../../../../app/core/values/app_colors.dart';
import '../../../../../../app/presentation/widgets/custom_app_widgets.dart';
import '../../../../../app/core/utils/photo_helper.dart';
import '../../../../../app/core/values/app_images.dart';
import '../../../../../feactures/mapas/openstreetmap.dart';
import '../../../../../feactures/mapas/widgets/custom_btn_map.dart';
import '../../../../../feactures/mapas/widgets/custom_marker.dart';
import '../../../../../feactures/user/presentation/modules/controllers.dart';
import '../../../../data/models/models.dart';
import '../../../widgets/customWidgets.dart';

class DesingMapaRecinto extends StatefulWidget {
  final LatLng ubicacion;
  final MapController mapController;
  final ValueChanged<LatLng> tapComplete;
  final VoidCallback? onPressedSave;
  final ValueChanged<RecintosElectoral>? onRecintoSeleccionado;

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
    this.onRecintoSeleccionado,
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

  final PopupController _popupController = PopupController();

  final DraggableScrollableController _sheetController =
      DraggableScrollableController();

  final iconRecinto = Icons.location_city;

  bool tieneRecintoValidado = false;

  Rx<GaleryCameraModel?> mGaleryCameraModel = Rx<GaleryCameraModel?>(null);

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
            children: [Openstreetmap.getMapa(), ...getMarkes()],
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
    double minChildSize = 0.25;
    return
    // BOTTOM SHEET DESLIZABLE
    DraggableScrollableSheet(
      controller: _sheetController,
      initialChildSize: 0.50,
      minChildSize: minChildSize,
      maxChildSize: 0.50,
      builder: (context, scrollController) {
        List<RecintosElectoral> listaOrdenada = List.from(
          widget.listRecintosElectorales,
        );

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
                    List<RecintosElectoral> listaOrdenada = List.from(
                      widget.listRecintosElectorales,
                    );

                    if (selectedIndex != null &&
                        selectedIndex! < listaOrdenada.length) {
                      final seleccionado = listaOrdenada.removeAt(
                        selectedIndex!,
                      );
                      listaOrdenada.insert(0, seleccionado);
                    }

                    _internalScrollController =
                        scrollController; // 👈 GUARDAS EL REAL

                    return ListView.builder(
                      controller:
                          scrollController, // 👈 IMPORTANTE (NO cambiar)
                      itemCount: listaOrdenada.length+1,
                      itemBuilder: (context, index) {


                        // Último item: No encuentro mi recinto
                        if (index == listaOrdenada.length) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                            child: OutlinedButton.icon(
                              icon: Icon(
                                Icons.add_location_alt,
                                color: AppColors.colorAzul,
                              ),
                              label: Text(
                                "No encuentro mi recinto",
                                style: TextStyle(
                                  color: AppColors.colorAzul,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                side: BorderSide(color: AppColors.colorAzul),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  selectedIndex = null;
                                  recintoSeleccionado = null;
                                });

                                
                                DialogosDesingWidget.getDialogoX(
                                  contenido: Column(children: [
                                    wgFoto(),
                                  ],)
                                );

                              },
                            ),
                          );
                        }




                        RecintosElectoral recinto = listaOrdenada[index];

                        bool esSeleccionado =
                            (selectedIndex != null && index == 0);
                        bool esValidado = recinto.validado;

                        //verificamos si este usaurio ya valido un recinto

                        if (esValidado) {
                          final loginController = Get.find<LoginController>();

                          String nameUser = loginController.user.value.nombres
                              .replaceAll(RegExp(r'\s+'), '')
                              .toUpperCase();
                          String nameValida = recinto.apenomValida
                              .replaceAll(RegExp(r'\s+'), '')
                              .toUpperCase();

                          if (nameUser == nameValida) {
                            tieneRecintoValidado = true;
                          }
                        }

                        Color? fondo;

                        if (esSeleccionado) {
                          fondo = AppColors.colorAzul; // 🔵 seleccionado manda


                        } else if (esValidado) {
                          fondo = Colors.green; // 🟢 validado
                        } else {
                          fondo = Colors.transparent;
                        }
                        ;

                        return Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: fondo,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: esSeleccionado
                                  ? Colors.black
                                  : esValidado
                                  ? Colors.green.shade700
                                  : Colors.grey.shade300,
                              width: esSeleccionado ? 1.5 : 0.5,
                            ),
                          ),
                          child: ListTile(
                            trailing: esValidado
                                ? Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      "VALIDADO",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : null,
                            leading: Icon(
                              esSeleccionado
                                  ? Icons.check_circle
                                  : esValidado
                                  ? Icons.verified
                                  : Icons.location_city,
                              color: (esSeleccionado || esValidado)
                                  ? Colors.white
                                  : AppColors.colorAzul,
                            ),

                            title: Text(
                              recinto.nomRecintoElecOnly,
                              style: TextStyle(
                                color: (esSeleccionado || esValidado)
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            subtitle: Text(
                              esValidado
                                  ? "Valida: ${recinto.apenomValida}."
                                        "\nDistancia: ${recinto.distance}m"
                                  : "Distancia: ${recinto.distance}m",
                              style: TextStyle(
                                color: (esSeleccionado || esValidado)
                                    ? Colors.white70
                                    : Colors.black54,
                              ),
                            ),

                            onTap: () {
                              final originalIndex = widget
                                  .listRecintosElectorales
                                  .indexOf(recinto);

                              final point = LatLng(
                                recinto.latitud,
                                recinto.longitud,
                              );

                              setState(() {
                                selectedIndex = originalIndex;
                                recintoSeleccionado = recinto;
                              });

                              ajustarMapaParaVerAmbos(point);

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

                              _sheetController.animateTo(
                                minChildSize,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );

                              // 🔥 DEVOLVER EL RECINTO
                              if (widget.onRecintoSeleccionado != null) {
                                widget.onRecintoSeleccionado!(recinto);
                              }
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
                      onPressed: () {

                        if (tieneRecintoValidado) {
                          DialogosAwesome.getWarning(
                            descripcion:
                                "Usted ya ha validado un recinto. Si desea realizar el proceso nuevamente, por favor comuníquese con Talento Humano para habilitar su validación.",
                          );
                          return;
                        }

                        String msj =
                            "Asegúrese de encontrarse exactamente en el lugar del recinto electoral."
                            "\n\n[azul]Este registro será utilizado en el proceso electoral y será[/azul] [rojo]AUDITADO[/rojo][azul], siendo usted responsable de la información ingresada.[/azul]"
                            "\n\nUn registro incorrecto podría generar inconvenientes el día de las elecciones."
                            "\n\n¿Está seguro/a de registrar la ubicación actual?";

                        if (recintoSeleccionado!.validado) {
                          msj =
                              "El recinto ya fue validado por ${recintoSeleccionado!.apenomValida}."
                              "\n\nAsegúrese de encontrarse en el lugar correcto."
                              "\nEste cambio quedará AUDITADO y será su responsabilidad."
                              "\nUna validación incorrecta podría generar inconvenientes el día de las elecciones."
                              "\n\n¿Desea reemplazar la ubicación actual y validarlo nuevamente?";
                        }

                        DialogosAwesome.getWarningSiNoContador(
                          title:
                              "Validar Recinto Electoral \n ${recintoSeleccionado!.nomRecintoElecOnly}",
                          descripcion: msj,
                          btnOkOnPress: widget.onPressedSave,
                        );

                      },
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

  Widget wgFoto() {
    final responsive = ResponsiveUtil();

    return Obx(() {
      return Column(
        children: [
          mGaleryCameraModel.value == null
              ? TituloTextWidget(title: "Registrar una Imagen")
              : TituloTextWidget(title: "Cambiar la Imagen"),

          SizedBox(height: responsive.altoP(1)),

          InkWell(
            onTap: () async {
              final ahora = DateTime.now();

              String dosDigitos(int n) =>
                  n.toString().padLeft(2, '0');

              String nameRecintoImg =
                  "ImgRecinto_${ahora.year}"
                  "${dosDigitos(ahora.month)}"
                  "${dosDigitos(ahora.day)}_"
                  "${dosDigitos(ahora.hour)}"
                  "${dosDigitos(ahora.minute)}"
                  "${dosDigitos(ahora.second)}.jpg";

              mGaleryCameraModel.value =
              await PhotoHelper.getDesingPictureGaleryOrCamera(
                titleImg: nameRecintoImg,
                initPeticion: (value) {},
              );
            },

            child: Image.asset(
              AppImages.icon_camara,
              width: responsive.altoP(6),
            ),
          ),

          if (mGaleryCameraModel.value != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.file(
                mGaleryCameraModel.value!.imageFile,
                fit: BoxFit.fill,
                height: responsive.altoP(30),
                width: responsive.altoP(34),
              ),
            ),
        ],
      );
    });
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

  List<Widget> getMarkes() {
    List<Marker> markersRecinto = [];

    // 📍 Recinto seleccionado (CON popup)
    if (recintoSeleccionado != null) {
      final recinto = recintoSeleccionado!;
      final point = LatLng(recinto.latitud, recinto.longitud);

      late Marker marker;

      marker = Marker(
        key: ValueKey(recinto),
        point: point,
        width: 80,
        height: 80,
        child: GestureDetector(
          onTap: () {
            _popupController.showPopupsOnlyFor([marker]); // 👈 SOLO UNO ACTIVO
          },
          child: getBtnCustomIcon(icon: iconRecinto),
        ),
      );

      markersRecinto.add(marker);
    }

    return [
      // 🔴 1. TU UBICACIÓN (SIEMPRE VISIBLE, SIN POPUP)
      MarkerLayer(
        markers: [
          Marker(
            point: widget.ubicacion,
            width: 80,
            height: 80,
            child: Icon(Icons.person_pin_circle, color: Colors.red, size: 45),
          ),
        ],
      ),

      // 🟢 2. RECINTO (CON POPUP)
      PopupMarkerLayer(
        options: PopupMarkerLayerOptions(
          popupController: _popupController,
          markers: markersRecinto,

          popupDisplayOptions: PopupDisplayOptions(
            builder: (context, marker) {
              final recinto =
                  (marker.key as ValueKey).value as RecintosElectoral;

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        recinto.nomRecintoElecOnly,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text("Distancia: ${recinto.distance} m"),
                      if (recinto.validado)
                        Text(
                          "VALIDADO",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    ];
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

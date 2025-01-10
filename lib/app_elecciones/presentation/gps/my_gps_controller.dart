part of '../modules/controllers.dart';

class MyGpsController extends GetxController {
  // Getters for reactive properties
  RxBool get permisos => _permisosUser;
  RxBool get gpsActivo => _gpsActivo;
  RxBool get ubicacionLista => _ubicacionLista;
  RxBool get obteniendoUbicacion => _obteniendoUbicacion;
  Rx<LatLng> get ubicacion => _ubicacion;

  // Reactive properties
  final RxBool _permisosUser = false.obs;
  final RxBool _gpsActivo = false.obs;
  final Rx<LatLng> _ubicacion = LatLng(0.0, 0.0).obs;
  final RxBool _obteniendoUbicacion = false.obs;
  final RxBool _ubicacionLista = false.obs;

  StreamSubscription<myGeolocator.Position>? positionSubscription;

  @override
  void onInit() {
    super.onInit();
    _checkGps();
  }

  @override
  void onClose() {
    cancelarSeguimiento();
    super.onClose();
  }

  Future<bool> validarPermiso({
    bool mostrarDialogo = true,
    bool permisoManual = false,
    required ValueChanged<LatLng> changeLocation,
  }) async {
    bool permisoGPS = await Permission.location.isGranted;

    final bool gpsEnabled = await myGeolocator.Geolocator.isLocationServiceEnabled();
    _gpsActivo.value = gpsEnabled;
    _permisosUser.value = permisoGPS;

    if (!permisoGPS) {
      _ubicacionLista.value = false;

      if (mostrarDialogo) {
        DialogosDesingWidget.getDialogo(
          contenido: DesingPermisosGps(onPressed: () async {
            Get.back();
            permisoGPS =
            await _checkGpsPermisoStatus(permisoManual: permisoManual);
            print("validarPermiso checkGpsPermisoStatus2=${permisoGPS}");
            if (permisoGPS) {
              iniciarSeguimiento(changeLocation: changeLocation);
            }
          }),
        );
      }
      return false;
    }

    if (!gpsEnabled) {
      _ubicacionLista.value = false;
      DialogosAwesome.getWarning(
        title: "GPS - DESACTIVADO",
        descripcion: "Para continuar, por favor active el GPS de su dispositivo.",
        titleBtnOk: 'Continuar',
      );
      return false;
    }

    if (permisoGPS && gpsEnabled) {
      iniciarSeguimiento(changeLocation: changeLocation);
      return true;
    }
    return false;
  }


  Future<bool> _checkGpsPermisoStatus({ bool permisoManual=false}) async {
    //Muestra el dialogo personalizado del permiso del celular
    final status = await Permission.location.request();
    print("_checkGpsPermisoStatus ${status}");

    bool result=false;
    switch (status) {
      case PermissionStatus.granted:

        result= true;

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

        if(permisoManual) {
          result = await openAppSettings();
        }
        return false;
      case PermissionStatus.provisional:
      // TODO: Handle this case.
    }

    return result;
  }



  Future<void> iniciarSeguimiento({required ValueChanged<LatLng> changeLocation}) async {
    if (!_gpsActivo.value || !_permisosUser.value) {
      cancelarSeguimiento();
      return;
    }

    if (positionSubscription == null) {
      _obteniendoUbicacion.value = true;
      final positionStream = myGeolocator.Geolocator.getPositionStream(locationSettings: MyGps.getConfig);

      positionSubscription = positionStream.handleError((error) {
        _ubicacion.value = LatLng(0, 0);
        _ubicacionLista.value = false;
        _obteniendoUbicacion.value = false;
        changeLocation(_ubicacion.value);
        cancelarSeguimiento();
        print("Error en la obtención de ubicación: $error");
      }).listen((position) {
        _ubicacion.value = LatLng(position.latitude, position.longitude);
        _ubicacionLista.value = true;
        _obteniendoUbicacion.value = false;
        changeLocation(_ubicacion.value);

      });
    }
  }

  void cancelarSeguimiento() {

    positionSubscription?.cancel();
    positionSubscription = null;
    _obteniendoUbicacion.value = false;
  }

  void _checkGps() async {
    myGeolocator.Geolocator.getServiceStatusStream().listen((myGeolocator.ServiceStatus status) {
      _gpsActivo.value = (status == myGeolocator.ServiceStatus.enabled);
      if (_gpsActivo.value) {
        print("GPS Activado");
        iniciarSeguimiento(changeLocation: (value) {
          print("Ubicación actualizada: $value");
        });
      } else {
        print("GPS Desactivado");
        cancelarSeguimiento();
      }
    });
  }
}

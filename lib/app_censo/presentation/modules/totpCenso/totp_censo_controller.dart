import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart' as myGeolocator;
import '../../../../app/core/app_config.dart';

import '../../../../app/presentation/widgets/custom_app_widgets.dart';
import '../../../../app_siipne_key/data/models/user_error_model.dart';
import '../../../../feactures/gps/presentation/location/location_bloc.dart';
import '../../../../feactures/my_qr/core/exceptions/qr_exception.dart';
import '../../../../feactures/my_qr/core/utils/my_qr.dart';
import '../../../../feactures/user/core/utils/encriptar_util.dart';
import '../../../../feactures/user/presentation/modules/controllers.dart';
import '../../../core/app_censo_config.dart';
import '../../../core/utils/algoritmo_TOTP_censo.dart';
import '../../../data/models/local/data_censo_read_qr_model.dart';
import '../../../domain/usecases/local_store_censo.dart';
import '../censo_policial/local_widgets/desing_clave_digital_censo.dart';

class TotpCensoController extends GetxController {
  final LocalStoreCensoUseCase _localStoreImpl =
      Get.find<LocalStoreCensoUseCase>();

  final loginController = Get.find<LoginController>();

  GlobalKey keyWidgetShared = GlobalKey<RefreshIndicatorState>();

  static const maxSeconds = 30;
  Timer? timer;
  RxString _codigo = "000000".obs;
  RxInt seconds = maxSeconds.obs;
  RxDouble _valueRadio = 100.0.obs;

  bool claveAbierta = true;

  bool reciboDataQR = false;

  //para controlar que la aplicacion esta compartiendo el Qr por lo que entra en segundo plano y se deben de cerrar dos pantallas

  bool compartirQR = false;

  //Variables para analisar en caso de error
  Rx<DateTime> currentTimeCode = DateTime.now().obs;
  RxInt unixTime = 0.obs;
  String clavePura = "";
  String code = "000000";
  String codeAnterior = "000000";
  String timeZone = "none";

  Rx<DataUserError> dataUserError = DataUserError.empty().obs;
  // end Variables para analisar en caso de error

  RxString? get codigo => _codigo;
  RxDouble get valueRadio => _valueRadio;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    print("on close totp controller");
    timer?.cancel();
    super.onClose();
  }

  getCodeValidateTimeServer(pass) async {
    //Obtener la hora del server guardada
    String _fechaServer = await _localStoreImpl.getFechaServer();
    bool tenemosFechaServer = false;
    if (_fechaServer.length > 2) {
      tenemosFechaServer = true;
    }

    DateTime? fecha = await validateFechas(_fechaServer);
    String _code = await AlgoritmoTOTPCenso.getCode(
      pass,
      fecha_: fecha,
      fechaServer: tenemosFechaServer,
    );

    if (codeAnterior != _code) {
      codeAnterior = _code;
    }

    return _code;
  }

  //para reemplazar el timer porque en unos telefonos se pierde esta validadcion
  //por loq ue ahora se guarda la fecha que se obtiene del server
  // y la fecha local del celular para saber la hora en que se guarda
  //y luego comprtobar con la hora actual  yver cuanto tiempo se debe sumar
  // a la fecha que se encuntra guardada del server
  //solo se aplica cuando se obtiene la fecha del server
  Future<DateTime> validateFechas(String _fechaServer) async {
    DateTime now = new DateTime.now();
    if (_fechaServer == "") {
      return now;
    }

    DateTime fechaServer = DateTime.parse(_fechaServer);

    String _fechaCellPause = await _localStoreImpl.getFechaCellPauseCenso();
    DateTime fechaCellPause = DateTime.parse(_fechaCellPause);

    // Calcula la diferencia entre las dos fechas
    Duration diferencia = now.difference(fechaCellPause);

    // Suma la diferencia a la otra fecha
    DateTime nuevaFecha = fechaServer.add(diferencia);

    await _localStoreImpl.setFechaCellPauseCenso(now.toString());
    await _localStoreImpl.setFechaServer(nuevaFecha.toString());

    return nuevaFecha;
  }

  int secondToNumber(int second) {
    // Validamos que el segundo esté dentro del rango [15, 44]
    if (second < 15 || second > 44) {
      // Mapeamos el segundo al número deseado
      if (second >= 45) {
        return 75 - second; // 45 -> 30, 46 -> 29, ..., 59 -> 16
      } else {
        return 15 - second; // 0 -> 15, 1 -> 14, ..., 14 -> 1
      }
    }

    // Mapeamos el segundo al número deseado
    return 45 - second;
  }

  startTimer(String pass) async {
    claveAbierta = true;

    stopTimer();

    final isRunning = timer == null ? false : timer!.isActive;
    //String pass = await _LocalStoreImpl.getPass();

    print("pass-> ${pass}");

    if (!isRunning) {
      _codigo.value = await getCodeValidateTimeServer(pass);

      timer = Timer.periodic(Duration(seconds: 1), (_) async {
        DateTime currentTime = DateTime.now();
        int currentSecond = currentTime.second;

        seconds.value = secondToNumber(currentSecond);

        double resultado = seconds.value * 100;
        valueRadio.value = resultado / maxSeconds;
        _codigo.value = await getCodeValidateTimeServer(pass);
        if (seconds.value == maxSeconds) {
          if (claveAbierta == false) {
            stopTimer();
          }
        }
      });
    }
  }

  void stopTimer() {
    valueRadio.value = 0;
    timer?.cancel();
  }

  showClaveDigital(String idGenPersonaUser, String codeUnico) async {
    String codeUnico = await _localStoreImpl.getCodeUnicoCenso(idGenPersonaUser);

    if (codeUnico.length > 0) {
      getDialogoClave(codeUnico);
    } else {
      MyQr.showDialogoQr(
        dataQrChange: (String dataQr) async {
          print("data del qr es en show qr ${dataQr}");

          if (!reciboDataQR) {
            reciboDataQR = true;
            await verificarDataQr(dataQr, idGenPersonaUser: idGenPersonaUser);
          }
        },
      );
    }
  }

  Future<DataCensoReadQrModel> verificarDataQr(
    String dataQr, {
    required String idGenPersonaUser,
  }) async {
    DataCensoReadQrModel data = DataCensoReadQrModel.empty();
    print("verificarDataQr hola");
    print(dataQr);

    try {
      //verificar cual es el origen del Qr
      bool origenMovil = dataQr.contains(AppConfig.key_securiry_qr);
      String datosJsonDesencrypt = '';
      if (origenMovil) {
        //se elimina la identificacion del key movil
        dataQr = dataQr.replaceAll(AppConfig.key_securiry_qr, "");
        datosJsonDesencrypt = EncriptarUtil.decryptMovil(dataQr);
        print("datosJsonDesencrypt movil");
        print(datosJsonDesencrypt);
      } else {
        datosJsonDesencrypt = EncriptarUtil.decryptSiipne(dataQr);
        print("datosJsonDesencrypt web");
        print(datosJsonDesencrypt);
      }

      DataCensoReadQrModel data = dataReadQrModelFromJson(datosJsonDesencrypt);

      int idGenPersona = loginController.user.value.idGenPersona;
      //se verifica que el codigo sea el mismo que generó el usuario
      if (data.idGenPersonaCensado != idGenPersona) {
        throw QRException(
          cause:
              "El código QR no es válido o el usuario es incorrecto. Por favor, intenta con otro código QR.",
        );
      }
      //verificamos si es movil o web
      if (data.generadoDe != "WEB") {
        //Verificamos la fecha de caducidad por implementar
      }

      String passCode =
          "idGenPersonaCensado:${idGenPersonaUser}-idProceso:${data.idProceso}-idDgpRecinto:${data.idDgpRecinto}-idMesa:${data.idMesa}-idGenPersonaCensista:${data.idGenPersonaCensista}";

      DateTime now = DateTime.now();
      DateTime fechaQr = DateTime.parse(data.fecha);
      // Calcula la diferencia entre las dos fechas en segundos
      int diferenciaEnSegundos = now.difference(fechaQr).inDays;
      print("nowQR= ${now}   =    $fechaQr   ($diferenciaEnSegundos)");
      if (diferenciaEnSegundos >= AppConfig.duracionQRDay) {
        throw QRException(
          cause:
              "El código QR no es válido o ha expirado. Por favor, intenta con otro código QR.",
        );
      }

      //VALIDAMOS QUE EL USUARIO ESTE CERCA DE LA MESA

      final locationBloc = BlocProvider.of<LocationBloc>(Get.context!);
      LatLng position = await locationBloc.getCurrentPosition();

      double distancia = myGeolocator.Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        data.latitudMesa,
        data.longitudMesa,
      );

      print(
        '📍 Coordenadas:\n'
        '➡️ Usuario: (${position.latitude}, ${position.longitude})\n'
        '➡️ Mesa del censo: (${data.latitudMesa}, ${data.longitudMesa})',
      );

      print("distancia ${distancia}");
      if (distancia > AppCensoConfi.longitudValidarMesa) {
        throw QRException(
          cause:
              "Usted se encuentra fuera del rango permitido. Por favor, acérquese a la mesa del censo para continuar con el proceso.",
        );
      }

      _localStoreImpl.setCodeUnicoCenso(idGenPersonaUser, passCode);
      Get.back();
      getDialogoClave(passCode);

      return data;
    } on QRException catch (e) {
      getMsjErrorQr(e.cause);
    } catch (e) {
      getMsjErrorQr(
        "El código QR no es válido. Por favor, intenta escanear uno nuevo. ${e}",
      );
    }
    return data;
  }

  getMsjErrorQr(String msj) async {
    Get.back();
    await Future.delayed(Duration(milliseconds: 100), () {});

    DialogosAwesome.getWarning(
      descripcion: msj,
      btnOkOnPress: () {
        reciboDataQR = false;
      },
    );
  }

  getDialogoClave(String pass) async {


    await startTimer(pass);
    DialogosDesingWidget.getDialogoXClaveTemporal(
      contenido: Obx(
        () => DesingClaveDigitalCenso(
          onPressedVincularcell: () {},
          seconds: seconds.value,
          valueRadio: valueRadio.value,
          codigo: _codigo.value,
        ),
      ),
      onPressedX: () {
        claveAbierta = false;
        stopTimer();
        Get.back();
      },
    );
  }
}

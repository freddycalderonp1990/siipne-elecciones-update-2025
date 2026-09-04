
import 'dart:async';

import 'package:get/get.dart';
import 'package:intl/intl.dart';


import '../../app/core/app_config.dart';

import 'domain/use_cases/get_fecha_server_use_case.dart';
import 'domain/use_cases/local_store_clock_server.dart';


class DateTimeController extends GetxController {
  final GetFechaServerUseCase _getFechaServerUseCase = Get.find<GetFechaServerUseCase>();
  final LocalStoreClockServerUseCase _localStoreClockServerUseCase = Get.find<LocalStoreClockServerUseCase>();

  Rx<DateTime?> _currentTime = null.obs;
  Rx<DateTime?> _currentTimeApp = null.obs;
  Timer? timer;
  Rx<DateTime?> get currentDateTime => _currentTime;
  Rx<DateTime?> get currentDateTimeApp => _currentTime;

  bool obtenerHoraServer = false;

  @override
  void onClose() {
    print("on close datetime controller");
    timer?.cancel();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
  }

  String get formattedTime {
    if (_currentTime.value != null) {
      final time = _currentTime.value!;
      // Formatea la fecha completa: "YYYY-MM-DD HH:MM:SS"
      return "${time.year.toString().padLeft(4, '0')}-${time.month.toString().padLeft(2, '0')}-${time.day.toString().padLeft(2, '0')} ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}";
    }
    return "";
  }

  String get formattedTimeApp {
    if (_currentTimeApp.value != null) {
      final time = _currentTimeApp.value!;
      // Formatea la fecha completa: "YYYY-MM-DD HH:MM:SS"
      return "${time.year.toString().padLeft(4, '0')}-${time.month.toString().padLeft(2, '0')}-${time.day.toString().padLeft(2, '0')} ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}";
    }
    return "";
  }

  RxString setFormat(DateTime date) {
    // Actualiza la hora y la fecha cada segundo

    RxString currentDateTime =
        DateFormat('${AppConfig.formatoFecha} ${AppConfig.formatoHora}')
            .format(date)
            .obs;
    return currentDateTime;
  }

  Future<void> getTimeServer() async {
    try {
      _localStoreClockServerUseCase.setFechaServer('');
      _localStoreClockServerUseCase.setFechaCellPause('');
      print("obteniendo la fecha del server");
      DateTime serverTime = await _getFechaServerUseCase.call();
      // Simulación de la obtención de la hora del servidor
     // final serverTime = DateTime.parse("2024-05-29 10:12:56");



      bool resultDiferencia = isDifferenceThirtySeconds(serverTime);

      if (resultDiferencia) {
        _currentTime = serverTime.toLocal().obs;
        obtenerHoraServer = true;
        _currentTimeApp = DateTime.now().obs;

        String fechaNew= formattedTime;
        print(" es diferente asigando nueva fecha ${_currentTimeApp}");
        print(" es diferente asigando nueva fecha ${fechaNew}");


        //se asigan la del servidor xcq se ausme que es la mas precisa
        //Set datos de las fechas del servidor en la bd local
        _localStoreClockServerUseCase.setFechaServer(formattedTime);
        _localStoreClockServerUseCase.setFechaCellPause(formattedTimeApp);

        //_startClock();
      }

      // Convertimos la hora del servidor a la zona horaria local
    } catch (e) {
      print('Error al obtener la hora del servidor: $e');

      /*_currentTime = DateTime.now().obs;
      _currentTimeApp = DateTime.now().obs;*/

      //_startClock();
    }
  }

  //verifica si existe una diferencia del servidor con la hora del celular de 30 segundos
  bool isDifferenceThirtySeconds(DateTime serverTime) {
    final now = DateTime.now();

    print("now=${now}  -- serverTime=${serverTime}");

    final difference = now.difference(serverTime).inSeconds;

    print("diferencia de horas es de ${difference.abs()}");
    return difference.abs() >= 30;
  }


}

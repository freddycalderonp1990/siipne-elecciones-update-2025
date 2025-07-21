import 'dart:developer';

import 'package:api_provider/core/utils/prints_msj.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../../feactures/user/core/utils/encriptar_util.dart';
import '../../presentation/modules/totpCenso/totp_censo_controller.dart';


class AlgoritmoTOTPCenso {
  static String tag = "AlgoritmoTOTPCenso";
  // ******************* CONFIGURACIONES *******************************
  static String _key_security= dotenv.env['SECRET_KEY_TOTP'] ?? '';
  static String _formatTime = "yyyy-MM-dd HH:mm:ss";
  static int _change_key_every = 30; //seconds cada cuanto cambia la clave
  int _hash_len = 128; //longitud del hast 128 caracteres
  static int _pin_len = 6; //longitud del pin
  static int _default_rounds =
      4; //rondas por defecto, cuantas veces vamos a utilizar el hmac_

// ******************* END  CONFIGURACIONES *******************************

  static TotpCensoController totpController = Get.find();


  static String getCode(
    String password, {
    DateTime? fecha_,
    bool fechaServer = false,
  }) {
    String keyGenerateCode = password;

    totpController.clavePura = password;

    if (password != null) {
      keyGenerateCode = keyGenerateCode + password;
    }

    String clave = EncriptarUtil.generateSha512(keyGenerateCode);

    DateTime fecha = getFechaFormat(fecha: fecha_);

    fecha = setUtc05EcuadorGuayaquil(fecha, fechaServer: fechaServer);

    totpController.currentTimeCode.value = fecha;

    String _tag = tag + "-getCode";
    PrintsMsj.myLog(tag: _tag, title: "name", detalle: keyGenerateCode);
    PrintsMsj.myLog(tag: _tag, title: "clave", detalle: clave);
    PrintsMsj.myLog(tag: _tag, title: "la fecha es", detalle: fecha.toString());

    //Obtiene el time unix en segundos
    int unixtime = getUnixTime(fecha);
    totpController.unixTime.value = unixtime;

    int unixtimeFloor = setUnixtimeDuration(unixtime);
    PrintsMsj.myLog(
        tag: _tag, title: "unixtimeFloor", detalle: unixtimeFloor.toString());

    String passwordHash = getHashKey(clave, unixtimeFloor);
    PrintsMsj.myLog(
        tag: _tag, title: "passwordHash", detalle: passwordHash.toString());

    String codigo = getCodeKey(passwordHash);
    PrintsMsj.myLog(tag: _tag, title: "code", detalle: codigo.toString());

    String ms =
        "| Clave= ${clave} | sha512 = ${passwordHash} | code= ${codigo}";
    PrintsMsj.myLog(tag: _tag, title: "all", detalle: ms.toString());

    return codigo;
  }

  //se encarga de crear el hash , a partir del pass - clave , y el tiempo unixtime
  static String getHashKey(String pass, int unixtimeFloor) {
    String password = pass + unixtimeFloor.toString() + _key_security;

    //Se define cuantas veces se encripta el codigo
    //para darle mayor seguridad

    for (int i = 0; i < _default_rounds; i++) {
      password = EncriptarUtil.generateSha512(password);
    }

    return password;
  }

  //Convierte en arreglo el hash
  static List<String> _getArrayHash(String has) {
    List<String> res = [];
    for (int i = 0; i < has.length; i++) {
      res.add(has[i]);
    }
    return res;
  }

  static bool esNumero(var valor) {
    // Intenta analizar el valor como un número
    return num.tryParse(valor.toString()) != null;
  }

  //Obtiene el codigo
  static String getCodeKey(String hash) {
    List<String> res = _getArrayHash(hash);

    double numero = 0;

    DateTime now = new DateTime.now();
    var formatter = new DateFormat("yyyy");
    String formattedDate = formatter.format(now);

    int anio = int.parse(formattedDate);
    // print("anio ${anio}");
    anio = anio + 457;
    // print("anio ${anio}");

    double mult_divisor = anio / _pin_len;

    for (int i = 0; i < res.length; i++) {
      if (esNumero(res[i])) {
        numero = numero + int.parse(res[i]);
      } else {
        numero = numero + res[i].codeUnitAt(0);
        numero = numero * i;
      }

      numero = numero + numero;

      numero = 1 + numero / mult_divisor;
    }

    String codeReduce = numero.toString();

    //print("codeReduce ${codeReduce}");
    //Limitamos para que que la cadena solo tenga 10 numeros el codigo
    codeReduce = codeReduce.substring(0, 11);

    // print("codeReduce ${codeReduce}");

    //Ahora se revierte el codigo

    String reverseCode = _getReverseCode(codeReduce);

    //Le indicamos la longitud de digitos del codigo
    reverseCode = reverseCode.substring(0, _pin_len);

    return reverseCode;
  }

// Se encarga de revertir el codigo
//Ejemplo 12345  = 54312
//Pora obtener codigos mas variables ya que un valor que se encuantra a la derecha es mas probable que cambie
//obteneiendo de esta manera codigos variables para el usuario
  static String _getReverseCode(String code) {
    List<int> codigoResult = [];
    String result = "";
//Se reemplaza los . (Puntos) y , (Comas)
    code = code.replaceAll(",", "").replaceAll(".", "");

    for (int i = code.length - 1; i >= 0; i--) {
      int r = int.parse(code[i]);
      result = result + code[i];
      codigoResult.add(r);
    }

    return result;
  }

  static String getFechaActual() {
    DateTime now = new DateTime.now();
    var formatter = new DateFormat(_formatTime);
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  static DateTime getFechaFormat({DateTime? fecha}) {
    DateTime now = new DateTime.now();
    if (fecha != null) {
      now = fecha;
    } else {
      print("tengo fecha null");
    }

    var formatter = new DateFormat(_formatTime);
    String formattedDate = formatter.format(now);
    now = DateTime.parse(formattedDate);
    return now;
  }

  String setNewSecon(String fecha) {
    DateTime dt = DateTime.parse(fecha);
    //Verificamos los segundos
    var formatter = new DateFormat('ss');
    int segundos = int.parse(formatter.format(dt));
    if (segundos >= 0 && segundos <= 29) {
      segundos = 0;
    } else if (segundos >= 30 && segundos <= 59) {
      segundos = 30;
    }
    //extraemos la fecha sin los segundos
    formatter = new DateFormat('yyyy-MM-dd HH:mm:');
    String fecha2 = formatter.format(dt);
    String fechaNew = "";
    if (segundos == 0) {
      fechaNew = fecha2 + segundos.toString() + "0";
    } else {
      fechaNew = fecha2 + segundos.toString();
    }
    //se agrena los nuevos segundos a la fehca

    //se crea el formato de fecha con los nuevos segundos
    formatter = new DateFormat(_formatTime);
    dt = DateTime.parse(fechaNew);
    fechaNew = formatter.format(dt);

    return fechaNew;
  }

  static dataReference() {
    // Definimos los offsets de todas las zonas horarias
    List<Map<String, dynamic>> timeZones = [
      {
        "zone": "UTC-12:00",
        "offset": -12.0,
        "hora": -7,
        "minutos": 0
      }, // UTC-05:00 es 7 horas adelante
      {
        "zone": "UTC-11:00",
        "offset": -11.0,
        "hora": -6,
        "minutos": 0
      }, // UTC-05:00 es 6 horas adelante
      {
        "zone": "UTC-10:00",
        "offset": -10.0,
        "hora": -5,
        "minutos": 0
      }, // UTC-05:00 es 5 horas adelante
      {
        "zone": "UTC-09:30",
        "offset": -9.5,
        "hora": -4,
        "minutos": 30
      }, // UTC-05:00 es 4 horas y 30 minutos adelante
      {
        "zone": "UTC-09:00",
        "offset": -9.0,
        "hora": -4,
        "minutos": 0
      }, // UTC-05:00 es 4 horas adelante
      {
        "zone": "UTC-08:00",
        "offset": -8.0,
        "hora": -3,
        "minutos": 0
      }, // UTC-05:00 es 3 horas adelante
      {
        "zone": "UTC-07:00",
        "offset": -7.0,
        "hora": -2,
        "minutos": 0
      }, // UTC-05:00 es 2 horas adelante
      {
        "zone": "UTC-06:00",
        "offset": -6.0,
        "hora": -1,
        "minutos": 0
      }, // UTC-05:00 es 1 hora adelante
      {
        "zone": "UTC-05:00",
        "offset": -5.0,
        "hora": 0,
        "minutos": 0
      }, // Guayaquil
      {
        "zone": "UTC-04:00",
        "offset": -4.0,
        "hora": 1,
        "minutos": 0
      }, // UTC-05:00 es 1 hora atrás
      {
        "zone": "UTC-03:30",
        "offset": -3.5,
        "hora": 1,
        "minutos": 30
      }, // UTC-05:00 es 1 hora y 30 minutos atrás
      {
        "zone": "UTC-03:00",
        "offset": -3.0,
        "hora": 2,
        "minutos": 0
      }, // UTC-05:00 es 2 horas atrás
      {
        "zone": "UTC-02:00",
        "offset": -2.0,
        "hora": 3,
        "minutos": 0
      }, // UTC-05:00 es 3 horas atrás
      {
        "zone": "UTC-01:00",
        "offset": -1.0,
        "hora": 4,
        "minutos": 0
      }, // UTC-05:00 es 4 horas atrás
      {
        "zone": "UTC±00:00",
        "offset": 0.0,
        "hora": 5,
        "minutos": 0
      }, // UTC-05:00 es 5 horas atrás
      {
        "zone": "UTC+01:00",
        "offset": 1.0,
        "hora": 6,
        "minutos": 0
      }, // UTC-05:00 es 6 horas atrás
      {
        "zone": "UTC+02:00",
        "offset": 2.0,
        "hora": 7,
        "minutos": 0
      }, // UTC-05:00 es 7 horas atrás
      {
        "zone": "UTC+03:00",
        "offset": 3.0,
        "hora": 8,
        "minutos": 0
      }, // UTC-05:00 es 8 horas atrás
      {
        "zone": "UTC+03:30",
        "offset": 3.5,
        "hora": 8,
        "minutos": 30
      }, // UTC-05:00 es 8 horas y 30 minutos atrás
      {
        "zone": "UTC+04:00",
        "offset": 4.0,
        "hora": 9,
        "minutos": 0
      }, // UTC-05:00 es 9 horas atrás
      {
        "zone": "UTC+04:30",
        "offset": 4.5,
        "hora": 9,
        "minutos": 30
      }, // UTC-05:00 es 9 horas y 30 minutos atrás
      {
        "zone": "UTC+05:00",
        "offset": 5.0,
        "hora": 10,
        "minutos": 0
      }, // UTC-05:00 es 10 horas atrás
      {
        "zone": "UTC+05:30",
        "offset": 5.5,
        "hora": 10,
        "minutos": 30
      }, // UTC-05:00 es 10 horas y 30 minutos atrás
      {
        "zone": "UTC+05:45",
        "offset": 5.75,
        "hora": 10,
        "minutos": 45
      }, // UTC-05:00 es 10 horas y 45 minutos atrás
      {
        "zone": "UTC+06:00",
        "offset": 6.0,
        "hora": 11,
        "minutos": 0
      }, // UTC-05:00 es 11 horas atrás
      {
        "zone": "UTC+06:30",
        "offset": 6.5,
        "hora": 11,
        "minutos": 30
      }, // UTC-05:00 es 11 horas y 30 minutos atrás
      {
        "zone": "UTC+07:00",
        "offset": 7.0,
        "hora": 12,
        "minutos": 0
      }, // UTC-05:00 es 12 horas atrás
      {
        "zone": "UTC+08:00",
        "offset": 8.0,
        "hora": 13,
        "minutos": 0
      }, // UTC-05:00 es 13 horas atrás
      {
        "zone": "UTC+08:45",
        "offset": 8.75,
        "hora": 13,
        "minutos": 45
      }, // UTC-05:00 es 13 horas y 45 minutos atrás
      {
        "zone": "UTC+09:00",
        "offset": 9.0,
        "hora": 14,
        "minutos": 0
      }, // UTC-05:00 es 14 horas atrás
      {
        "zone": "UTC+09:30",
        "offset": 9.5,
        "hora": 14,
        "minutos": 30
      }, // UTC-05:00 es 14 horas y 30 minutos atrás
      {
        "zone": "UTC+10:00",
        "offset": 10.0,
        "hora": 15,
        "minutos": 0
      }, // UTC-05:00 es 15 horas atrás
      {
        "zone": "UTC+10:30",
        "offset": 10.5,
        "hora": 15,
        "minutos": 30
      }, // UTC-05:00 es 15 horas y 30 minutos atrás
      {
        "zone": "UTC+11:00",
        "offset": 11.0,
        "hora": 16,
        "minutos": 0
      }, // UTC-05:00 es 16 horas atrás
      {
        "zone": "UTC+12:00",
        "offset": 12.0,
        "hora": 17,
        "minutos": 0
      }, // UTC-05:00 es 17 horas atrás
      {
        "zone": "UTC+12:45",
        "offset": 12.75,
        "hora": 17,
        "minutos": 45
      }, // UTC-05:00 es 17 horas y 45 minutos atrás
      {
        "zone": "UTC+13:00",
        "offset": 13.0,
        "hora": 18,
        "minutos": 0
      }, // UTC-05:00 es 18 horas atrás
      {
        "zone": "UTC+14:00",
        "offset": 14.0,
        "hora": 19,
        "minutos": 0
      }, // UTC-05:00 es 19 horas atrás
    ];
  }

  // se encarga de iguar la el valor unix, para que coincida con UTC-05 sin
  //importar en la zona horaria que se genere
  static DateTime setUtc05EcuadorGuayaquil(DateTime dateTime,
      {required bool fechaServer}) {
    if (!fechaServer) {
      return dateTime;
    }

    // Obtén la fecha y hora actual
    DateTime now = dateTime;
    // Obtén la diferencia horaria del dispositivo con respecto a UTC
    // Obtener el offset de la zona horaria
    Duration timeZoneOffsetCelular = now.timeZoneOffset;

    // Obtener el nombre de la zona horaria
    String timeZoneName = now.timeZoneName;

    totpController.timeZone =
        "NameZone: ${timeZoneName} offset: ${timeZoneOffsetCelular}";

    String _tag = tag + "-setUtc05EcuadorGuayaquil";
    PrintsMsj.myLog(tag: _tag, title: "fechaInicial", detalle: now.toString());

    // Define la diferencia para UTC-05:00
    Duration utc5Offset = Duration(hours: -5);
    if (utc5Offset == timeZoneOffsetCelular) {
      PrintsMsj.myLog(
          tag: _tag, title: "retornando", detalle: utc5Offset.toString());
      PrintsMsj.myLog(tag: _tag, title: "fechaSalida", detalle: now.toString());

      return now;
    }

    // Calcula la diferencia que necesitas aplicar para ajustar a UTC-05:00
    Duration offsetDifference = utc5Offset - timeZoneOffsetCelular;
    // se resta para ajustar a la hora UTC-05 del server

    DateTime utc5Time = now;

    if (!fechaServer) {
      utc5Time = now.add(offsetDifference);
    } else {
      utc5Time = now.subtract(offsetDifference);
    }

    PrintsMsj.myLog(
        tag: _tag, title: "fechaSalida", detalle: utc5Time.toString());
    PrintsMsj.myLog(
        tag: _tag, title: "utc5Offset", detalle: utc5Offset.toString());
    PrintsMsj.myLog(
        tag: _tag,
        title: "timeZoneOffsetCelular",
        detalle: timeZoneOffsetCelular.toString());
    PrintsMsj.myLog(
        tag: _tag,
        title: "offsetDifference",
        detalle: offsetDifference.toString());

    return utc5Time;
  }

  static int getUnixTime(DateTime fecha) {
    //2024-08-20 09:45:15.000   1724165115  UTC-05  clave 117832
    //2024-08-20 10:45:15.000   1724168715  UTC-06

    /* final dateString = "2024-08-20 09:45:15";

    // Crear una instancia de DateTime con la fecha y hora proporcionadas
    final dateTime = DateTime.parse(dateString);
    fecha=dateTime;*/

    DateTime dt = fecha;

    //como el valor nos da en milisegundos los transformamos a segundos
    double segundos = dt.millisecondsSinceEpoch / 1000;
    int unixTimne = int.parse(segundos.toStringAsFixed(0));

    String _tag = tag + "-getUnixTime";
    PrintsMsj.myLog(
        tag: _tag, title: "getUnixTime", detalle: unixTimne.toString());

    return unixTimne;
  }

  static double parseOffsetno(String offsetStr) {
    // Verifica si el formato es correcto
    if (offsetStr.isEmpty || (offsetStr.length < 3 || offsetStr.length > 6)) {
      throw FormatException('Formato de offset inválido');
    }

    // Determina el signo del offset
    final sign = offsetStr[0] == '+' ? 1.0 : -1.0;

    // Extrae las horas y los minutos
    final hourStr = offsetStr.substring(1, 3);
    final minutesStr = offsetStr.length > 3 ? offsetStr.substring(3) : '00';

    final hours = int.parse(hourStr);
    final minutes = int.parse(minutesStr);

    // Calcula el offset en horas
    return sign * (hours + minutes / 60.0);
  }

  static int setUnixtimeDuration(int unixtime) {
    double unixtimeDuration = unixtime / _change_key_every;

    //se redondea el valor
    int floor = int.parse(unixtimeDuration.toStringAsFixed(0));

    return floor;
  }
}

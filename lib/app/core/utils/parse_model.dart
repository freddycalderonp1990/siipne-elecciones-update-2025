import 'my_date.dart';
import 'utilidadesUtil.dart';

class ParseModel {
  static int parseToInt(var value) {
    return value == null
        ? 0
        : value == ""
            ? 0
            : value is int
                ? value
                : int.parse(value);
  }

  static String parseToString(var value) {
    return value == null
        ? ""
        : value is String
            ? value
            : "";
  }

  static String parseToStringFecha(var value) {
    return MyDate.setFormatFechaString(parseToString(value));
  }

  static double parseToDouble(var value,{int decimales = 4}) {

    if(value==null){
      return 0;
    }

    value = value.toString().replaceAll(',', '.');

    double r = value == null
        ? 0
        : value == ""
            ? 0
            : value is double
                ? value
                : double.parse(value.toString());
    return UtilidadesUtil.redondearDouble(r,decimales: decimales);
  }

  static bool parseToBool(var value, {String? valueCompareTrue}) {
    if (valueCompareTrue != null) {
      return value == null
          ? false
          : value == ""
              ? false
              : value == valueCompareTrue
                  ? true
                  : false;
    }

    return value == null ? false : value;
  }
}

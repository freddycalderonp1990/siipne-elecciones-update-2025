import 'package:siipnelecciones3/app_elecciones/core/values/siipne_strings.dart';

class Validate {
  static  String? validateCedula(String? value) {
    if (value != null && value.length < 10) {
      return SiipneStrings.ingreseCedula;
    }

    return null;
  }

  static String? validateTelefono(String? value) {
    if (value != null && value.length < 8) {
      return "Ingrese el número de Teléfono";
    }

    return null;
  }

  static String? validateNumBoleta(String? value) {
    if (value != null && value.length < 5) {
      return SiipneStrings.ingreseBoleta;
    }
    return null;
  }

  static String? validateNumPersonal(String? value) {
    if (value != null && value.length == 0 ||
        value != null && int.parse(value) < 1) {
      return "Ingrese el Númerico del Personal";
    }

    return null;
  }

  static String? validateNumCitacion(String? value) {
    if (value != null && value.length < 3) {
      return SiipneStrings.ingreseCitacion;
    }

    return null;
  }

  static String? validateOrganizacion(String? value) {
    if (value != null && value.length < 3) {
      return "Ingrese Organización";
    }

    return null;
  }

  static String? validateDirigente(String? value) {
    if (value != null && value.length < 3) {
      return "Ingrese al Dirigente";
    }

    return null;
  }

  static String? validateCantidad(String? value) {
    if (value != null && value.length == 0 ||
        value != null && int.parse(value) == 0) {
      return "Ingrese una cantidad";
    }

    return null;
  }

  static String? validateNombre(String? value) {
    if (value != null && value.length < 3) {
      return "Ingrese el Nombre";
    }

    return null;
  }

  static String? validateCargo(String? value) {
    if (value != null && value.length < 3) {
      return "Ingrese el Cargo";
    }

    return null;
  }

  static String? validateMedioComunicacion(String? value) {
    if (value != null && value.length < 3) {
      return "Ingrese el nombre del Medio de Comunicación";
    }

    return null;
  }

  static String? validateFuncion(String? value) {
    if (value != null && value.length < 3) {
      return "Ingrese la función";
    }

    return null;
  }

  static String? validateDescripcion(String? value) {
    if (value != null && value.length < 3) {
      return "Ingrese la Descripción";
    }

    return null;
  }

  static String? validateInstalacion(String? value) {
    if (value != null && value.length < 3) {
      return "Ingrese la Instalación";
    }

    return null;
  }

  static String? validateDireccion(String? value) {
    if (value != null && value.length < 3) {
      return "Ingrese la Dirección";
    }

    return null;
  }

  static String? validateUnidad(String? value) {
    if (value != null && value.length < 3) {
      return "Ingrese la Unidad";
    }

    return null;
  }

  static String? validateNumerico(String? value) {
    if (value != null && value.length == 0 ||
        value != null && int.parse(value) == 0) {
      return "Ingrese el Numérico";
    }

    return null;
  }
}

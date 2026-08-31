import 'package:advanced_root_detection/advanced_root_detection.dart';

class SecurityGuard {
  SecurityGuard._();

  static final AdvanceRootDetection _shield = AdvanceRootDetection();

  static Future<ThreatReport> validate() async {
// Ejecuta todas las validaciones de seguridad disponibles.
    return await _shield.performCheck();
  }

  static Future<bool> isSecure() async {
// Verifica si el dispositivo y la aplicación no presentan amenazas detectadas.
    final report = await validate();
    return report.isClean;
  }

  static Future<bool> isRootDetected() async {
// Verifica si el dispositivo presenta indicios de privilegios elevados o acceso Root.
    final report = await validate();
    return report.isPrivilegedAccess;
  }

  static Future<bool> isHookingDetected() async {
// Verifica si existen indicios de manipulación o Hooking durante la ejecución.
    final report = await validate();
    return report.isRuntimeManipulated;
  }

  static Future<String> getSecurityMessage() async {
// Obtiene un mensaje descriptivo según la amenaza detectada.
    final report = await validate();

    if (report.isPrivilegedAccess) {
      return 'El dispositivo presenta privilegios Root. Por seguridad, no es posible utilizar la aplicación.';
    }

    if (report.isRuntimeManipulated) {
      return 'Se detectó una posible manipulación o Hooking en la aplicación. Por seguridad, no es posible continuar.';
    }

    if (!report.isClean) {
      return 'Se detectó una condición de seguridad que impide ejecutar la aplicación.';
    }

    return 'El dispositivo cumple con las validaciones de seguridad.';
  }
}
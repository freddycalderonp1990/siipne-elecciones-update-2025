import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:siipnemovil2/feactures/user/domain/entities/user.dart';
import 'package:siipnemovil2/feactures/user/domain/use_cases/local_store.dart';

import '../../../app_elecciones/core/siipne_config.dart';
import '../../../app_elecciones/core/values/mensajes_string.dart';
import '../../../app_elecciones/data/models/models.dart';
import '../../../app_elecciones/data/repository/data_repositories.dart';
import '../../../app_elecciones/domain/enums/enums.dart';
import '../../../app_elecciones/presentation/routes/siipne_routes.dart';
import '../../../app_elecciones/presentation/widgets/customWidgets.dart';
import '../../data/model/models.dart';
import '../../data/repository/data_repositories.dart';
import '../../presentation/routes/app_routes.dart';
import '../app_config.dart';
import '../utils/utilidadesUtil.dart';
import 'exceptions.dart';

class ExceptionHelper {
  //cunaod se cree una nnueva exceptio
  //agregar en las siguientes funciones throwError, manejarErroresMocks
  //y los mensjes van en manejarErroresShowDialogo

  static Future<bool> manejarErroresShowDialogo(
    Future<void> Function() funcion,
  ) async {
    try {
      await funcion();
      return true; // Operación exitosa
    } on UpdateAppException catch (e) {
      mensajeActualizarApp();
    } on ServerException catch (e) {
      if (e.message.contains("Usuario / Clave incorrecta")) {
        _verificarIntentosFallidosClave();

      }
      DialogosAwesome.getError(
        descripcion: e.message,
        btnOkOnPress: () {
         // Get.back();
        },
      );
    } on CloseRecintoException catch (e) {
      DialogosAwesome.getWarning(
        descripcion: e.msj,
        btnOkOnPress: () {
          Get.offAllNamed(SiipneRoutes.MENU_APP);
        },
      );
    } on ParseJsonException catch (e) {
      DialogosAwesome.getIconPolicia(
        titleBtnSi: "Aceptar",
        mostrarSegungoBtn: false,
        btnOkOnPress: () {
          Get.back();
        },
        descripcion: e.msj,
        title: 'ERROR',
      );
    } on TimeoutException catch (e) {
      DialogosAwesome.getIconPolicia(
        titleBtnSi: "Aceptar",
        mostrarSegungoBtn: false,
        btnOkOnPress: () {
          Get.back();
        },
        descripcion:
            "Tiempo de Espera Superado.\nIntente nuevamente o contacte al administrador.",
        title: 'ERROR',
      );
    } catch (e, t) {
      String msj = ExceptionHelper.setMensaje(
        mensaje:
            "Error Inesperado.\nIntente nuevamente o contacte al administrador.",
        msjException: "Error: ${e} - Linea: ${t}",
      );

      DialogosAwesome.getIconPolicia(
        titleBtnSi: "Aceptar",
        mostrarSegungoBtn: false,
        btnOkOnPress: () {
          Get.back();
        },
        descripcion: msj,
        title: 'ERROR',
      );
    }
    return false; // Hubo un error
  }

  static Future<T> manejarErroresParseJsonException<T>(
    Future<T> Function() funcion,
  ) async {
    try {
      return await funcion(); // Retorna el tipo de dato de la función
    } catch (e, t) {
      print("Problema en Parse Model:");
      // Manejo centralizado de excepciones
      throw ParseJsonException(
        message: "Problema en Parse Model: $e - stackTrace: $t",
      );
    }
  }

  static void _verificarIntentosFallidosClave() async {
    final LocalStoreUseCase _localStoreImpl = Get.find<LocalStoreUseCase>();
    //Obtenemos el contenedor de intentos fallidos
    int contadorfallido = await _localStoreImpl.getContadorFallido();
    contadorfallido = contadorfallido + 1;

    if (contadorfallido >= SiipneConfig.intentosFallidos) {
      // await _localStoreImpl.clearAllData();

      await _localStoreImpl.setConfigHuella(false);
      await _localStoreImpl.setContadorFallido(0);


      await _localStoreImpl.setLoginInit(false);
      await _localStoreImpl.setPass('');
      await _localStoreImpl.setPinCode('');

      await _localStoreImpl.setUser('');
      await _localStoreImpl.setUserModel(UserEntities.empty());

      DialogosAwesome.getWarning(
        descripcion: "Ah excedido el número de intentos permitidos",
        btnOkOnPress: () {
          Get.offAllNamed(AppRoutes.SPLASH_APP);
        },
      );
    } else {
      await _localStoreImpl.setContadorFallido(contadorfallido);
    }
  }

  static mensajeActualizarApp() {
    DialogosAwesome.getWarning(
      title: "ACTUALIZAR LA APP",
      descripcion: MensajesString.msjNuevaVersionApp,
      btnOkOnPress: () {
        Get.back();
        if (GetPlatform.isAndroid) {
          UtilidadesUtil.abrirUrl(SiipneConfig.linkAppAndroid);
          print('App Android');
        } else {
          UtilidadesUtil.abrirUrl(SiipneConfig.linkAppIos);
          print('App Ios');
        }
      },
    );
  }

  //se encarga de ejecutar la funcion al servidor y en caso de existir un timeoutException
  //valida que el usaurio sea el de google o ios de pruebas
  //para cargar la data desde un json
  static Future<T> executeWithMock<T>({
    required Future<T> Function() apiCall,
    required Future<T> Function() mockCall,
  }) async {
    try {
      return await apiCall();
    } catch (e, t) {
      if (e is TimeoutException && AppConfig.isUserGoogleOrIos) {
        AppConfig.secondsTimeout = 1;
        try {
          return await mockCall();
        } catch (mockError, mockTrace) {
          throw ParseJsonException(
            message:
                "Mock - Problema en Parse Model: $mockError - stackTrace: $mockTrace",
          );
        }
      } else {
        ExceptionHelper.throwError(e, t);
        throw e; // Re-lanza la excepción para que el flujo de errores se mantenga
      }
    }
  }

  static captureError(
    Object e,
    Object t,
    // Callback opcional para personalizar la lógica
  ) {
    print("Time out: ${AppConfig.secondsTimeout}");
    print("Tipo de excepción: ${e.toString()}");

    final exception =
        e is Exception
            ? e
            : Exception(e.toString()); // Asegura que sea una excepción válida

    // Verifica si es TimeoutException
    if (exception is TimeoutException) {
      // Permite ejecutar una acción personalizada antes de la activación de mocks

      // Validación para activar los mocks en ambiente de pruebas
      if (AppConfig.AmbienteUrl.toString() == Ambiente.prueba.toString()) {
        if (AppConfig.isUserGoogleOrIos) {
          AppConfig.activarMocks = true;
          AppConfig.secondsTimeout = 1;
          print("siiiii");
        }
      }
      String msj = ExceptionHelper.setMensaje(
        mensaje:
            "Se superó el tiempo de espera.\nIntente nuevamente o contacte al administrador.",
        msjException: "Error: ${e} - Linea: ${t}",
      );

      throw TimeoutException(msj);
    } else {
      throwError(e, t);
    }
  }

  static throwError(Object e, Object t) {
    final exception =
        e is Exception
            ? e
            : Exception(e.toString()); // Asegura que sea una excepción válida

    // Manejo de otras excepciones específicas
    if (exception is ParseJsonException) {
      throw ParseJsonException(message: exception.message);
    }
    if (exception is UpdateAppException) {
      throw UpdateAppException(message: exception.message);
    }

    if (exception is CloseRecintoException) {
      throw CloseRecintoException(message: exception.message);
    }
    if (exception is ServerException) {
      throw ServerException(message: exception.message);
    }
    if (exception is TimeoutException) {
      throw TimeoutException(exception.message);
    }
    String message = ExceptionHelper.setMensaje(
      mensaje: "Intente nuevamente o contacte al administrador.",
      msjException: "Error: ${e} - Linea: ${t}",
    );

    throw Exception(message);
  }

  static Future<T> manejarErroresMocks<T>(
    Future<T> Function() funcion,
    T Function()? mockData,
  ) async {
    try {
      return await funcion(); // Ejecuta la función principal
    } on ParseJsonException catch (e) {
      throw ParseJsonException(message: e.message);
    } on UpdateAppException catch (e) {
      throw UpdateAppException(message: e.message);
    } on CloseRecintoException catch (e) {
      throw CloseRecintoException(message: e.message);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } catch (e, t) {
      if (AppConfig.activarMocks && mockData != null) {
        try {
          return mockData(); // Retorna datos del mock con el tipo correcto
        } catch (mockError, mockStackTrace) {
          throw ExceptionHelper.captureError(mockError, mockStackTrace);
        }
      }

      throw ExceptionHelper.captureError(e, t);
    }
  }

  //lo que este en mensaje siempre se va a mostra
  //msjException solo se muestra si el ambiente es difrente de produccion
  static String setMensaje({
    String mensaje =
        "Ocurrió un problema. Intente nuevamente o contacte al administrador.",
    required String msjException,
  }) {
    if (AppConfig.AmbienteUrl.toString() != Ambiente.produccion.toString()) {
      mensaje = mensaje + ' Exception: ' + msjException;
    }
    return mensaje;
  }
}

import 'dart:async';

import 'package:api_provider/core/exceptions/exception_helper.dart';
import 'package:api_provider/core/exceptions/exceptions.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../feactures/user/domain/entities/user.dart';
import '../../../feactures/user/domain/use_cases/local_store.dart';
import '../../presentation/routes/app_routes.dart';
import '../../presentation/widgets/custom_app_widgets.dart';
import '../app_config.dart';
import '../utils/utilidadesUtil.dart';
import '../values/mensajes_string.dart';

class ExceptionDialogos {
  //cunaod se cree una nnueva exceptio
  //agregar en las siguientes funciones throwError, manejarErroresMocks
  //y los mensjes van en manejarErroresShowDialogo

  static Future<bool> manejarErroresShowDialogo(
    Future<void> Function() funcion,
  {String? msjNoData, bool showMsjNodata=true}
  ) async {
    try {
      await funcion();
      return true; // Operación exitosa
    } on AuthLoginException catch (e) {
      _verificarIntentosFallidosClave();
      DialogosAwesome.getError(
        descripcion: "Usuario / Clave incorrecta",
        btnOkOnPress: () {
          // Get.back();
        },
      );
    } on TokenException catch (e) {
      DialogosAwesome.getWarning(
        descripcion: e.msj,
        btnOkOnPress: () {
          // Get.back();
        },
      );
    } on UpdateAppException catch (e) {
      mensajeActualizarApp();
    } on ServerException catch (e) {
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
          Get.offAllNamed(AppRoutes.MENU_APP);
        },
      );
    } on ParseJsonException catch (e) {
      DialogosAwesome.getError(
        btnOkOnPress: () {
          Get.back();
        },
        descripcion: e.msj,
      );
    } on NoDataException catch (e) {
      if(showMsjNodata){
        DialogosAwesome.getInformation(

          descripcion:msjNoData==null? e.msj:msjNoData,
          title: 'SIN DATOS',
        );
      }
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

  static void _verificarIntentosFallidosClave() async {
    final LocalStoreUseCase _localStoreImpl = Get.find<LocalStoreUseCase>();
    //Obtenemos el contenedor de intentos fallidos
    int contadorfallido = await _localStoreImpl.getContadorFallido();
    contadorfallido = contadorfallido + 1;

    if (contadorfallido >= AppConfig.intentosFallidosLogin) {
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
          UtilidadesUtil.abrirUrl(AppConfig.linkAppAndroid);
          print('App Android');
        } else {
          UtilidadesUtil.abrirUrl(AppConfig.linkAppIos);
          print('App Ios');
        }
      },
    );
  }
}

class TutorialAppStrings {
//*++++++++++++++++ PASOS LOGIN +++++++++++++++++++++++++++++++++

  static ModelPaso get pasoIntroduccionLogin {
    String title = "Introducción";
    String pasos =
        "Te damos la bienvenida para que comprendas cómo funciona la aplicación. "
        "Te invitamos a seguir el tutorial donde te guiaremos paso a paso para asegurarnos de que "
        "tengas la mejor experiencia";
    return ModelPaso(title: title, pasos: pasos);
  }

  static ModelPaso get pasoUsuario {
    String title = "Usuario";
    String pasos =
        "Ingresa el usuario que normalmente utilizas para acceder al SIIPNE 3W.";
    return ModelPaso(title: title, pasos: pasos);
  }

  static ModelPaso get pasoClave {
    String title = "Clave";
    String pasos =
        "Ingresa la contraseña que utilizas para acceder al SIIPNE 3W. \nPor seguridad, nunca compartas tu usuario y contraseña con nadie.";

    return ModelPaso(title: title, pasos: pasos);
  }

  static ModelPaso get pasoBtnIngresar {
    String title = "Ingresar";
    String pasos =
        'Una vez que hayas ingresado tu usuario y contraseña, debes presionar el botón "Ingresar" para validar y acceder al sistema.';
    return ModelPaso(title: title, pasos: pasos);
  }

  static ModelPaso get pasoOlvidoSuClave {
    String title = "Olvidó su contraseña";
    String pasos =
        'Si tienes problemas para acceder o has olvidado tu contraseña, intenta recuperarla mediante el proceso de recuperación de contraseña.';
    return ModelPaso(title: title, pasos: pasos);
  }
//*++++++++++++++++ END PASOS LOGIN +++++++++++++++++++++++++++++++++

//*++++++++++++++++ PASOS CLAVE DIGITAL +++++++++++++++++++++++++++++++++
  static ModelPaso get pasoIntroduccionLoginRapido {
    String title = "";
    String pasos =
        "Continua con el tutorial para que puedas comprender las nuevas funcionalidades.";
    return ModelPaso(title: title, pasos: pasos);
  }

  static ModelPaso get pasoBtnClaveDigital {
    String title = "Clave Digital";
    String pasos =
        "Por favor, elige esta opción para crear los códigos temporales y asegúrate de introducirlos en el SIIPNE 3w cuando te lo pida.";
    return ModelPaso(title: title, pasos: pasos);
  }

  static ModelPaso get pasoBtnOtroUser{
    String title = "Ingresar con otro usuario";
    String pasos =
        "Selecciona esta opción si los códigos generados no te permiten acceder al SIIPNE 3W o si necesitas ingresar con otro usuario y contraseña";
    return ModelPaso(title: title, pasos: pasos);
  }

//*++++++++++++++++ END PASOS CLAVE DIGITAL +++++++++++++++++++++++++++++++++
}



class ModelPaso {
  final String title;
  final String pasos;

  ModelPaso({required this.title, required this.pasos});
}

part of '../custom_app_widgets.dart';

class DialogosAwesome {
  static bool isDiaslogoShow = false;

  static Color colorWarning = Color(0xFFF46B40);
  static Color colorInformacion = AppColors.colorAzul;
  static Color colorError = Color(0xFFEA4236);
  static Color colorSucess = Color(0xFF10C26E);

  static String imgDefault = AppImages.escudopolicia;

  static showIconPolicia({
    bool mostrarSegungoBtn = true,
    Color colorBtnSi = AppColors.colorBotones,
    Color colorTitle = AppColors.colorAzul,
    Color colorCircleImg = AppColors.colorAzul,
    String imgString = AppImages.escudopolicia,

    required String title,

    IconData iconBtnSi = Icons.check_circle_outline,
    IconData iconBtnNo = Icons.cancel_outlined,

    String titleBtnSi = 'Aceptar',
    String titleBtnNo = 'Cancelar',
    required String descripcion,
    required Function() btnOkOnPress,
    Function()? btnCancelOnPress,
  }) {
    return _getIconPolicia(
      mostrarSegungoBtn: mostrarSegungoBtn,
      colorBtnSi: colorBtnSi,
      colorTitle: colorTitle,
      colorCircleImg: colorCircleImg,

      imgString: imgString,
      title: title,
      iconBtnSi: iconBtnSi,
      iconBtnNo: iconBtnNo,

      titleBtnSi: titleBtnSi,
      titleBtnNo: titleBtnNo,
      descripcion: descripcion,
      btnOkOnPress: btnOkOnPress,
      btnCancelOnPress: btnCancelOnPress,
    );
  }

  static _getIconPolicia({
    bool mostrarSegungoBtn = true,
    Color colorBtnSi = AppColors.colorBotones,
    Color colorTitle = AppColors.colorAzul,
    Color colorCircleImg = AppColors.colorAzul,
    String imgString = AppImages.escudopolicia,

    required String title,

    IconData iconBtnSi = Icons.check_circle_outline,
    IconData iconBtnNo = Icons.cancel_outlined,

    String titleBtnSi = 'Aceptar',
    String titleBtnNo = 'Cancelar',
    required String descripcion,
    required Function() btnOkOnPress,
    Function()? btnCancelOnPress,
  }) {
    if (isDiaslogoShow) {
      return;
    }
    AwesomeDialog(
      dismissOnTouchOutside: false,

      dismissOnBackKeyPress: false,
      context: Get.context!,
      dialogType: DialogType.info,

      headerAnimationLoop: true,
      customHeader: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: colorCircleImg, width: 3),
        ),
        child: Center(
          child: Image.asset(
            imgString,
            width: 60, // Ajusta el tamaño para que no se recorte
            height: 60,
            fit: BoxFit.contain, // Mantiene proporciones
          ),
        ),
      ),
      animType: AnimType.scale,
      title: title,
      titleTextStyle: TextStyle(
        color: colorTitle,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),

      btnCancel: BtnIconWidget(
        colorBtn: colorBtnSi,
        icon: iconBtnSi,
        onPressed: () {
          isDiaslogoShow = false;
          Get.back();
          if (btnOkOnPress != null) {
            btnOkOnPress();
          }
        },
        titulo: titleBtnSi,
      ),

      btnOk: !mostrarSegungoBtn
          ? null
          : BtnIconWidget(
              colorBtn: AppColors.colorRojo_60,
              icon: iconBtnNo,
              onPressed: () {
                if (btnCancelOnPress != null) {
                  isDiaslogoShow = false;
                  Get.back();
                  btnCancelOnPress(); // Ejecuta la función si está definida
                } else {
                  isDiaslogoShow = false;
                  Get.back();
                }
              },
              titulo: titleBtnNo,
            ),
      desc: descripcion,
    ).show();
  }

  static getWarning({
    String title = 'ADVERTENCIA',
    String titleBtnOk = 'Ok',
    required String descripcion,
    Function()? btnOkOnPress,
  }) {
    return DialogosAwesome._getIconPolicia(
      colorBtnSi: colorWarning,
      colorCircleImg: colorWarning,
      colorTitle: colorWarning,
      title: title,
      descripcion: descripcion,
      btnOkOnPress: btnOkOnPress == null ? () {} : btnOkOnPress,
      titleBtnSi: "ACEPTAR",
      mostrarSegungoBtn: false,
    );
  }

  static getWarningSiNoContador({
    String title = 'ADVERTENCIA',
    required String descripcion,
    Function()? btnOkOnPress,
    Function()? btnCancelOnPress,
  }) {
    return showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) {
        int segundos = 5;
        bool botonesHabilitados = false;
        Timer? timer;

        return StatefulBuilder(
          builder: (context, setState) {
            timer ??= Timer.periodic(const Duration(seconds: 1), (t) {
              if (segundos > 1) {
                setState(() {
                  segundos--;
                });
              } else {
                setState(() {
                  segundos = 0;
                  botonesHabilitados = true;
                });
                t.cancel();
              }
            });

            return Dialog(
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 24,
              ),
              backgroundColor: Colors.transparent,
              child: Container(
                width: double.infinity,
                constraints: const BoxConstraints(maxWidth: 430),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFDCE4EC)),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF17365D).withOpacity(.16),
                      blurRadius: 24,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: SingleChildScrollView(child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(16, 15, 16, 13),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF123F75),
                            Color(0xFF195496),
                            Color(0xFF2869AC),
                          ],
                        ),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      child:Column(
                        crossAxisAlignment:CrossAxisAlignment.stretch,
                        children:[
                          Row(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children:[
                              Container(
                                width:50,
                                height:50,
                                padding:const EdgeInsets.all(7),
                                decoration:BoxDecoration(
                                  color:Colors.white.withOpacity(.14),
                                  borderRadius:BorderRadius.circular(14),
                                  border:Border.all(
                                    color:Colors.white.withOpacity(.25),
                                  ),
                                  boxShadow:[
                                    BoxShadow(
                                      color:Colors.black.withOpacity(.10),
                                      blurRadius:8,
                                      offset:const Offset(0,3),
                                    ),
                                  ],
                                ),
                                child:Image.asset(
                                  AppImages.escudopolicia,
                                  fit:BoxFit.contain,
                                ),
                              ),

                              const SizedBox(width:10),

                              Expanded(
                                child:Column(
                                  crossAxisAlignment:CrossAxisAlignment.start,
                                  children:[
                                    Container(
                                      padding:const EdgeInsets.symmetric(
                                        horizontal:7,
                                        vertical:3,
                                      ),
                                      decoration:BoxDecoration(
                                        color:Colors.white.withOpacity(.12),
                                        borderRadius:BorderRadius.circular(20),
                                      ),
                                      child:const Text(
                                        'CONFIRMACIÓN DE SEGURIDAD',
                                        style:TextStyle(
                                          color:Colors.white70,
                                          fontSize:6.6,
                                          fontWeight:FontWeight.w900,
                                          letterSpacing:.7,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height:5),

                                    Text(
                                      title,
                                      textAlign:TextAlign.left,
                                      softWrap:true,
                                      maxLines:null,
                                      overflow:TextOverflow.visible,
                                      style:const TextStyle(
                                        color:Colors.white,
                                        fontSize:16,
                                        fontWeight:FontWeight.w900,
                                        height:1.12,
                                        letterSpacing:.1,
                                      ),
                                    ),

                                    const SizedBox(height:4),

                                    const Text(
                                      'Revise la información antes de continuar',
                                      style:TextStyle(
                                        color:Colors.white70,
                                        fontSize:7.3,
                                        height:1.15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(width:8),

                              Container(
                                width:40,
                                height:40,
                                decoration:BoxDecoration(
                                  color:const Color(0xFFFFC857).withOpacity(.18),
                                  borderRadius:BorderRadius.circular(12),
                                  border:Border.all(
                                    color:const Color(0xFFFFD77A).withOpacity(.35),
                                  ),
                                ),
                                child:const Icon(
                                  Icons.warning_amber_rounded,
                                  color:Color(0xFFFFD36A),
                                  size:22,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height:12),

                          Container(
                            height:1,
                            width:double.infinity,
                            color:Colors.white.withOpacity(.14),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(11),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F9FB),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: const Color(0xFFE0E7ED),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: TextoColorParser.textoConColores(
                                    descripcion,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 14),

                          if (!botonesHabilitados)
                            _contadorConfirmacion(segundos: segundos),

                          if (botonesHabilitados)
                            Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEAF5EE),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: const Color(
                                        0xFF218A61,
                                      ).withOpacity(.16),
                                    ),
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.verified_outlined,
                                        color: Color(0xFF218A61),
                                        size: 16,
                                      ),

                                      SizedBox(width: 7),

                                      Expanded(
                                        child: Text(
                                          'La acción está habilitada. Seleccione una opción para continuar.',
                                          style: TextStyle(
                                            color: Color(0xFF4F6B5C),
                                            fontSize: 7.2,
                                            height: 1.2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 12),

                                Row(
                                  children: [
                                    Expanded(
                                      child: _botonDialogoSecundario(
                                        icon: Icons.close_rounded,
                                        titulo: 'NO',
                                        onPressed: () {
                                          Navigator.of(context).pop(false);

                                          if (btnCancelOnPress != null) {
                                            btnCancelOnPress();
                                          }
                                        },
                                      ),
                                    ),

                                    const SizedBox(width: 9),

                                    Expanded(
                                      child: _botonDialogoPrincipal(
                                        icon: Icons.check_rounded,
                                        titulo: 'SÍ, CONTINUAR',
                                        onPressed: () {
                                          Navigator.of(context).pop(true);

                                          if (btnOkOnPress != null) {
                                            btnOkOnPress();
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),),
              ),
            );
          },
        );
      },
    );
  }

  static Widget _contadorConfirmacion({required int segundos}) {
    final double progreso = (5 - segundos) / 5;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF1F8),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF195496).withOpacity(.12)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: const Icon(
                  Icons.timer_outlined,
                  color: Color(0xFF195496),
                  size: 20,
                ),
              ),

              const SizedBox(width: 9),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'CONFIRMACIÓN DE SEGURIDAD',
                      style: TextStyle(
                        color: Color(0xFF17365D),
                        fontSize: 8.5,
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                    const SizedBox(height: 2),

                    Text(
                      segundos > 1
                          ? 'Espere $segundos segundos para habilitar las opciones'
                          : 'Espere $segundos segundo para habilitar las opciones',
                      style: const TextStyle(
                        color: Color(0xFF7A8998),
                        fontSize: 7,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width: 38,
                height: 38,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFF195496),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Text(
                  '$segundos',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progreso,
              minHeight: 6,
              backgroundColor: Colors.white,
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF195496),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _botonDialogoPrincipal({
    required IconData icon,
    required String titulo,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(13),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        splashColor: Colors.white.withOpacity(.14),
        child: Ink(
          height: 45,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF123F75), Color(0xFF195496), Color(0xFF2869AC)],
            ),
            borderRadius: BorderRadius.circular(13),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF195496).withOpacity(.18),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 17),

              const SizedBox(width: 6),

              Flexible(
                child: Text(
                  titulo,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 8.3,
                    fontWeight: FontWeight.w900,
                    letterSpacing: .3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _botonDialogoSecundario({
    required IconData icon,
    required String titulo,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(13),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        splashColor: const Color(0xFF7A8998).withOpacity(.08),
        child: Ink(
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: const Color(0xFFDCE4EC)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: const Color(0xFF68798A), size: 17),

              const SizedBox(width: 6),

              Text(
                titulo,
                style: const TextStyle(
                  color: Color(0xFF68798A),
                  fontSize: 8.5,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static getWarningSiNo({
    String title = 'ADVERTENCIA',
    required String descripcion,
    Function()? btnOkOnPress,
    Function()? btnCancelOnPress,
  }) {
    return DialogosAwesome._getIconPolicia(
      colorBtnSi: colorInformacion,
      colorCircleImg: colorWarning,
      colorTitle: colorWarning,
      title: title,
      descripcion: descripcion,
      btnOkOnPress: btnOkOnPress == null ? () {} : btnOkOnPress,
      titleBtnSi: "Si",
      mostrarSegungoBtn: true,
      titleBtnNo: "No",
      btnCancelOnPress: btnCancelOnPress == null ? () {} : btnCancelOnPress,
    );
  }

  static getError({
    String title = 'ERROR',
    required String descripcion,
    Function()? btnOkOnPress,
  }) {
    return DialogosAwesome._getIconPolicia(
      colorBtnSi: colorError,
      colorCircleImg: colorError,
      colorTitle: colorError,
      title: title,
      descripcion: descripcion,
      btnOkOnPress: btnOkOnPress == null ? () {} : btnOkOnPress,
      titleBtnSi: "ACEPTAR",
      mostrarSegungoBtn: false,
    );
  }

  static getSucess({
    String title = 'ÉXITO',
    required String descripcion,
    Function()? btnOkOnPress,
  }) {
    return DialogosAwesome._getIconPolicia(
      colorBtnSi: colorSucess,
      colorCircleImg: colorSucess,
      colorTitle: colorSucess,
      title: title,
      descripcion: descripcion,
      btnOkOnPress: btnOkOnPress == null ? () {} : btnOkOnPress,
      titleBtnSi: "ACEPTAR",
      mostrarSegungoBtn: false,
    );
  }

  static getInformation({
    String title = 'INFORMACIÓN',
    required String descripcion,
    Function()? btnOkOnPress,
  }) {
    return DialogosAwesome._getIconPolicia(
      colorBtnSi: colorInformacion,
      colorCircleImg: colorInformacion,
      colorTitle: colorInformacion,
      title: title,
      descripcion: descripcion,
      btnOkOnPress: btnOkOnPress == null ? () {} : btnOkOnPress,
      titleBtnSi: "Ok",
      mostrarSegungoBtn: false,
    );
  }

  static getInformationSiNo({
    String title = 'INFORMACIÓN',
    required String descripcion,
    Function()? btnOkOnPress,
    Function()? btnCancelOnPress,
  }) {
    return DialogosAwesome._getIconPolicia(
      colorBtnSi: colorInformacion,
      colorCircleImg: colorInformacion,
      colorTitle: colorInformacion,
      title: title,
      descripcion: descripcion,
      btnOkOnPress: btnOkOnPress == null ? () {} : btnOkOnPress,
      titleBtnNo: "No",
      titleBtnSi: "SI",
      mostrarSegungoBtn: true,
      btnCancelOnPress: btnCancelOnPress == null ? () {} : btnCancelOnPress,
    );
  }

  static getDesingChangePass({
    required GlobalKey<FormState> formKey, // Asegurar el tipo correcto
    required TextEditingController controllerPass,
    VoidCallback? onPressed,
    String title = 'INFO',

    required int idDgoCreaOpReci,

    String? descripcion,
  }) {
    late AwesomeDialog dialog;
    final responsive = ResponsiveUtil();
    final sizeTxt = responsive.diagonalP(AppConfig.tamTextoTitulo);

    if (descripcion == null) {
      descripcion =
          "Para abandonar el código ${idDgoCreaOpReci}, ingrese su clave de seguridad";
    }

    dialog = AwesomeDialog(
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      dialogType: DialogType.info,
      headerAnimationLoop: false, // Desactiva la animación en loop
      animType: AnimType.topSlide,
      customHeader: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: colorInformacion, width: 3),
        ),
        child: Center(
          child: Image.asset(
            AppImages.escudopolicia,
            width: 60, // Ajusta el tamaño para que no se recorte
            height: 60,
            fit: BoxFit.contain, // Mantiene proporciones
          ),
        ),
      ),
      context: Get.context!,
      showCloseIcon: true,
      keyboardAware: true,
      body: Form(
        // Asegurar que formKey está dentro de un Form
        key: formKey,
        child: Column(
          children: <Widget>[
            TituloTextWidget(title: title),
            Text(descripcion),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // Para probar container
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ImputTextWidget(
                imgString: AppImages.icon_clave,
                elevation: 1,
                isSegura: true,
                controller: controllerPass,
                hitText: "Ingrese la clave",
                label: "Clave",
                fonSize: sizeTxt,
                validar: (text) {
                  if (text != null && text.length >= 8) {
                    return null;
                  }
                  return "Clave no válida";
                },
              ),
            ),
            SizedBox(height: 20),
            BotonesWidget(
              iconData: Icons.check_circle,
              title: "ACEPTAR",
              onPressed: () async {
                bool isValid = formKey.currentState?.validate() ?? false;
                if (isValid) {
                  LoginController loginController = Get.find();

                  String pass = controllerPass.text;
                  bool rersul = await loginController.validarPass(pass);

                  controllerPass.clear();
                  if (!rersul) {
                    Get.back();
                    DialogosAwesome.getError(
                      descripcion: "La clave ingresada no es la correcta",
                    );
                    return;
                  }
                  // Si el formulario es válido, ejecutar la acción
                  Get.back();

                  DialogosAwesome.getWarningSiNoContador(
                    descripcion: "¿Esta seguro de continuar?",
                    btnOkOnPress: () {
                      onPressed?.call();
                    },
                  );
                }
              },
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    )..show();
  }

  static getPersonalizado({
    String title = 'Información',
    required String descripcion,
  }) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      context: Get.context!,
      animType: AnimType.scale,
      customHeader: Icon(Icons.face, size: 50, color: Colors.black),
      title: 'This is Custom Dialod',
      desc: 'Confirm or cancel the deletion process',
      btnOk: TextButton(
        child: Text('Cancel Button'),
        onPressed: () {
          Get.back();
        },
      ),
      //this is ignored
      btnOkOnPress: () {},
    ).show();
  }
}

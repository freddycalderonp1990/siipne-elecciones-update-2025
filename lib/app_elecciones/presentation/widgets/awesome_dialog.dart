part of 'customWidgets.dart';

class DialogosAwesome {


  static getDesingChangePass({
    required GlobalKey<FormState> formKey, // Asegurar el tipo correcto
    required TextEditingController controllerPass,
    VoidCallback? onPressed,
    String title = 'INFO',
    required String descripcion,
  }) {
    late AwesomeDialog dialog;
    final responsive = ResponsiveUtil();
    final sizeTxt = responsive.diagonalP(AppConfig.tamTextoTitulo);

    dialog = AwesomeDialog(
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      dialogType: DialogType.info,
      headerAnimationLoop: false, // Desactiva la animación en loop
      animType: AnimType.topSlide,
      context: Get.context!,
      showCloseIcon: true,
      keyboardAware: true,
      body: Form( // Asegurar que formKey está dentro de un Form
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
                if (isValid)  {


                  LoginController loginController=Get.find();
                  String pass=controllerPass.text;
                  bool rersul=  await loginController.validarPass(pass);

                  controllerPass.clear();
                 if(!rersul){
                   Get.back();
                   DialogosAwesome.getError(descripcion: "La clave ingresada no es la correcta");
                   return;
                 }
                   // Si el formulario es válido, ejecutar la acción
                   Get.back();
                   onPressed?.call();




                }
              },
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    )..show();
  }

  static getError(
      {String title = 'ERROR',
        required String descripcion,
        Function()? btnOkOnPress}) {
    AwesomeDialog(
        dismissOnTouchOutside: false,
        dismissOnBackKeyPress: false,
        context: Get.context!,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        headerAnimationLoop: false,
        title: title,
        desc: descripcion,
        btnOkText: "Ok",
        btnOkOnPress: btnOkOnPress == null ? () {} : btnOkOnPress,
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red)
      ..show();
  }

  static getSucess(
      {String title = 'ÉXITO',
        required String descripcion,
        Function()? btnOkOnPress}) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      context: Get.context!,
      animType: AnimType.topSlide,
      dialogType: DialogType.success,
      title: title,
      headerAnimationLoop: false,
      desc: descripcion,
      btnOkText: "Ok",
      btnOkIcon: Icons.check_circle,
      btnOkOnPress: btnOkOnPress == null
          ? () {
        Get.back();
      }
          : btnOkOnPress,
    ).show();
  }

  static getWarning(
      {String title = 'Advertencia',
        String titleBtnOk = 'Ok',
        required String descripcion,
        Function()? btnOkOnPress}) {
    AwesomeDialog(
        dismissOnTouchOutside: false,
        dismissOnBackKeyPress: false,
        context: Get.context!,
        dialogType: DialogType.warning,
        headerAnimationLoop: false,
        animType: AnimType.topSlide,
        title: title,
        desc: descripcion,
        btnCancelIcon: Icons.cancel_rounded,
        btnOkIcon: Icons.check_circle,
        btnCancelText: "No",
        btnOkColor: Colors.deepOrangeAccent,
        btnOkText: titleBtnOk,

        btnOkOnPress: btnOkOnPress ?? () {
          Get.back();
        })
        .show();
  }


  static getIconPolicia(
      {
        bool mostrarSegungoBtn=true,
        Color colorBtnSi=AppColors.colorBotones,

        required String title ,

        IconData iconBtnSi= Icons.check_circle_outline,
        IconData iconBtnNo= Icons.cancel_outlined,

        String titleBtnSi = 'Si',
        String titleBtnNo = 'No',
        required String descripcion,
       required Function() btnOkOnPress,Function()? btnCancelOnPress}) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      context: Get.context!,
      dialogType: DialogType.info,
      headerAnimationLoop: false,
      customHeader: Container(
        child: Image.asset(SiipneImages.imgIconD),
      ),
      animType: AnimType.scale,
      title: title,
      btnCancel: BtnIconWidget(
        colorBtn: colorBtnSi,
        icon: iconBtnSi,
        onPressed: (){
         // Get.back();
          btnOkOnPress();
        },
        titulo: titleBtnSi,
      ),

      btnOk:!mostrarSegungoBtn?null: BtnIconWidget(

        colorBtn: AppColors.colorRojo_60,
        icon: iconBtnNo,
        onPressed: btnCancelOnPress!=null?btnCancelOnPress: () {
          Get.back();
        },
        titulo: titleBtnNo,
      ),
      desc: descripcion,

    ).show();
  }

  static getWarningSiNo(
      {String title = 'ADVERTENCIA',
        required String descripcion,
        Function()? btnOkOnPress,Function()? btnCancelOnPress}) {
    AwesomeDialog(
        dismissOnTouchOutside: false,
        dismissOnBackKeyPress: false,
        context: Get.context!,
        dialogType: DialogType.warning,
        headerAnimationLoop: false,
        animType: AnimType.topSlide,
        title: title,
        desc: descripcion,
        btnCancelText: "No",
        btnCancelIcon: Icons.cancel_rounded,
        btnOkIcon: Icons.check_circle,
        btnOkColor: AppColors.colorAzul,
        btnOkText: "Si",
        btnCancelOnPress:btnCancelOnPress!=null?btnCancelOnPress: () {
          Get.back();
        },
        btnOkOnPress: btnOkOnPress)
        .show();
  }

  static getInformation(
      {String title = 'Información', required String descripcion,  Function()? btnOkOnPress,}) {
    AwesomeDialog(

        dismissOnTouchOutside: false,
        dismissOnBackKeyPress: false,
        context: Get.context!,
        dialogType: DialogType.info,
        headerAnimationLoop: false,
        animType: AnimType.topSlide,
        title: title,
        desc: descripcion,
        btnCancelText: "Aceptar",
        btnCancelIcon: Icons.cancel_rounded,
        btnOkIcon: Icons.check_circle,

        btnOkOnPress: btnOkOnPress == null
            ? () {
          Get.back();
        }:btnOkOnPress
      ).show();
  }

  static getInformationAceptar({
    String title = 'Información',
    required String descripcion,
    required Function() btnOkOnPress,
  }) {
    AwesomeDialog(
        dismissOnTouchOutside: false,
        dismissOnBackKeyPress: false,
        context: Get.context!,
        dialogType: DialogType.info,
        headerAnimationLoop: false,
        animType: AnimType.topSlide,
        title: title,
        desc: descripcion,
        btnCancelText: "Aceptar",
        btnCancelIcon: Icons.cancel_rounded,
        btnOkIcon: Icons.check_circle,
        btnOkOnPress: btnOkOnPress)
        .show();
  }

  static getInformationSiNo(
      {String title = 'INFORMACIÓN',
        required String descripcion,
        Function()? btnOkOnPress,
        Function()? btnCancelOnPress}) {
    AwesomeDialog(
        dismissOnTouchOutside: false,
        dismissOnBackKeyPress: false,
        context: Get.context!,
        dialogType: DialogType.info,
        headerAnimationLoop: false,
        animType: AnimType.topSlide,
        title: title,
        btnCancelIcon: Icons.cancel_rounded,
        btnOkIcon: Icons.check_circle,
        desc: descripcion,
        btnCancelText: "No",
        btnOkText: "Si",
        btnCancelOnPress: btnCancelOnPress == null
            ? () {
          Get.back();
        }
            : btnCancelOnPress,
        btnOkOnPress: btnOkOnPress)
        .show();
  }

  static getInformationSi({
    String title = 'INFORMACIÓN',
    required String descripcion,
    Function()? btnOkOnPress,
  }) {
    AwesomeDialog(
        dismissOnTouchOutside: false,
        dismissOnBackKeyPress: false,
        context: Get.context!,
        dialogType: DialogType.info,
        headerAnimationLoop: false,
        animType: AnimType.topSlide,
        title: title,
        btnCancelIcon: Icons.cancel_rounded,
        btnOkIcon: Icons.check_circle,
        desc: descripcion,
        btnCancelText: "No",
        btnOkText: "Ok",
        btnOkOnPress: btnOkOnPress)
        .show();
  }

  static getPersonalizado(
      {String title = 'Información', required String descripcion}) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      context: Get.context!,
      animType: AnimType.scale,
      customHeader: Icon(
        Icons.face,
        size: 50,
        color: Colors.black,
      ),
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
  static getMasInformacion(
      {required Uint8List? img,
      required String documento,
      required String link,
        required  Function()? btnOkOnPressPdf,required  Function()? btnOkOnPressLink}) {
    final responsive =ResponsiveUtil();
    AwesomeDialog(
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      context: Get.context!,
      dialogType: DialogType.info,
      headerAnimationLoop: true,
      customHeader: Container(
        child: Container(
          width: responsive.anchoP(24),
          height: responsive.altoP(12),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: MemoryImage(img!), // Cambiado Image.memory por MemoryImage
              fit: BoxFit.contain,
            ),
            color: Colors.white,
            border: Border.all(
              color: AppColors.colorPrimary,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(80.0),
          ),
        ),
      ),
      body: botonesMasInformacion(documento,link,btnOkOnPressPdf,btnOkOnPressLink),
      animType: AnimType.scale,
      title: '',
      desc: '',
      showCloseIcon: true,
    ).show();
  }
static Widget botonesMasInformacion(String documento,String link,Function()? btnOkOnPressPdf,Function()? btnOkOnPressLink){
    final responsive =ResponsiveUtil();
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
              children: [
                documento!=''?btnPdf(responsive,documento,btnOkOnPressPdf):Container(),
                documento.isEmpty ||link.isEmpty? Container():SizedBox(width: responsive.anchoP(10),),
                link!=''?btnLinkPagina(responsive,link,btnOkOnPressLink):Container(),
                ],
         ),
      );
}
  static Widget btnLinkPagina(ResponsiveUtil responsive,String link,Function()? btnOkOnPressLink) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConfig.radioBordecajas),
          boxShadow: [
            BoxShadow(
                color: Colors.blueAccent,
                blurRadius: AppConfig.sobraBordecajas)
          ]),
      child: Material(
        shadowColor: Colors.black12 != null ? Colors.black12 : Colors.white,
        borderRadius: BorderRadius.circular(20),
        elevation: 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            btnOkOnPressLink!();
          },
          // handle your onTap here
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: responsive.anchoP(20),
                  height: responsive.anchoP(20),
                  child: Image.asset(
                    AppImages.web,
                  ),
                ),
                SizedBox(
                  width: responsive.altoP(1),
                ),
                Container(
                    child: Text(
                      "Link Página WEB",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: responsive.anchoP(AppConfig.tamTextoTitulo)),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget btnPdf(ResponsiveUtil responsive,String documento,Function()? btnOkOnPress){
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConfig.radioBordecajas),
          boxShadow: [
            BoxShadow(
                color: Colors.blueAccent,
                blurRadius: AppConfig.sobraBordecajas)
          ]),
      child: Material(
        shadowColor: Colors.black12 != null ? Colors.black12 : Colors.white,
        borderRadius: BorderRadius.circular(20),
        elevation: 1,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            btnOkOnPress!();
          },
          // handle your onTap here
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(

                  width: responsive.anchoP(20),
                  height: responsive.anchoP(20),
                  child: Image.asset(
                    AppImages.pdf,
                  ),
                ),
                SizedBox(
                  width: responsive.altoP(1),
                ),
                Container(
                    child: Text(
                      "Más Información",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: responsive.anchoP(AppConfig.tamTextoTitulo)),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

part of '../custom_app_widgets.dart';

class DialogosAwesome {

  static  bool isDiaslogoShow= false;

 static Color colorWarning=Color(0xFFF46B40);
 static Color colorInformacion=AppColors.colorAzul;
 static Color colorError=Color(0xFFEA4236);
 static Color colorSucess=Color(0xFF10C26E);

 static String imgDefault=AppImages.escudopolicia;



 static showIconPolicia(
     {
       bool mostrarSegungoBtn=true,
       Color colorBtnSi=AppColors.colorBotones,
       Color colorTitle=AppColors.colorAzul,
       Color colorCircleImg=AppColors.colorAzul,
       String imgString=AppImages.escudopolicia,

       required String title ,

       IconData iconBtnSi= Icons.check_circle_outline,
       IconData iconBtnNo= Icons.cancel_outlined,

       String titleBtnSi = 'Aceptar',
       String titleBtnNo = 'Cancelar',
       required String descripcion,
       required Function() btnOkOnPress,Function()? btnCancelOnPress}) {
   return _getIconPolicia(mostrarSegungoBtn: mostrarSegungoBtn, colorBtnSi: colorBtnSi, colorTitle: colorTitle,
       colorCircleImg:colorCircleImg,

       imgString: imgString, title: title, iconBtnSi: iconBtnSi,
       iconBtnNo:iconBtnNo,

       titleBtnSi: titleBtnSi, titleBtnNo: titleBtnNo, descripcion: descripcion,
       btnOkOnPress:btnOkOnPress, btnCancelOnPress:btnCancelOnPress
   );
 }

  static _getIconPolicia(
     {
       bool mostrarSegungoBtn=true,
       Color colorBtnSi=AppColors.colorBotones,
       Color colorTitle=AppColors.colorAzul,
       Color colorCircleImg=AppColors.colorAzul,
       String imgString=AppImages.escudopolicia,

       required String title ,

       IconData iconBtnSi= Icons.check_circle_outline,
       IconData iconBtnNo= Icons.cancel_outlined,

       String titleBtnSi = 'Aceptar',
       String titleBtnNo = 'Cancelar',
       required String descripcion,
       required Function() btnOkOnPress,Function()? btnCancelOnPress}) {

   if(isDiaslogoShow){
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
     titleTextStyle: TextStyle(color: colorTitle,fontWeight: FontWeight.bold,fontSize: 18),

     btnCancel: BtnIconWidget(
       colorBtn: colorBtnSi,
       icon: iconBtnSi,
       onPressed: (){
         isDiaslogoShow=false;
          Get.back();
          if(btnOkOnPress!=null){
            btnOkOnPress();
          }

       },
       titulo: titleBtnSi,
     ),

     btnOk:!mostrarSegungoBtn?null: BtnIconWidget(

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


 static getWarning(
     {String title = 'ADVERTENCIA',
       String titleBtnOk = 'Ok',
       required String descripcion,
       Function()? btnOkOnPress}) {

   return       DialogosAwesome._getIconPolicia(
     colorBtnSi: colorWarning,
     colorCircleImg: colorWarning,
     colorTitle: colorWarning,
     title: title,
     descripcion: descripcion,
     btnOkOnPress:  btnOkOnPress == null
         ? () {

     }:btnOkOnPress,
     titleBtnSi: "ACEPTAR",
     mostrarSegungoBtn: false,
   );

 }


 static getWarningSiNo(
     {String title = 'ADVERTENCIA',
       required String descripcion,
       Function()? btnOkOnPress,Function()? btnCancelOnPress}) {

   return       DialogosAwesome._getIconPolicia(
     colorBtnSi: colorInformacion,
     colorCircleImg: colorWarning,
     colorTitle: colorWarning,
     title: title,
     descripcion: descripcion,
     btnOkOnPress:  btnOkOnPress == null
         ? () {

     }:btnOkOnPress,
     titleBtnSi: "Si",
     mostrarSegungoBtn: true,
     titleBtnNo: "No",
     btnCancelOnPress: btnCancelOnPress == null
         ? () {

     }:btnCancelOnPress,
   );

 }



  static getError(
      {String title = 'ERROR',
        required String descripcion,
        Function()? btnOkOnPress}) {



    return       DialogosAwesome._getIconPolicia(
      colorBtnSi: colorError,
      colorCircleImg: colorError,
      colorTitle: colorError,
      title: title,
      descripcion: descripcion,
      btnOkOnPress:  btnOkOnPress == null
          ? () {

      }:btnOkOnPress,
      titleBtnSi: "ACEPTAR",
      mostrarSegungoBtn: false,
    );

  }

  static getSucess(
      {String title = 'ÉXITO',
        required String descripcion,
        Function()? btnOkOnPress}) {
    return       DialogosAwesome._getIconPolicia(
      colorBtnSi: colorSucess,
      colorCircleImg: colorSucess,
      colorTitle: colorSucess,
      title: title,
      descripcion: descripcion,
      btnOkOnPress:  btnOkOnPress == null
          ? () {

      }:btnOkOnPress,
      titleBtnSi: "ACEPTAR",
      mostrarSegungoBtn: false,
    );
  }



  static getInformation(
      {String title = 'INFORMACIÓN', required String descripcion,  Function()? btnOkOnPress,}) {


    return       DialogosAwesome._getIconPolicia(
      colorBtnSi: colorInformacion,
      colorCircleImg: colorInformacion,
      colorTitle: colorInformacion,
      title: title,
      descripcion: descripcion,
      btnOkOnPress:  btnOkOnPress == null
          ? () {

      }:btnOkOnPress,
      titleBtnSi: "Ok",
      mostrarSegungoBtn: false,
    );


  }



  static getInformationSiNo(
      {String title = 'INFORMACIÓN',
        required String descripcion,
        Function()? btnOkOnPress,
        Function()? btnCancelOnPress}) {

    return       DialogosAwesome._getIconPolicia(
      colorBtnSi: colorInformacion,
      colorCircleImg: colorInformacion,
      colorTitle: colorInformacion,
      title: title,
      descripcion: descripcion,
      btnOkOnPress:  btnOkOnPress == null
          ? () {

      }:btnOkOnPress,
      titleBtnNo: "No",
      titleBtnSi: "SI",
      mostrarSegungoBtn: true,
      btnCancelOnPress: btnCancelOnPress == null
          ? () {

      }:btnCancelOnPress,
    );
  }




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

}

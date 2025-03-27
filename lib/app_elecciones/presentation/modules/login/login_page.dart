part of '../pages.dart';

class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    Widget mobile = Obx(()=>WorkAreaPageLoginWidget(imgFondo: AppImages.imgFondoDefault1,
      mostrarBtnHome: controller.mostrarBtnHome.value,
      onPressedBtnHome: () {
        controller.setAppPageSelect(PageAppsSelect.Bienvenida);
      },
      title: "POLICÍA NACIONAL DEL ECUADOR",
      mostrarVersion: true,
      peticionServer: controller.peticionServerState,

      contenido: contenido(),
    ));
    return mobile;
    return GetBuilder<LoginController>(builder: (_c) => mobile);
  }

  contenido() {
    final responsive = ResponsiveUtil();
    return Column(
      children: [
        SizedBox(
          height: responsive.altoP(3),
        ),
       WgLogin(
          completeTutorial: (value) {
          //  controller.setShowTutorial(value);
          },
          onPressed: () => controller.login(),
          controllerPass: controller.controllerPass,
          controllerUser: controller.controllerUser,
          formKey: controller.formKey,
        ),

        SizedBox(
          height: responsive.altoP(2),
        ),
      ],
    );
  }
}

part of '../pages.dart';

class CensoPolicialPage extends GetView<CensoPolicialController> {
  const CensoPolicialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(
      namApps: NamApps.Censo,//se estable el name para que el mensaje del Gps cambie con base a la app
      mostrarBtnAtras: true,
      showGps: true,//indica que la app va a utilkizar el gps
      title: "CENSO POLICIAL",
      contenido:  getContenido(),
      peticionServer: controller.peticionServerState,
    );
  }

  Widget getContenido() {
    final responsive = ResponsiveUtil();

    return QrViewWidget(dataQrChange: (String dataQr) async {
      print("dataaaa");
      String idGenPersonaUser=controller.loginController.user.value.idGenPersona.toString();
      await controller.totpCensoController.verificarDataQr(dataQr, idGenPersonaUser: idGenPersonaUser);
    },);


  }

}

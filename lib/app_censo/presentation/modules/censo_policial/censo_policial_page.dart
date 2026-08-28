part of '../pages.dart';

class CensoPolicialPage extends GetView<CensoPolicialController> {
  const CensoPolicialPage({Key? key}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageCensoWidget(
      mostrarBtnAtras:true,
      showGps:true,
      title:"CENSO POLICIAL",
      contenido:getContenido(),
      peticionServer:controller.peticionServerState,
    );
  }

  Widget getContenido() {
    return Padding(
      padding:const EdgeInsets.fromLTRB(10,6,10,18),
      child:QrViewWidget(
        dataQrChange:(String dataQr) async {
          String idGenPersonaUser=controller.loginController.user.value.idGenPersona.toString();

          await controller.totpCensoController.verificarDataQr(
            dataQr,
            idGenPersonaUser:idGenPersonaUser,
          );
        },
      ),
    );
  }
}
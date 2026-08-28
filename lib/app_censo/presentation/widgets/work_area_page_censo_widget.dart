part of 'custom_app_censo_widgets.dart';

class WorkAreaPageCensoWidget extends StatelessWidget {
  final RxBool peticionServer;
  final Widget contenido;
  final VoidCallback? onPressBtnAtras;
  final bool showGps;
  final String? title;
  final double? tamanoTitulo;
  final imgPerfil;
  final imgFondo;
  final bool mostrarBtnAtras;
  final bool mostrarDatosServidor;
  final bool showBtnNotificacione;
  final String? nombresServidor;
  final String? sexoServidor;

  const WorkAreaPageCensoWidget({
    super.key,
    required this.peticionServer,
    required this.contenido,
    this.imgPerfil,
    this.imgFondo,
    this.title,
    this.tamanoTitulo,
    this.mostrarBtnAtras=false,
    this.onPressBtnAtras,
    this.showGps=false,
    this.mostrarDatosServidor=false,
    this.showBtnNotificacione=true,
    this.nombresServidor,
    this.sexoServidor,
  });

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(
      namApps:NamApps.Censo,
      peticionServer:peticionServer,
      contenido:contenido,
      imgPerfil:imgPerfil,
      imgFondo:imgFondo,
      title:title,
      tamanoTitulo:tamanoTitulo,
      mostrarBtnAtras:mostrarBtnAtras,
      onPressBtnAtras:onPressBtnAtras,
      showGps:showGps,
      mostrarDatosServidor:mostrarDatosServidor,
      showBtnNotificacione:showBtnNotificacione,
      nombresServidor:nombresServidor,
      sexoServidor:sexoServidor,
    );
  }
}
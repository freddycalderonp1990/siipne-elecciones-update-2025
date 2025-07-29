part of 'custom_app_censo_widgets.dart';

class WorkAreaPageCensoWidget extends StatelessWidget {
  final RxBool peticionServer;
  final Widget contenido;
  final VoidCallback? onPressBtnAtras;
  final bool showGps;
  final String? title;
  final imgPerfil;
  final imgFondo;
  final bool mostrarBtnAtras;

  const WorkAreaPageCensoWidget({
    required this.peticionServer,
    required this.contenido,
    this.imgPerfil = null,
    this.imgFondo,
    this.title,
    this.mostrarBtnAtras = false,
    this.onPressBtnAtras,
    this.showGps = false,
  });

  @override
  Widget build(BuildContext context) {
    return WorkAreaPageWidget(
      namApps: NamApps.Censo,//se estable el name para que el mensaje del Gps cambie con base a la app
      peticionServer: peticionServer,
      contenido: contenido,
      imgPerfil: imgPerfil,
      imgFondo: imgFondo,
      title: title,
      mostrarBtnAtras: mostrarBtnAtras,
      onPressBtnAtras: onPressBtnAtras,
      showGps: showGps,
    );
  }
}

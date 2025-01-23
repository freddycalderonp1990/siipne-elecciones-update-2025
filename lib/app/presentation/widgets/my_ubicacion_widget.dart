part of 'custom_app_widgets.dart';

class MyUbicacionWidget extends StatefulWidget {
  final FrameCallback? callback;

  final bool mostraUbicacion;

  const MyUbicacionWidget(
      {super.key, this.callback, this.mostraUbicacion = false, });

  @override
  State<MyUbicacionWidget> createState() => _MyUbicacionWidgetState();
}

typedef FrameCallback = void Function(Duration timeStamp);

class _MyUbicacionWidgetState extends State<MyUbicacionWidget> {
  final anchoContenedor = AppConfig.anchoContenedor;
  @override
  Widget build(BuildContext context) {
    return cabecera(context);
  }

  Widget cabecera(BuildContext context) {
    final responsive = ResponsiveUtil();

    return  BlocBuilder<LocationBloc, LocationState>(
            builder: (context, state) => getUbicacion(responsive, state));
  }

  Widget getUbicacion(ResponsiveUtil responsive, LocationState state) {


    if (state.lastKnownLocation == null)
      return ContenedorDesingWidget(

          anchoPorce: anchoContenedor,
          child:Center(child: Text('Obteniendo Ubicación...')));

    if (widget.callback != null) {
      WidgetsBinding.instance.addPostFrameCallback(widget.callback!);
    }

    return widget.mostraUbicacion
        ? ContenedorDesingWidget(

        anchoPorce: anchoContenedor,
        child:SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                Container(
                  width: responsive.anchoP(anchoContenedor),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Icon(
                          Icons.location_on_outlined,
                          color: Colors.red,
                          size: responsive.diagonalP(AppConfig.tamTextoTitulo),
                        ),
                      ),

                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Row(
                              children: [
                                Text(
                                  "Latitud: ",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: responsive.diagonalP(AppConfig.tamTexto)),
                                ),
                                Text(
                                    state.lastKnownLocation!.latitude.toString(),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: responsive.diagonalP(AppConfig.tamTexto),
                                    ))
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Longitud: ",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: responsive.diagonalP(AppConfig.tamTexto)),
                                ),
                                Text(
                                    state.lastKnownLocation!.longitude.toString(),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: responsive.diagonalP(AppConfig.tamTexto),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: responsive.anchoP(1),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: responsive.altoP(0.4),
                )
              ],
            ),
          ))
        : Container();
  }
}



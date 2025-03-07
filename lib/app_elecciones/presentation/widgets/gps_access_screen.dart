import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siipnelecciones3/app/core/utils/responsiveUtil.dart';
import 'package:siipnelecciones3/app/core/values/app_colors.dart';
import 'package:siipnelecciones3/app/presentation/blocs/calculadora/calculadora_bloc.dart';
import 'package:siipnelecciones3/app/presentation/blocs/location/location_bloc.dart';
import 'package:siipnelecciones3/app_elecciones/core/values/siipne_colors.dart';
import 'package:siipnelecciones3/app_elecciones/core/values/siipne_images.dart';
import 'package:siipnelecciones3/app_elecciones/presentation/widgets/customWidgets.dart';

import '../../../../app/presentation/blocs/gps/gps_bloc.dart';
import '../../../../app/presentation/widgets/custom_app_widgets.dart';
import '../../../app/presentation/blocs/location/location_bloc.dart';

class GpsAccessScreen extends StatelessWidget {
  final Widget contenido;


  const GpsAccessScreen({Key? key, required this.contenido}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GpsBloc, GpsState>(
      builder: (context, state) {
        if (state.isGpsEnabled && state.isGpsPermissionGranted) {
          final locationBloc = BlocProvider.of<LocationBloc>(context);
          locationBloc.getCurrentPosition();
          return BlocBuilder<LocationBloc, LocationState>(
              builder: (context, state) {

            if (state.lastKnownLocation == null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ContenedorDesingWidget(
                    paddin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text("Obteniendo Coordenadas Espere..."),
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                 // contenido
                ],
              );
            }

            //aqui ya tengo coordenadas lo que venga en la funcion se ejecuta

            return contenido;
          });
        }

        return !state.isGpsEnabled
            ? const _EnableGpsMessage()
            : const _AccessButton();
      },
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MensajePermisoGps(
      title: 'PERMISOS NECESARIOS',
      onPressed: () {
        final gpsBloc = BlocProvider.of<GpsBloc>(context);
        gpsBloc.askGpsAccess();
      },
    );
    ;
  }
}

class MensajePermisoGps extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  const MensajePermisoGps({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();




    return Container(
      margin: EdgeInsets.only(top: 50),


      width: responsive.ancho,
      child: ContenedorDesingWidget(
          margin: EdgeInsets.all(5),
          child: Container(
            margin: EdgeInsets.all(5),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TituloTextWidget(
                    textAlign: TextAlign.center,
                    title: title,
                  ),
                  TituloTextWidget(
                    textAlign: TextAlign.center,
                    title:
                        "La aplicación necesita acceder a tu ubicación para:",
                  ),
                  Image.asset(
                    SiipneImages.imgLocationAccess,
                    height: responsive.diagonalP(8),
                  ),
                  getWdMsjElecciones(),
                  SizedBox(
                    height: 5,
                  ),
                  onPressed != null
                      ? BtnIconWidget(

                          icon: Icons.navigate_next,

                          titulo: "Continuar",
                          onPressed: onPressed,
                        )
                      : Container()
                ],
              ),
            ),
          )),
    );
  }

  Widget getWdMsjElecciones() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TituloDetalleTextWidget(

          title: "1)",
          detalle: "Verificar los operativos abiertos cercanos a tu ubicación.",
        ),
        TituloDetalleTextWidget(
          title: "2)",
          detalle:
              "Mostrar los Recintos Electorales o Unidades Policiales según la ubicación donde te encuentres.",
        ),
        TituloDetalleTextWidget(
          title: "3)",
          detalle:
              "Registrar Novedades y Eventos en el lugar donde ocurrieron..",
        ),
      ],
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MensajePermisoGps(
      title: 'ACTIVE EL GPS',
    );
  }
}

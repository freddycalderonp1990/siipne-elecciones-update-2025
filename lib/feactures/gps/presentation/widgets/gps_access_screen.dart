import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/core/utils/responsiveUtil.dart';
import '../../../../app/core/values/app_images.dart';

import '../../../../app/domain/enums/enums.dart';
import '../../../../app/presentation/widgets/custom_app_widgets.dart';
import '../bloc/gps/gps_bloc.dart';
import '../location/location_bloc.dart';

class GpsAccessScreen extends StatelessWidget {
  final Widget contenido;
  final NamApps namApps;
  final bool useSafeArea;

  const GpsAccessScreen({
    Key? key,
    required this.contenido,
    required this.namApps,  this.useSafeArea=false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

Widget wg=BlocBuilder<GpsBloc, GpsState>(
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
                      CargandoWidget(
                        mostrar: true,
                        color: Colors.transparent,
                        titulo: "Obteniendo Coordenadas Espere",
                      ),
                    ],
                  ),
                ),
                // contenido
              ],
            );
          }

          //aqui ya tengo coordenadas lo que venga en la funcion se ejecuta

          return contenido;
        },
      );
    }

    return !state.isGpsEnabled
        ? _EnableGpsMessage(namApps: namApps)
        : _AccessButton(namApps: namApps);
  },
);

    if (useSafeArea) {
      return Scaffold(
        body: SafeArea(child: wg),
      );
    }
    return wg;


  }
}

class _AccessButton extends StatelessWidget {
  final NamApps namApps;
  const _AccessButton({Key? key, required this.namApps}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MensajePermisoGps(
      namApps: namApps,
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
  final NamApps namApps;

  const MensajePermisoGps({
    super.key,
    required this.title,
    this.onPressed,
    required this.namApps,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();

    return Container(
      margin: const EdgeInsets.only(top: 40),
      width: responsive.ancho,
      child: ContenedorDesingWidget(
        margin: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Icono superior
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.blue.shade50,
                child: const Icon(
                  Icons.location_on,
                  color: Color(0xffff0000),
                  size: 34,
                ),
              ),


              const SizedBox(height: 15),

              /// Título
              TituloTextWidget(textAlign: TextAlign.center, title: title),

              const SizedBox(height: 10),

              Text(
                "Necesitamos acceder a tu ubicación para utilizar todas las funciones de la aplicación.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: responsive.diagonalP(1.6),
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 25),
/*
              /// Imagen
              Image.asset(
                AppImages.imgLocationAccess,
                height: responsive.diagonalP(5),
              ),

              const SizedBox(height: 10),*/

              getMensajeGps(namApps),

              const SizedBox(height: 20),

              if (onPressed != null)
                SizedBox(
                  width: responsive.anchoP(72),
                  child: BtnIconWidget(
                    icon: Icons.navigate_next,
                    titulo: "Continuar",
                    onPressed: onPressed,
                  ),
                ),

              const SizedBox(height: 18),

              Divider(),

              const SizedBox(height: 12),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.shield_outlined, color: Colors.blue.shade700),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      "Tu ubicación está protegida.\nSolo será utilizada durante el proceso y no se compartirá con terceros.",
                      style: TextStyle(
                        fontSize: responsive.diagonalP(1.4),
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

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
                TituloTextWidget(textAlign: TextAlign.center, title: title),
                TituloTextWidget(
                  textAlign: TextAlign.center,
                  title: "La aplicación necesita acceder a tu ubicación para:",
                ),
                Image.asset(
                  AppImages.imgLocationAccess,
                  height: responsive.diagonalP(8),
                ),
                getMensajeGps(this.namApps),
                SizedBox(height: 5),
                onPressed != null
                    ? BtnIconWidget(
                        icon: Icons.navigate_next,

                        titulo: "Continuar",
                        onPressed: onPressed,
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getMensajeGps(NamApps namApps) {
    Widget wg = Container();
    switch (namApps) {
      case NamApps.Elecciones:
        wg = getWdMsjElecciones();
        break;
      case NamApps.Censo:
        wg = getWdMsjAppCenso();
        break;
      default:
        wg = Container();
    }

    return wg;
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

  Widget getWdMsjAppCenso() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TituloDetalleTextWidget(
          title: "1)",
          detalle: "Verificar los procesos de censo cercanos a tu ubicación.",
        ),
        TituloDetalleTextWidget(
          title: "2)",
          detalle: "Mostrar las mesas según la ubicación donde te encuentres.",
        ),
      ],
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  final NamApps namApps;

  const _EnableGpsMessage({Key? key, required this.namApps}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MensajePermisoGps(namApps: namApps, title: 'ACTIVE EL GPS');
  }
}

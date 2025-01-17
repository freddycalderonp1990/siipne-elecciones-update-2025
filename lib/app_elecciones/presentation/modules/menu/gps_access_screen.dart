import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siipnelecciones3/app/core/utils/responsiveUtil.dart';
import 'package:siipnelecciones3/app/presentation/blocs/calculadora/calculadora_bloc.dart';
import 'package:siipnelecciones3/app_elecciones/core/values/siipne_images.dart';

import '../../../../app/presentation/blocs/gps/gps_bloc.dart';
import '../../../../app/presentation/widgets/custom_app_widgets.dart';




class GpsAccessScreen extends StatelessWidget {

  const GpsAccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
          child: BlocBuilder<GpsBloc, GpsState>(
            builder: (context, state) {

              if(state.isGpsEnabled && state.isGpsPermissionGranted){
                return Text("Todo Listo");
              }

              return !state.isGpsEnabled
                  ? const _EnableGpsMessage()
                  : const _AccessButton();

            },
          )
        //  _AccessButton(),
        //  child: _EnableGpsMessage()

    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive=ResponsiveUtil();
    return ContenedorDesingWidget(
        margin: EdgeInsets.all(5),
        anchoPorce: 90,
        child: Container(
          margin: EdgeInsets.all(5),
          child: Column(
            children: [
              DetalleTextWidget(
                todoElAncho: true,
                detalle: "msj",
              ),
              SizedBox(
                height: 5,
              ),
              TituloTextWidget(
                textAlign: TextAlign.center,
                title:
                "La aplicación necesita acceder a tu ubicación para:",
              ),
              SizedBox(
                height: 10,
              ),
              getWdMsjElecciones(),
              Image.asset(
                SiipneImages.imgLocationAccess,
                height: responsive.diagonalP(15),
              ),
              SizedBox(
                height: responsive.altoP(4),
              ),

              BotonesWidget(
                iconData: Icons.navigate_next,
                padding: EdgeInsets.symmetric(horizontal: 10),
                title: "Continuar",
                onPressed: ()  {
                  final gpsBloc = BlocProvider.of<GpsBloc>(context);

                  final calculadoraBloc = BlocProvider.of<CalculadoraBloc>(context);


                 // gpsBloc.askGpsAccess();
                },
              )
            ],
          ),
        ));



  }

  Widget getWdMsjElecciones() {
    return Column(
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
    return const Text(
      'Debe de habilitar el GPS',
      style: TextStyle( fontSize: 25, fontWeight: FontWeight.w300 ),
    );
  }
}
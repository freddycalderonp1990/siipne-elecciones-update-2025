import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:siipnemovil2/app_censo/presentation/modules/censo_policial/local_widgets/text_animate.dart';


import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../../../../app/core/app_config.dart';
import '../../../../../../app/core/utils/responsiveUtil.dart';
import '../../../../../../app/core/values/app_colors.dart';
import '../../../../../../app/core/values/app_images.dart';
import '../../../../../../app/presentation/widgets/custom_app_widgets.dart';
import '../../../../../feactures/user/presentation/modules/controllers.dart';
import '../../../../domain/usecases/local_store_censo.dart';
import '../../totpCenso/totp_censo_controller.dart';


class DesingClaveDigitalCenso extends StatefulWidget  {
  const DesingClaveDigitalCenso(
      {super.key,
      required this.seconds,
      required this.valueRadio,
      required this.codigo,
      this.onPressedVincularcell});

  final int seconds;
  final double valueRadio;
  final String codigo;
  final VoidCallback? onPressedVincularcell;

  @override
  State<DesingClaveDigitalCenso> createState() => _DesingClaveDigitalCensoState();
}


class _DesingClaveDigitalCensoState extends State<DesingClaveDigitalCenso>
    with WidgetsBindingObserver {

  final TotpCensoController totpController = Get.find();
  final LocalStoreCensoUseCase _localStoreImpl = Get.find();
  final LoginController _loginController = Get.find();



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state)  {
    if (state == AppLifecycleState.paused) {
      // La aplicación está en segundo plano
      print('La aplicación está en segundo plano');
      totpController.claveAbierta=false;
      totpController.stopTimer();
      Get.back();
      // se estoy compartiendo Qr debo cerrar otra pantalla mas
      if(totpController.compartirQR){
        Get.back();
        totpController.compartirQR=false;
      }

    } else if (state == AppLifecycleState.resumed)  {

      // La aplicación ha vuelto a primer plano
      print('La aplicación ha vuelto a primer plano');
      //startCode();
    }
  }

  startCodeUnico() async {
    String codeUnico = await _localStoreImpl.getCodeUnicoCenso(
        _loginController.user.value.nombreUsuario);

    totpController.startTimer(codeUnico);
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();

    return OrientationBuilder(
      builder: (context, orientation) {
        if (responsive.isHorizontal()) {
          return getContenidoClaveDigitalHorizontal();
        } else {
          return getContenidoClaveDigitalVertical();
        }
      },
    );
  }

  Widget getContenidoClaveDigitalHorizontal() {
    final responsive = ResponsiveUtil();
    return Container(
      height: responsive.altoP(60),
      child: ContenedorDesingWidget(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Row(
              children: [
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(flex: 1, child: getTitleNoCompartas()),
                      Expanded(
                          flex: 3,
                          child: Container(
                            child: SingleChildScrollView(
                              child: getRecomendaciones(),
                            ),
                          ))
                    ],
                  ),
                ),
                Expanded(child: _buildRadialImageAnnotation())
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget getContenidoClaveDigitalVertical() {
    final responsive = ResponsiveUtil();
    return ContenedorDesingWidget(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Flexible(child: getTitleNoCompartas())],
          ),
          SizedBox(
            height: 10,
          ),

          _buildRadialImageAnnotation(),
          SizedBox(
            height: responsive.altoP(1),
          ),
          Container(
            color: AppColors.colorPlomo.withOpacity(0.3),
            child: SingleChildScrollView(
              child: getRecomendaciones(),
            ),
          ),
        ],
      ),
    );
  }

  copyCode() {
    return BtnIconWidget(
      onPressed: () {
        Clipboard.setData(ClipboardData(text: widget.codigo));
        showCopiedDialog(context);
      },
      icon: Icons.copy,
      titulo: "Copiar",
    );
  }



  Widget getText({required String title, required String detalle}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 10,
        ),
        Flexible(
            flex: 3,
            child: Text(
              detalle,
              style: TextStyle(fontSize: 9),
            ))
      ],
    );
  }

  void showCopiedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(milliseconds: 500), () {
          Navigator.of(context).pop(true); // Cierra el diálogo
        });

        return AlertDialog(
          title: Center(
            child: TituloTextWidget(title: 'Código copiado al portapapeles'),
          ),
        );
      },
    );
  }

  SfRadialGauge _buildRadialImageAnnotation() {
    Color color = AppColors.colorVerde_60;

    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
            interval: 5,
            radiusFactor: 0.90,
            startAngle: 0,
            endAngle: 360,
            showTicks: false,
            showLabels: false,
            axisLineStyle: const AxisLineStyle(thickness: 10),
            pointers: <GaugePointer>[
              RangePointer(
                  value: widget.valueRadio,
                  width: 12,
                  color: color,
                  enableAnimation: true,
                  gradient: SweepGradient(colors: <Color>[
                    color
                  ], stops: <double>[
                    0.10,
                  ]),
                  cornerStyle: CornerStyle.startCurve)
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  widget: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [desingContadorText()],
                  ),
                  angle: 360,
                  positionFactor: 0.1)
            ])
      ],
    );
  }

  Widget iconDetalle(String mensaje) {
    final responsive = ResponsiveUtil();
    return Column(

      children: [
        Row(

          children: [

            SizedBox(width: 10,),
           Container(
                width: responsive.diagonalP(AppConfig.tamIcons - 1),
                height: responsive.diagonalP(AppConfig.tamIcons - 1),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.colorAzul),
              ),
            SizedBox(width: 5,),
            Expanded(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  mainAxisAlignment: MainAxisAlignment.start,


                  children: [
                    Text(
                      mensaje,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontStyle: FontStyle.italic,

                          color: AppColors.colorAzul_80,

                          fontSize: responsive.diagonalP(AppConfig.tamTexto)),
                    ),
                    Container(
                      height: 1,
                      color: Colors.black12,
                    )
                  ],
                ))
          ],
        ),
        SizedBox(
          height: 5,
        )
      ],
    );
  }

  Widget desingContadorText() {
    String ceros = widget.seconds < 9 ? "00:0" : "00:";
    final responsive = ResponsiveUtil();

    Color colorSombra = AppColors.colorPlomo;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SelectableText(
          widget.codigo,
          style: TextStyle(
              shadows: [
                Shadow(
                  blurRadius: 2,
                  color: colorSombra,
                  offset: Offset(2, 2),
                ),
                Shadow(
                  blurRadius: 2,
                  color: colorSombra,
                  offset: Offset(-2, 2),
                ),
              ],
              fontWeight: FontWeight.bold,
              fontSize: responsive.diagonalP(AppConfig.tamTextoTitulo + 2),
              letterSpacing: 2,
              color: AppColors.colorAzul_80),
        ),

        // Added image widget as an annotation

        Container(
          height: 2,
          color: Colors.black26,
          width: responsive.diagonalP(15),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
          child: TextAnimate(seconds: widget.seconds),
        ),
      ],
    );
  }

  Widget getTitleNoCompartas() {
    final responsive = ResponsiveUtil();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.sd_card_alert,
          color: Colors.amberAccent,
          size: responsive.diagonalP(AppConfig.tamIcons),
        ),
        Flexible(
            child: TextSombrasWidget(
          colorTexto: AppColors.colorAzul_80,
          colorSombra: Colors.black12,
          title: "¡Comparte esta clave al censista!",
          size: responsive.diagonalP(AppConfig.tamTextoTitulo),
        ))
      ],
    );
  }

  Widget getRecomendaciones() {
    final responsive = ResponsiveUtil();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.message_sharp,
              color: AppColors.colorAzul_60,
            ),
            Text(
              "Recuerda:",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.colorAzul_60,
                  fontSize: responsive.diagonalP(AppConfig.tamTextoTitulo)),
            )
          ],
        ),
        SizedBox(
          height: responsive.altoP(1),
        ),
        iconDetalle("Se genera una clave nueva cada 30 segundos"),
        iconDetalle("Esta clave es válida para el censo"),
        iconDetalle("Se genera incluso sin conexión a internet."),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.help,
              color: AppColors.colorAzul_60,
            ),


            Text(
              "Ayuda",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.colorAzul_60,
                  fontSize: responsive.diagonalP(AppConfig.tamTextoTitulo)),
            )
          ],
        ),

      ],
    );
  }
}

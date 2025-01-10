import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/app_config.dart';

import '../../../../core/utils/responsiveUtil.dart';
import '../../../../core/values/app_colors.dart';
import '../../../widgets/custom_app_widgets.dart';


class DesingCodigosTemporalesWidget extends StatefulWidget {
  final double valueRadio;
  final int seconds;
  final String title;
  final String codigo;
  final GestureTapCallback? onTap;

  const DesingCodigosTemporalesWidget(
      {super.key,
      required this.valueRadio,
      required this.seconds,
      required this.title,
      required this.codigo,
      this.onTap});

  @override
  State<DesingCodigosTemporalesWidget> createState() =>
      _DesingCodigosTemporalesWidgetState();
}

class _DesingCodigosTemporalesWidgetState
    extends State<DesingCodigosTemporalesWidget> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        elevation: 2,
        child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: widget.onTap,
            // handle your onTap here
            child: ContenedorDesingWidget(
              anchoPorce: 90,
              paddin: EdgeInsets.all(2),
              child: desingCodigosTemporales(),
            )));
  }

  Widget desingCodigosTemporales() {
    final responsive = ResponsiveUtil();
    return Row(
      children: [
        Icon(
          Icons.app_blocking,
          color: AppColors.colorIcons,
          size: responsive.diagonalP(AppConfig.tamIcons),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: responsive.diagonalP(AppConfig.tamTexto)),
              ),
              Text(
                widget.codigo,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: responsive.diagonalP(AppConfig.tamTextoTitulo)),
              ),
            ],
          ),
        ),

      ],
    );
  }
}

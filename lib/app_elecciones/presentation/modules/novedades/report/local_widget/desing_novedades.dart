import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../../app/core/values/app_colors.dart';

import '../../../../../../app/core/utils/responsiveUtil.dart';
import '../../../../../../app/presentation/widgets/custom_app_widgets.dart';
import '../../../../../data/models/models.dart';


class DisingNovedades extends StatelessWidget {
  final int index;
  final NovedadesElectoralesDetalle data;
  final GestureTapCallback? onTap;
  const DisingNovedades({required this.index,required this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();
    
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  color: AppColors.colorBordecajas,
                  blurRadius: 1)
            ]),
        margin: EdgeInsets.symmetric(
            horizontal: 5, vertical: 5),
        child: Row(
          children: [
            SizedBox(
              width: responsive.altoP(1),
            ),
            Text(
              (index + 1).toString() + ".",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: responsive.anchoP(4),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: responsive.altoP(1),
            ),
           
            Expanded(child:  Column(
              children: [
                TituloDetalleTextWidget(
                  title: "Fecha:",
                  detalle: data.fechaNovedad,

                ),
                TituloDetalleTextWidget(
                  title: "Reporta:",
                  detalle: data.reporta,

                ),
                TituloDetalleTextWidget(
                  title: "Tipo:",
                  detalle: data.tipo,

                ),
                TituloDetalleTextWidget(

                  title: "Novedad:",
                  detalle: data.novedad,

                ),
              ],
            ))
          ],
        ));
  }
}

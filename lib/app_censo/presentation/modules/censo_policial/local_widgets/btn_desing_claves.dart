import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import ' ../../../../../../../../app/core/app_config.dart';

import '../../../../../../app/core/utils/responsiveUtil.dart';
import '../../../../../app/core/values/app_colors.dart';
import '../../../../../app/presentation/widgets/custom_app_widgets.dart';


class BtnDesingClaves extends StatelessWidget {
  const BtnDesingClaves({super.key, required this.title, this.icon, this.onTap});

  final String title;
  final IconData? icon;
  final GestureTapCallback? onTap;



  @override
  Widget build(BuildContext context) {
    return getDesingBtn(title: title,icon:icon);
  }

  Widget getDesingBtn({required String title, IconData? icon}){
    final responsive = ResponsiveUtil();
    return Material(
      color:  Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      elevation: 2,

      child:Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black, // Color del borde
                width: 1, // Ancho del borde
              ),

              borderRadius: BorderRadius.circular(AppConfig.radioBordecajas),
              boxShadow: [
                BoxShadow(
                  color: AppColors.colorAzul,
                )
              ]),

          height: responsive.diagonalP(10),

          child:  InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap:onTap,
              // handle your onTap here
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                      icon,color: Colors.white,size: responsive.diagonalP(AppConfig.tamIcons+2)),

                  TextSombrasWidget(title: title,
                    colorSombra: Colors.black38,
                    colorTexto: Colors.white,
                    size: responsive
                        .diagonalP(AppConfig.tamTexto),


                  ),

                ],))),
    );
  }
}

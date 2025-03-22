import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../../app/core/values/app_colors.dart';
import '../../../../../../app/core/values/app_images.dart';
import '../../../../../../app_elecciones/core/values/siipne_images.dart';

import '../../../../../../app/core/app_config.dart';
import '../../../../../../app/core/utils/responsiveUtil.dart';
import '../../../../widgets/customWidgets.dart';

class DisingPersonal extends StatelessWidget {
  final int index;
  final String nombrePersonal;
  final GestureTapCallback? onTap;
  const DisingPersonal({required this.index,required this.nombrePersonal, this.onTap});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();

    return Container(
        margin: EdgeInsets.all(2),
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(color: AppColors.colorBordecajas, blurRadius: 1)
            ]),
        child: Row(
          children: <Widget>[
            Text(
              (index ).toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: responsive.diagonalP(AppConfig.tamTexto), fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: responsive.altoP(1),
            ),
            Image.asset(
              SiipneImages.icon_agregar_personal,
              width: responsive.anchoP(5),
              height: responsive.anchoP(5),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Container(
                    child: Text(
                       nombrePersonal,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: responsive.diagonalP(AppConfig.tamTexto),
                      ),
                    )),
              ),
            ),
            onTap != null
                ? BtnIconWidget(
              colorIcon: Colors.red,
              colorBtn: Colors.transparent,
              icon: Icons.cancel,

              onPressed: onTap,

            )
                : Container()
          ],
        ));
  }
}

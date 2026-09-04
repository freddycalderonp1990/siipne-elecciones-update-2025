import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../app/core/values/app_colors.dart';

class CustomBtnMap extends StatelessWidget {
  final IconData icon;
  final GestureTapCallback? onTap;


  const CustomBtnMap({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return  getBtnCustomIcon(icon: icon);
  }


  Widget getBtnCustomIcon({
    GestureTapCallback? ontap,
    double size = 45,
    Color colorIcon = Colors.white,
    required IconData icon,
  }) {
    return CupertinoButton(
      borderRadius: BorderRadius.circular(20),
      padding: EdgeInsets.all(1),
      onPressed: ontap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.colorBotones, width: 0.5),
            color: Colors.white10,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Container(
            child:
            size > 38
                ? Icon(icon, color: colorIcon, size: size - 20)
                : Container(),
            margin: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: AppColors.colorBotones,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
      ),
    );
  }
}

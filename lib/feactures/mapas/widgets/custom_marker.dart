import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:siipnemovil2/app/core/values/app_colors.dart';



class CustomMarker extends StatelessWidget {
  final GestureTapCallback? onTap;

  final Color colorIcon;
  final IconData icon;
  final String? label;

  const CustomMarker({
    super.key,
    this.onTap,

    this.colorIcon = Colors.white,
    required this.icon,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    // 👇 Escala base (ajústalo a tu gusto)
    final double size =  70;
    final double fontSize = 14;
    final double labelWidth = 15;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
              color: AppColors.colorBotones,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: colorIcon,
              size: size * 0.5,
            ),
          ),
        ),

        if (label != null) ...[
          SizedBox(height:  1),

          SizedBox(
            width: labelWidth,
            child: Text(
              label!,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: fontSize, // 👈 escala con zoom
                color: Colors.white,
                backgroundColor: Colors.black87,
              ),
            ),
          ),
        ]
      ],
    );
  }
}
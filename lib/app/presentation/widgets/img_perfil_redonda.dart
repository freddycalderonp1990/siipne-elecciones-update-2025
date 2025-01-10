import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../app_elecciones/core/utils/photo_helper.dart';
import '../../core/utils/responsiveUtil.dart';
import '../../core/values/app_colors.dart';
import '../../core/values/app_images.dart';



class imgPerfilRedonda extends StatefulWidget {
  final double size;

  final img;

  const imgPerfilRedonda({Key? key, this.size = 22, this.img})
      : super(key: key);

  @override
  _imgPerfilRedondaState createState() => _imgPerfilRedondaState();
}

class _imgPerfilRedondaState extends State<imgPerfilRedonda> {
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();
    var imgMemory = null;
    if (widget.img != null) {
      imgMemory = PhotoHelper.convertStringToUint8List(widget.img);
    }

    return widget.img != null
        ? Container(
      width: responsive.isVertical()
          ? responsive.anchoP(widget.size)
          : responsive.anchoP(widget.size - 8),
      height: responsive.isVertical()
          ? responsive.anchoP(widget.size)
          : responsive.anchoP(widget.size - 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.colorPlomo_80,
          style: BorderStyle.solid,
          width: 3,
        ),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(1000.0),
      ),
      child: imgMemory != null
          ? Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: Image.memory(imgMemory).image,
              fit: BoxFit.fill),
        ),
      )
          : ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(60.0)),
        child: Image.asset(
          AppImages.iconNoImg,
        ),
      ),
    )
        : Container();
  }
}

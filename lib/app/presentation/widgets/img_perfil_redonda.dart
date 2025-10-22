import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../../core/utils/photo_helper.dart';
import '../../core/utils/responsiveUtil.dart';
import '../../core/values/app_colors.dart';
import '../../core/values/app_images.dart';


class ImgPerfilRedonda extends StatefulWidget {
  final double size;
  final dynamic img;
  final bool mostrarBorde;
  final bool mostrarSombra;
  final VoidCallback? onTap;

  const ImgPerfilRedonda({
    Key? key,
    this.size = 22,
    this.img,
    this.mostrarBorde = true,
    this.mostrarSombra = true,
    this.onTap,
  }) : super(key: key);

  @override
  State<ImgPerfilRedonda> createState() => _ImgPerfilRedondaState();
}

class _ImgPerfilRedondaState extends State<ImgPerfilRedonda>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();
    final imgMemory = widget.img != null
        ? PhotoHelper.convertStringToUint8List(widget.img)
        : null;

    final size = responsive.isVertical()
        ? responsive.anchoP(widget.size)
        : responsive.anchoP(widget.size - 6);

    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.95),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 130),
        curve: Curves.easeOut,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [AppColors.colorAzul_60, AppColors.colorAzul_10],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: widget.mostrarSombra
                ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 2,
                offset: const Offset(0, 5),
              ),
            ]
                : [],
          ),
          padding: const EdgeInsets.all(3),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: widget.mostrarBorde
                  ? Border.all(
                color: Colors.white,
                width: 1,
              )
                  : null,
              image: DecorationImage(
                image: imgMemory != null
                    ? Image.memory(imgMemory).image
                    : AssetImage(AppImages.iconNoImg),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
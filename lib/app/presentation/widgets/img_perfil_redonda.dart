import 'dart:typed_data';

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

class _ImgPerfilRedondaState extends State<ImgPerfilRedonda> {
  double _scale = 1.0;

  Uint8List? _imgBytes;
  ImageProvider? _imageProvider;

  @override
  void initState() {
    super.initState();
    _actualizarImagen();
  }

  @override
  void didUpdateWidget(covariant ImgPerfilRedonda oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Solo procesa nuevamente si la imagen cambió
    if (oldWidget.img != widget.img) {
      _actualizarImagen();
    }
  }

  void _actualizarImagen() {
    if (widget.img != null && widget.img.toString().isNotEmpty) {
      _imgBytes = PhotoHelper.convertStringToUint8List(widget.img);

      if (_imgBytes != null) {
        _imageProvider = MemoryImage(_imgBytes!);
      } else {
        _imageProvider = const AssetImage(AppImages.iconNoImg);
      }
    } else {
      _imgBytes = null;
      _imageProvider = const AssetImage(AppImages.iconNoImg);
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();

    final double size = responsive.isVertical()
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
              colors: [
                AppColors.colorAzul_60,
                AppColors.colorAzul_10,
              ],
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
                image: _imageProvider!,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
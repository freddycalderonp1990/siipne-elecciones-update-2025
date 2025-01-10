import 'package:flutter/material.dart';
import 'package:siipnelecciones3/app/core/app_config.dart';
import 'package:siipnelecciones3/app/core/utils/responsiveUtil.dart';
import 'package:siipnelecciones3/app/core/values/app_colors.dart';
import 'package:siipnelecciones3/app/presentation/widgets/custom_app_widgets.dart';

import '../../../../../app_elecciones/core/siipne_config.dart';

class LoadingSplash extends StatefulWidget {
  @override
  _LoadingSplashState createState() => _LoadingSplashState();
}

class _LoadingSplashState extends State<LoadingSplash>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.scale(
                scale: 1.0 +
                    _animation.value *
                        0.5, // Ajusta el factor de zoom según lo deseado
                child: TextSombrasWidget(
                  title: "Cargando...",
                  size: responsive.diagonalP(AppConfig.tamTextoTitulo ),
                ),
              );
            },
          ),
          SizedBox(height: 10),
          CircularProgressIndicator(
            color: AppColors.colorAzul_1,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

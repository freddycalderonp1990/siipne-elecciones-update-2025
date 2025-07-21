import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../app/core/app_config.dart';
import '../../../../../../app/core/utils/responsiveUtil.dart';
import '../../../../../../app/core/values/app_colors.dart';

class TextAnimate extends StatefulWidget {

  final int seconds;


  const TextAnimate({super.key, required this.seconds});

  @override
  State<TextAnimate> createState() => _TextAnimateState();
}

class _TextAnimateState extends State<TextAnimate> with SingleTickerProviderStateMixin  {

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color color;
    bool shouldAnimate = false;

    if (widget.seconds <= 5) {
      color = Colors.red;
      shouldAnimate = true;
    } else if (widget.seconds <= 10) {
      color = Colors.orange;
      shouldAnimate = true;
    } else {
      color = AppColors.colorAzul;
    }



    String ceros = widget.seconds < 10 ? "00:0" : "00:";
    final responsive = ResponsiveUtil();

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: shouldAnimate ? _animation.value : 1.0,
          child:

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                color: color,
                Icons.history_rounded,
                size: responsive.diagonalP(AppConfig.tamIcons),
              ),

          Text("Expira en " + ceros + widget.seconds.toString(),
              style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: responsive.diagonalP(AppConfig.tamTexto))),
        ],)


        );
      },
    );
  }
}

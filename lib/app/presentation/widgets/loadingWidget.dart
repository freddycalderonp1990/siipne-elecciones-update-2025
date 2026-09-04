part of 'custom_app_widgets.dart';

class Loading extends StatefulWidget {
  final double radius;
  final double dotRadius;

  Loading({
    this.radius = 30.0,
    this.dotRadius = 3.0,
  });

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 2200),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    final double size = widget.radius * 3.8;
    final Color azul = AppColors.colorAzul_1;
    final Color plomo = AppColors.colorPlomo;

    return SizedBox(
      width: size,
      height: size,
      child: AnimatedBuilder(
        animation: controller,
        builder: (_, __) {
          final double pulse =
              .96 + (sin(controller.value * 2 * pi) * .04);

          return Stack(
            alignment: Alignment.center,
            children: [
              Transform.scale(
                scale: pulse,
                child: Container(
                  width: size * .82,
                  height: size * .82,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: azul.withOpacity(.20),
                        blurRadius: 32,
                        spreadRadius: 7,
                      ),
                    ],
                  ),
                ),
              ),

              Transform.rotate(
                angle: controller.value * 2 * pi,
                child: CustomPaint(
                  size: Size(size, size),
                  painter: _HologramRingPainter(
                    color: azul,
                    secondaryColor: plomo,
                  ),
                ),
              ),

              Transform.rotate(
                angle: -controller.value * 2 * pi,
                child: CustomPaint(
                  size: Size(size * .78, size * .78),
                  painter: _HologramInnerPainter(
                    color: azul,
                  ),
                ),
              ),

              Transform.rotate(
                angle: controller.value * 2 * pi,
                child: SizedBox(
                  width: size * .64,
                  height: size * .64,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: (size * .64 / 2) - (widget.dotRadius / 2),
                        child: Dot(
                          radius: widget.dotRadius,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Transform.scale(
                scale: pulse,
                child: Container(
                  width: widget.radius * 2.25,
                  height: widget.radius * 2.25,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.white.withOpacity(.98),
                        Colors.white.withOpacity(.92),
                        azul.withOpacity(.15),
                      ],
                    ),
                    border: Border.all(
                      color: Colors.white.withOpacity(.80),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: azul.withOpacity(.55),
                        blurRadius: 25,
                        spreadRadius: 2,
                      ),
                      BoxShadow(
                        color: Colors.white.withOpacity(.20),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    AppImages.escudopolicia,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              Container(
                width: widget.radius * 2.75,
                height: widget.radius * 2.75,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(.10),
                    width: .8,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;

  Dot({
    required this.radius,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(.80),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
    );
  }
}

class _HologramRingPainter extends CustomPainter {
  final Color color;
  final Color secondaryColor;

  _HologramRingPainter({
    required this.color,
    required this.secondaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final r1 = size.width * .31;
    final r2 = size.width * .43;

    final base = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = secondaryColor.withOpacity(.15);

    final glow = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        colors: [
          Colors.transparent,
          color.withOpacity(.08),
          color.withOpacity(.30),
          Colors.white.withOpacity(.95),
          color.withOpacity(.90),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(
          center: center,
          radius: r2,
        ),
      );

    final thin = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round
      ..color = color.withOpacity(.60);

    canvas.drawCircle(center, r1, base);
    canvas.drawCircle(center, r2, base);

    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: r2,
      ),
      -pi / 2,
      pi * 1.35,
      false,
      glow,
    );

    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: r1,
      ),
      pi / 3,
      pi * .85,
      false,
      thin,
    );

    for (int i = 0; i < 8; i++) {
      final angle = i * pi / 4;

      final p1 = Offset(
        center.dx + (r1 - 4) * cos(angle),
        center.dy + (r1 - 4) * sin(angle),
      );

      final p2 = Offset(
        center.dx + (r2 + 3) * cos(angle),
        center.dy + (r2 + 3) * sin(angle),
      );

      canvas.drawLine(
        p1,
        p2,
        thin,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _HologramRingPainter oldDelegate) {
    return true;
  }
}

class _HologramInnerPainter extends CustomPainter {
  final Color color;

  _HologramInnerPainter({
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width * .46;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round
      ..color = color.withOpacity(.45);

    for (int i = 0; i < 4; i++) {
      canvas.drawArc(
        Rect.fromCircle(
          center: center,
          radius: radius - (i * 3),
        ),
        (pi / 2) * i,
        pi / 5,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _HologramInnerPainter oldDelegate) {
    return true;
  }
}
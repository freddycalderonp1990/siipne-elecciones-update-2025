part of 'custom_app_widgets.dart';

class BotonesWidget extends StatefulWidget {
  final String title;
  final VoidCallback? onPressed;
  final IconData? iconData;
  final EdgeInsetsGeometry? padding;

  const BotonesWidget({
    this.onPressed,
    this.title = '',
    this.iconData,
    this.padding,
  });

  @override
  _BotonesWidgetState createState() => _BotonesWidgetState();
}

class _BotonesWidgetState extends State<BotonesWidget> {
  bool _presionado = false;

  @override
  Widget build(BuildContext context) {
    final bool habilitado = widget.onPressed != null;

    return AnimatedScale(
      scale: _presionado && habilitado ? .985 : 1,
      duration: const Duration(milliseconds: 110),
      curve: Curves.easeOut,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: habilitado
              ? [
            BoxShadow(
              color: AppColors.colorAzul_1.withOpacity(
                _presionado ? .14 : .24,
              ),
              blurRadius: _presionado ? 10 : 18,
              spreadRadius: 0,
              offset: Offset(
                0,
                _presionado ? 4 : 8,
              ),
            ),
          ]
              : [],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: widget.onPressed,
            onHighlightChanged: (value) {
              if (!habilitado) return;

              setState(() {
                _presionado = value;
              });
            },
            splashColor: Colors.white.withOpacity(.12),
            highlightColor: Colors.white.withOpacity(.05),
            child: Ink(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: habilitado
                    ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.colorAzul_1,
                    AppColors.colorAzul,
                  ],
                )
                    : const LinearGradient(
                  colors: [
                    Color(0xFFD4D9DE),
                    Color(0xFFBDC4CB),
                  ],
                ),
                border: Border.all(
                  color: habilitado
                      ? Colors.white.withOpacity(.14)
                      : const Color(0xFFB5BDC5),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: widget.padding ??
                    const EdgeInsets.symmetric(
                      horizontal: 18,
                    ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    /*
                     * Brillo superior muy sutil.
                     */
                    Positioned(
                      top: 0,
                      left: 15,
                      right: 15,
                      child: Container(
                        height: 1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.white.withOpacity(.30),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.iconData != null)
                          Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(
                                habilitado ? .12 : .08,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white.withOpacity(.10),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              widget.iconData,
                              color: habilitado
                                  ? Colors.white
                                  : const Color(0xFFF2F4F6),
                              size: 20,
                            ),
                          ),

                        if (widget.iconData != null &&
                            widget.title != '')
                          const SizedBox(width: 11),

                        if (widget.title != '')
                          Flexible(
                            child: Text(
                              widget.title,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: habilitado
                                    ? Colors.white
                                    : const Color(0xFFF4F5F6),
                                fontSize: 13,
                                height: 1,
                                fontWeight: FontWeight.w800,
                                letterSpacing: .8,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
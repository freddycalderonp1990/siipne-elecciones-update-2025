part of 'customWidgets.dart';

class BtnMenuWidget extends StatefulWidget {
  final String? img;
  final String title;
  final String? descripcion;
  final GestureTapCallback? onTap;
  final bool horizontal;
  final Color colorTexto;
  final Color colorFondo;
  final List<Color>? colorCirculoIcon;

  const BtnMenuWidget({
    this.img,
    this.title = '',
    this.descripcion,
    this.onTap,
    this.horizontal = false,
    this.colorTexto = Colors.black,
    this.colorFondo = Colors.white,
    this.colorCirculoIcon,
    Key? key,
  }) : super(key: key);

  @override
  _BtnMenuWidgetState createState() => _BtnMenuWidgetState();
}

class _BtnMenuWidgetState extends State<BtnMenuWidget>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();
    final fontSize = responsive.diagonalP(AppConfig.tamTexto - 0.2);

    Widget horizontal = _buildDesign(
      wg: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildIcon(responsive.anchoP(14), widget.colorCirculoIcon),
          SizedBox(width: responsive.altoP(1)),
          Expanded(
            child: Text(
              widget.title.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: widget.colorTexto,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ],
      ),
    );

    Widget vertical = _buildDesign(
      wg: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildIcon(responsive.anchoP(14),widget.colorCirculoIcon),
          SizedBox(height: responsive.altoP(1)),
          Text(
            widget.title.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: widget.colorTexto,
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );

    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.97),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: widget.horizontal ? horizontal : vertical,
      ),
    );
  }

  // --- DISEÑO PRINCIPAL ---
  Widget _buildDesign({required Widget wg}) {
    final responsive = ResponsiveUtil();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConfig.radioBordecajas),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: widget.colorFondo,
        borderRadius: BorderRadius.circular(20),
        elevation: 0,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          splashColor: AppColors.colorAzulTitle.withOpacity(0.2),
          highlightColor: Colors.transparent,
          onTap: widget.onTap,
          child: Container(
            width: responsive.anchoP(70),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: wg,
          ),
        ),
      ),
    );
  }

  // --- ÍCONO REDONDEADO CON EFECTO ---
  Widget _buildIcon(double size, List< Color>? color) {
    if(color==null){
      color=[const Color(0xFF0A3D7E) ,const Color(0xFF0A3D7E)];
    }
    //color=[Colors.transparent,Colors.transparent];
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: color,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

      ),
      padding: const EdgeInsets.all(3),
      child: ClipOval(
        child: widget.img != null
            ? Image.asset(widget.img!, fit: BoxFit.contain)
            : Image.asset(
          SiipneEleccionesImages.iconNoImg,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

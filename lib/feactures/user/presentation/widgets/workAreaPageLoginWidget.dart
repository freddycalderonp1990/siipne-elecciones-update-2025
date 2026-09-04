part of 'user_custom_widgets.dart';

class WorkAreaPageLoginWidget extends StatefulWidget {
  final RxBool peticionServer;
  final Widget contenido;
  final String title;
  final imgPerfil;
  final imgFondo;
  final bool mostrarVersion;
  final bool mostrarBtnHome;
  final VoidCallback? onPressedBtnHome;

  const WorkAreaPageLoginWidget({
    required this.peticionServer,
    required this.contenido,
    this.imgPerfil = null,
    this.imgFondo,
    this.mostrarVersion = false,
    this.title = '',
    this.mostrarBtnHome = false,
    this.onPressedBtnHome,
  });

  @override
  _WorkAreaPageLoginWidgetState createState() => _WorkAreaPageLoginWidgetState();
}

class _WorkAreaPageLoginWidgetState extends State<WorkAreaPageLoginWidget> {
  String version = '';
  String namePhone = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    String _version = await DeviceInfoApp.getVersionCodeNameApp;
    String _namePhone = await DeviceInfoApp.getDeviceMarca;
    _namePhone = "$_namePhone ${await DeviceInfoApp.getNameDevice}";
    _namePhone = "";

    if (!mounted) return;

    setState(() {
      version = _version;
      namePhone = _namePhone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (_, __) => getDersingPage(),
    );
  }

  Widget getDersingPage() {
    final media = MediaQuery.of(context);
    final keyboardOpen = media.viewInsets.bottom > 0;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Stack(
          fit: StackFit.expand,
          children: [
            getImgFondo(),

            /*
             * Overlay mínimo.
             * El fondo institucional sigue siendo visible.
             */
            Positioned.fill(
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(.02),
                        Colors.white.withOpacity(.05),
                        Colors.white.withOpacity(.12),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    physics: const ClampingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(
                      20,
                      widget.mostrarBtnHome ? 64 : 24,
                      20,
                      keyboardOpen ? 12 : 18,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight - (widget.mostrarBtnHome ? 82 : 42),
                      ),
                      child: Column(
                        mainAxisAlignment: keyboardOpen
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.center,
                        children: [
                          if (!keyboardOpen) ...[
                            _encabezadoInstitucional(),
                            const SizedBox(height: 22),
                          ],

                          Container(
                            width: double.infinity,
                            constraints: const BoxConstraints(
                              maxWidth: 410,
                            ),
                            child: widget.contenido,
                          ),

                          if (!keyboardOpen) ...[
                            const SizedBox(height: 18),
                            getVersion(),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            if (widget.mostrarBtnHome) getBtnHome(),

            Obx(
                  () => CargandoWidget(
                mostrar: widget.peticionServer.value,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _encabezadoInstitucional() {
    if (widget.title == '') return const SizedBox.shrink();

    return Container(
      constraints: const BoxConstraints(maxWidth: 410),
      child: Column(
        children: [
          if (widget.imgPerfil != null) ...[
            getImgPerfil(),
            const SizedBox(height: 12),
          ],

          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.colorAzul_1,
              fontSize: 17,
              fontWeight: FontWeight.w800,
              letterSpacing: .3,
              height: 1.2,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'Sistema Integrado de Información de la Policía Nacional',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF5D6975),
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget getBtnHome() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      right: 14,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onPressedBtnHome,
          borderRadius: BorderRadius.circular(12),
          child: Ink(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 13),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.94),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.colorAzul_1.withOpacity(.12),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF001D3D).withOpacity(.09),
                  blurRadius: 14,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.home_outlined,
                  color: AppColors.colorAzul_1,
                  size: 19,
                ),
                const SizedBox(width: 6),
                Text(
                  'Inicio',
                  style: TextStyle(
                    color: AppColors.colorAzul_1,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getImgFondo() {
    return Positioned.fill(
      child: Image.asset(
        widget.imgFondo == null ? AppImages.imgFondoDefault : widget.imgFondo,
        fit: BoxFit.cover,
        alignment: Alignment.center,
      ),
    );
  }

  Widget getVersion() {
    if (!widget.mostrarVersion) return const SizedBox.shrink();

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.92),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: const Color(0xFFE2E7EC),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.phone_android_rounded,
                size: 13,
                color: AppColors.colorAzul_1,
              ),
              const SizedBox(width: 6),
              Text(
                version,
                style: const TextStyle(
                  color: Color(0xFF5E6974),
                  fontSize: 9.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 7),
        Text(
          'POLICÍA NACIONAL DEL ECUADOR',
          style: TextStyle(
            color: AppColors.colorAzul_1.withOpacity(.60),
            fontSize: 8,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget getImgPerfil() {
    final responsive = ResponsiveUtil();

    if (widget.imgPerfil == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(
          color: AppColors.colorAzul_1.withOpacity(.10),
        ),
      ),
      child: ImgPerfilRedonda(
        size: responsive.diagonalP(AppConfig.tamIcons),
        img: widget.imgPerfil,
      ),
    );
  }
}

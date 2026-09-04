part of '../pages.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) =>
      _LoginFullScreen(controller: controller);
}

class _LoginFullScreen extends StatefulWidget {
  final LoginController controller;
  const _LoginFullScreen({Key? key, required this.controller})
    : super(key: key);
  @override
  State<_LoginFullScreen> createState() => _LoginFullScreenState();
}

class _LoginFullScreenState extends State<_LoginFullScreen> {
  final FocusNode _focusUsuario = FocusNode();
  final FocusNode _focusClave = FocusNode();
  bool _mostrarClave = false;
  bool _usuarioFocus = false;
  bool _claveFocus = false;
  bool _presionando = false;
  String version = '';

  @override
  void initState() {
    super.initState();
    _focusUsuario.addListener(() {
      if (!mounted) return;
      setState(() => _usuarioFocus = _focusUsuario.hasFocus);
    });
    _focusClave.addListener(() {
      if (!mounted) return;
      setState(() => _claveFocus = _focusClave.hasFocus);
    });
    _cargarVersion();
  }

  Future<void> _cargarVersion() async {
    final String _version = await DeviceInfoApp.getVersionCodeNameApp;
    if (!mounted) return;
    setState(() => version = _version);
  }

  @override
  void dispose() {
    _focusUsuario.dispose();
    _focusClave.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final bool teclado = media.viewInsets.bottom > 0;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFF5F7FA),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _imagenInstitucional(),
            _veloFondo(),
            _detallesTecnologicos(),
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  physics: const ClampingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(
                    20,
                    teclado ? 10 : 18,
                    20,
                    14 + media.padding.bottom,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight:
                          constraints.maxHeight - 32 - media.padding.bottom,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 220),
                          child: teclado
                              ? _cabeceraCompacta()
                              : _cabeceraPrincipal(),
                        ),
                        SizedBox(height: teclado ? 12 : 24),
                        Container(
                          width: double.infinity,
                          constraints: const BoxConstraints(maxWidth: 430),
                          child: _panelLogin(teclado),
                        ),
                        if (!teclado) ...[
                          const SizedBox(height: 22),
                          _piePantalla(),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Obx(
              () => widget.controller.mostrarBtnHome.value
                  ? _botonHome()
                  : const SizedBox.shrink(),
            ),
            Obx(
              () => CargandoWidget(
                mostrar: widget.controller.peticionServerState.value,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imagenInstitucional() {
    return Positioned.fill(
      child: Image.asset(
        AppImages.imgFondoDefault,
        fit: BoxFit.cover,
        alignment: Alignment.center,
      ),
    );
  }

  Widget _veloFondo() {
    return Positioned.fill(
      child: IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withOpacity(.03),
                Colors.white.withOpacity(.08),
                const Color(0xFFF5F7FA).withOpacity(.10),
              ],
              stops: const [0, .55, 1],
            ),
          ),
        ),
      ),
    );
  }

  Widget _detallesTecnologicos() {
    return Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          children: [
            Positioned(
              top: 90,
              left: -80,
              child: Container(
                width: 230,
                height: 230,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF195496).withOpacity(.07),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 80,
              right: -100,
              child: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF195496).withOpacity(.08),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cabeceraPrincipal() {
    return Container(
      key: const ValueKey('cabeceraPrincipal'),
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 430),
      child: Column(
        children: [
          Container(
            width: 92,
            height: 92,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.92),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: const Color(0xFF195496).withOpacity(.14),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF195496).withOpacity(.12),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Image.asset(AppImages.escudopolicia, fit: BoxFit.contain),
          ),
          const SizedBox(height: 15),
          const Text(
            'POLICÍA NACIONAL DEL ECUADOR',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF17365D),
              fontSize: 20,
              fontWeight: FontWeight.w800,
              letterSpacing: .5,
              height: 1.05,
            ),
          ),
          const SizedBox(height: 9),
          Container(
            width: 52,
            height: 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              gradient: const LinearGradient(
                colors: [Color(0xFF195496), Color(0xFF4F83C2)],
              ),
            ),
          ),
          const SizedBox(height: 7),
          Text(
            'Sistema Informático Integrado de la Policía Nacional del Ecuador',
            style: TextStyle(
              color: const Color(0xFF66798F).withOpacity(.85),
              fontSize: 9.5,
              fontWeight: FontWeight.w600,
              letterSpacing: .7,
            ),
          ),
        ],
      ),
    );
  }

  Widget _cabeceraCompacta() {
    return Container(
      key: const ValueKey('cabeceraCompacta'),
      height: 46,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 42,
            height: 42,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.92),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF195496).withOpacity(.12),
              ),
            ),
            child: Image.asset(AppImages.escudopolicia, fit: BoxFit.contain),
          ),
          const SizedBox(width: 10),
          const Text(
            'POLICÍA NACIONAL',
            style: TextStyle(
              color: Color(0xFF17365D),
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: .6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _panelLogin(bool teclado) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          padding: EdgeInsets.fromLTRB(
            22,
            teclado ? 18 : 22,
            22,
            teclado ? 17 : 21,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.88),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withOpacity(.95),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF17365D).withOpacity(.13),
                blurRadius: 30,
                offset: const Offset(0, 12),
              ),
              BoxShadow(
                color: Colors.white.withOpacity(.80),
                blurRadius: 2,
                offset: const Offset(0, -1),
              ),
            ],
          ),
          child: AutofillGroup(
            child: Form(
              key: widget.controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _cabeceraFormulario(),
                  SizedBox(height: teclado ? 17 : 22),
                  _labelCampo('Usuario', Icons.person_outline_rounded),
                  const SizedBox(height: 7),
                  _campoUsuario(),
                  const SizedBox(height: 15),
                  _labelCampo('Contraseña', Icons.lock_outline_rounded),
                  const SizedBox(height: 7),
                  _campoClave(),
                  const SizedBox(height: 2),
                  _recuperar(),
                  const SizedBox(height: 11),
                  _botonIngresar(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _cabeceraFormulario() {
    return Row(
      children: [
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: const Color(0xFF195496).withOpacity(.08),
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: const Color(0xFF195496).withOpacity(.12)),
          ),
          child: const Icon(
            Icons.shield_outlined,
            color: Color(0xFF195496),
            size: 23,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Bienvenido',
                style: TextStyle(
                  color: Color(0xFF17365D),
                  fontSize: 19,
                  height: 1.05,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Ingrese sus credenciales institucionales',
                style: TextStyle(
                  color: const Color(0xFF52677E).withOpacity(.85),
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _labelCampo(String titulo, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF195496), size: 15),
        const SizedBox(width: 7),
        Text(
          titulo,
          style: const TextStyle(
            color: Color(0xFF34495E),
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _campoUsuario() {
    return TextFormField(
      controller: widget.controller.controllerUser,
      focusNode: _focusUsuario,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.username],
      cursorColor: const Color(0xFF195496),
      cursorWidth: 2,
      cursorHeight: 21,
      style: const TextStyle(
        color: Color(0xFF172A3D),
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      decoration: _decoracionCampo(
        activo: _usuarioFocus,
        hint: 'Ingrese su usuario',
        icon: Icons.badge_outlined,
      ),
      validator: (text) {
        if (text != null && text.length >= 10) return null;
        return 'Usuario no válido';
      },
      onFieldSubmitted: (_) => _focusClave.requestFocus(),
    );
  }

  Widget _campoClave() {
    return TextFormField(
      controller: widget.controller.controllerPass,
      focusNode: _focusClave,
      obscureText: !_mostrarClave,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      autofillHints: const [AutofillHints.password],
      cursorColor: const Color(0xFF195496),
      cursorWidth: 2,
      cursorHeight: 21,
      style: const TextStyle(
        color: Color(0xFF172A3D),
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      decoration: _decoracionCampo(
        activo: _claveFocus,
        hint: 'Ingrese su contraseña',
        icon: Icons.key_rounded,
        suffix: IconButton(
          tooltip: _mostrarClave ? 'Ocultar contraseña' : 'Mostrar contraseña',
          onPressed: () => setState(() => _mostrarClave = !_mostrarClave),
          icon: Icon(
            _mostrarClave
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            size: 20,
            color: const Color(0xFF195496),
          ),
        ),
      ),
      validator: (text) {
        if (text.toString().length >= 8) return null;
        return 'Clave no válida';
      },
      onFieldSubmitted: (_) => _login(),
    );
  }

  InputDecoration _decoracionCampo({
    required bool activo,
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Color(0xFF98A5B2),
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
      filled: true,
      fillColor: activo ? const Color(0xFFF8FBFF) : const Color(0xFFF7F9FB),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
      prefixIconConstraints: const BoxConstraints(minWidth: 55, minHeight: 52),
      prefixIcon: Container(
        margin: const EdgeInsets.fromLTRB(9, 7, 8, 7),
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: activo ? const Color(0xFFE3EDF8) : const Color(0xFFEAF0F6),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFF195496).withOpacity(activo ? 0.20 : 0.10),
          ),
        ),
        child: Icon(icon, size: 20, color: const Color(0xFF195496)),
      ),
      suffixIcon: suffix,
      suffixIconColor: const Color(0xFF195496),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: const BorderSide(color: Color(0xFFD9E1E8)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: const BorderSide(color: Color(0xFF195496), width: 1.7),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: const BorderSide(color: Color(0xFFD84B4B)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: const BorderSide(color: Color(0xFFD84B4B), width: 1.5),
      ),
      errorStyle: const TextStyle(
        color: Color(0xFFC63D3D),
        fontSize: 10.5,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _recuperar() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton.icon(
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
          UtilidadesUtil.abrirUrl(
            "https://siipne.policia.gob.ec/usuarios/Recuperar.php",
          );
        },
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF195496),
          minimumSize: const Size(48, 40),
          padding: const EdgeInsets.symmetric(horizontal: 4),
          visualDensity: VisualDensity.compact,
        ),
        icon: const Icon(Icons.lock_reset_rounded, size: 17),
        label: const Text(
          '¿Olvidó su contraseña?',
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget _botonIngresar() {
    return AnimatedScale(
      scale: _presionando ? .985 : 1,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              color: const Color(
                0xFF195496,
              ).withOpacity(_presionando ? .12 : .25),
              blurRadius: _presionando ? 8 : 18,
              offset: Offset(0, _presionando ? 3 : 7),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(13),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: _login,
            onHighlightChanged: (value) {
              if (!mounted) return;
              setState(() => _presionando = value);
            },
            splashColor: Colors.white.withOpacity(.14),
            child: Ink(
              width: double.infinity,
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFF123F75),
                    Color(0xFF195496),
                    Color(0xFF2869AC),
                  ],
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.login_rounded, color: Colors.white, size: 20),
                  SizedBox(width: 9),
                  Text(
                    'INICIAR SESIÓN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      letterSpacing: .7,
                    ),
                  ),
                  SizedBox(width: 9),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white70,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _piePantalla() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.78),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: const Color(0xFF195496).withOpacity(.10)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF17365D).withOpacity(.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.phone_android_rounded,
            color: Color(0xFF667789),
            size: 14,
          ),
          const SizedBox(width: 5),
          Text(
            version,
            style: const TextStyle(
              color: Color(0xFF667789),
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _botonHome() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      right: 14,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () =>
              widget.controller.setAppPageSelect(PageAppsSelect.Bienvenida),
          borderRadius: BorderRadius.circular(13),
          child: Ink(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.92),
              borderRadius: BorderRadius.circular(13),
              border: Border.all(
                color: const Color(0xFF195496).withOpacity(.12),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF17365D).withOpacity(.12),
                  blurRadius: 14,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(
              Icons.home_outlined,
              size: 21,
              color: Color(0xFF195496),
            ),
          ),
        ),
      ),
    );
  }

  void _login() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (widget.controller.formKey.currentState?.validate() ?? false)
      widget.controller.login();
  }
}

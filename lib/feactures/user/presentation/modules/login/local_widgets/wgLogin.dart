import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../app/core/utils/utilidadesUtil.dart';
import '../../../../../../app/core/values/app_colors.dart';
import '../../../../../../app/core/values/app_images.dart';
import '../../controllers.dart';

class WgLogin extends StatefulWidget {
  final controllerUser;
  final controllerPass;
  final VoidCallback? onPressed;
  final formKey;
  final double ancho;
  final bool mostrarFondo;

  const WgLogin({
    Key? key,
    this.controllerUser,
    this.controllerPass,
    this.onPressed,
    this.formKey,
    this.ancho = 50.0,
    this.mostrarFondo = false,
  }) : super(key: key);

  @override
  _WgLoginState createState() => _WgLoginState();
}

class _WgLoginState extends State<WgLogin> {
  GlobalKey keyAllLogin = GlobalKey();
  GlobalKey keyTextUsuario = GlobalKey();
  GlobalKey keyTextClave = GlobalKey();
  GlobalKey keyBtnLogin = GlobalKey();
  GlobalKey keyOlvidoContrasena = GlobalKey();

  final FocusNode _focusUsuario = FocusNode();
  final FocusNode _focusClave = FocusNode();

  bool _mostrarClave = false;
  bool _focusUser = false;
  bool _focusPass = false;
  bool _presionado = false;

  @override
  void initState() {
    super.initState();
    _focusUsuario.addListener(() {
      if (!mounted) return;
      setState(() => _focusUser = _focusUsuario.hasFocus);
    });
    _focusClave.addListener(() {
      if (!mounted) return;
      setState(() => _focusPass = _focusClave.hasFocus);
    });
  }

  @override
  void dispose() {
    _focusUsuario.dispose();
    _focusClave.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wg = Container(
      key: keyAllLogin,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.97),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE1E6EB),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00244D).withOpacity(.11),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.colorAzul_1,
                    AppColors.colorAzul,
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
              child: AutofillGroup(
                child: Form(
                  key: widget.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _cabecera(),
                      const SizedBox(height: 22),
                      _label('Usuario', Icons.person_outline_rounded),
                      const SizedBox(height: 7),
                      Container(
                        key: keyTextUsuario,
                        child: _campoUsuario(),
                      ),
                      const SizedBox(height: 16),
                      _label('Contraseña', Icons.lock_outline_rounded),
                      const SizedBox(height: 7),
                      Container(
                        key: keyTextClave,
                        child: _campoClave(),
                      ),
                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.centerRight,
                        child: _olvidoClave(),
                      ),
                      const SizedBox(height: 14),
                      Container(
                        key: keyBtnLogin,
                        width: double.infinity,
                        child: _botonIngresar(),
                      ),
                      const SizedBox(height: 16),
                      _seguridad(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return GetBuilder<LoginController>(
      id: 'WgLogin',
      builder: (_) => wg,
    );
  }

  Widget _cabecera() {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F7FA),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.colorAzul_1.withOpacity(.10),
            ),
          ),
          child: Image.asset(
            AppImages.escudopolicia,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(width: 13),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Acceso institucional',
                style: TextStyle(
                  color: AppColors.colorAzul_1,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Ingrese sus credenciales para continuar',
                style: TextStyle(
                  color: Color(0xFF68737E),
                  fontSize: 11.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _label(String texto, IconData icono) {
    return Row(
      children: [
        Icon(
          icono,
          size: 15,
          color: AppColors.colorAzul_1,
        ),
        const SizedBox(width: 6),
        Text(
          texto,
          style: const TextStyle(
            color: Color(0xFF34414E),
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _campoUsuario() {
    return TextFormField(
      focusNode: _focusUsuario,
      controller: widget.controllerUser,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.username],
      style: const TextStyle(
        color: Color(0xFF1D2935),
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      cursorColor: AppColors.colorAzul_1,
      decoration: _inputDecoration(
        focused: _focusUser,
        hint: 'Ingrese su usuario',
        icon: Icons.badge_outlined,
      ),
      validator: (text) {
        if (text != null && text.length >= 10) return null;
        return 'Usuario no válido';
      },
      onFieldSubmitted: (_) {
        _focusClave.requestFocus();
      },
    );
  }

  Widget _campoClave() {
    return TextFormField(
      focusNode: _focusClave,
      controller: widget.controllerPass,
      obscureText: !_mostrarClave,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      autofillHints: const [AutofillHints.password],
      style: const TextStyle(
        color: Color(0xFF1D2935),
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      cursorColor: AppColors.colorAzul_1,
      decoration: _inputDecoration(
        focused: _focusPass,
        hint: 'Ingrese su contraseña',
        icon: Icons.key_rounded,
        suffix: IconButton(
          tooltip: _mostrarClave ? 'Ocultar contraseña' : 'Mostrar contraseña',
          onPressed: () {
            setState(() {
              _mostrarClave = !_mostrarClave;
            });
          },
          icon: Icon(
            _mostrarClave
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            size: 20,
            color: _focusPass
                ? AppColors.colorAzul_1
                : const Color(0xFF7B8792),
          ),
        ),
      ),
      validator: (text) {
        if (text.toString().length >= 8) return null;
        return 'Clave no válida';
      },
      onFieldSubmitted: (_) => _ejecutarLogin(),
    );
  }

  InputDecoration _inputDecoration({
    required bool focused,
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Color(0xFF98A2AC),
        fontSize: 13,
      ),
      filled: true,
      fillColor: focused
          ? AppColors.colorAzul_1.withOpacity(.025)
          : const Color(0xFFFAFBFC),
      prefixIcon: Container(
        margin: const EdgeInsets.fromLTRB(9, 8, 8, 8),
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: focused
              ? AppColors.colorAzul_1.withOpacity(.10)
              : const Color(0xFFF0F3F6),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: 19,
          color: focused
              ? AppColors.colorAzul_1
              : const Color(0xFF65717D),
        ),
      ),
      suffixIcon: suffix,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: const BorderSide(
          color: Color(0xFFD9DFE5),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: const BorderSide(
          color: Color(0xFFD9DFE5),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: BorderSide(
          color: AppColors.colorAzul_1,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: const BorderSide(
          color: Color(0xFFD64545),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: const BorderSide(
          color: Color(0xFFD64545),
          width: 1.5,
        ),
      ),
      errorStyle: const TextStyle(
        color: Color(0xFFD64545),
        fontSize: 10,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _olvidoClave() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        key: keyOlvidoContrasena,
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          UtilidadesUtil.abrirUrl(
            "https://siipne.policia.gob.ec/usuarios/Recuperar.php",
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 8,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.help_outline_rounded,
                size: 16,
                color: AppColors.colorAzul_1,
              ),
              const SizedBox(width: 6),
              Text(
                '¿Olvidó su contraseña?',
                style: TextStyle(
                  color: AppColors.colorAzul_1,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _botonIngresar() {
    return AnimatedScale(
      scale: _presionado ? .985 : 1,
      duration: const Duration(milliseconds: 100),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _ejecutarLogin,
          onHighlightChanged: (value) {
            setState(() {
              _presionado = value;
            });
          },
          borderRadius: BorderRadius.circular(13),
          child: Ink(
            height: 54,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  AppColors.colorAzul_1,
                  AppColors.colorAzul,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.colorAzul_1.withOpacity(.20),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.login_rounded,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(width: 9),
                Text(
                  'INGRESAR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    letterSpacing: .8,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _seguridad() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: AppColors.colorAzul_1.withOpacity(.045),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        children: [
          Icon(
            Icons.shield_outlined,
            color: AppColors.colorAzul_1,
            size: 17,
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Acceso exclusivo para personal autorizado',
              style: TextStyle(
                color: Color(0xFF67727D),
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Icon(
            Icons.verified_rounded,
            color: AppColors.colorAzul_1.withOpacity(.70),
            size: 17,
          ),
        ],
      ),
    );
  }

  void _ejecutarLogin() {
    FocusManager.instance.primaryFocus?.unfocus();

    if (widget.formKey.currentState?.validate() ?? false) {
      widget.onPressed?.call();
    }
  }
}
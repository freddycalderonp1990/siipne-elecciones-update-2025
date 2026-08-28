part of '../../pages.dart';

class InicioRapidoPage extends GetView<InicioRapidoController> {
  const InicioRapidoPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationsBloc>().requestPermission(
        appName: NamApps.todas,
        idGenUsuario: controller.user.value.idGenUsuario,
      );
    });
    return _InicioRapidoFullScreen(controller: controller);
  }
}

class _InicioRapidoFullScreen extends StatefulWidget {
  final InicioRapidoController controller;
  const _InicioRapidoFullScreen({Key? key, required this.controller})
    : super(key: key);
  @override
  State<_InicioRapidoFullScreen> createState() =>
      _InicioRapidoFullScreenState();
}

class _InicioRapidoFullScreenState extends State<_InicioRapidoFullScreen> {
  String version = '';
  bool _presionHuella = false;
  bool _presionUsuario = false;

  @override
  void initState() {
    super.initState();
    _cargarVersion();
  }

  Future<void> _cargarVersion() async {
    final String _version = await DeviceInfoApp.getVersionCodeNameApp;
    if (!mounted) return;
    setState(() => version = _version);
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Stack(
        fit: StackFit.expand,
        children: [
          _imagenInstitucional(),
          _veloFondo(),
          _detallesTecnologicos(),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(
                    20,
                    18,
                    20,
                    16 + media.padding.bottom,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight:
                          constraints.maxHeight - 34 - media.padding.bottom,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _marca(),
                        const SizedBox(height: 22),
                        _panelPrincipal(),
                        const SizedBox(height: 18),
                        _footer(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Obx(
            () => CargandoWidget(
              mostrar: widget.controller.peticionServerState.value,
            ),
          ),
        ],
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
                Colors.white.withOpacity(.02),
                Colors.white.withOpacity(.08),
                const Color(0xFFF5F7FA).withOpacity(.12),
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
              top: 80,
              left: -90,
              child: Container(
                width: 250,
                height: 250,
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
              bottom: 100,
              right: -110,
              child: Container(
                width: 300,
                height: 300,
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

  Widget _marca() {
    return Column(
      children: [
        Container(
          width: 74,
          height: 74,
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.92),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF195496).withOpacity(.14)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF195496).withOpacity(.12),
                blurRadius: 22,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Image.asset(AppImages.escudopolicia, fit: BoxFit.contain),
        ),
        const SizedBox(height: 13),
        const Text(
          'POLICÍA NACIONAL DEL ECUADOR',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF17365D),
            fontSize: 20,
            fontWeight: FontWeight.w900,
            letterSpacing: .6,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Sistema Informático Integrado de la Policía Nacional del Ecuador',
          style: TextStyle(
            color: Color(0xFF66798F),
            fontSize: 10.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _panelPrincipal() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 440),
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.90),
            borderRadius: BorderRadius.circular(26),
            border: Border.all(
              color: Colors.white.withOpacity(.98),
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
          child: Column(
            children: [
              _usuario(),
              const SizedBox(height: 19),
              _separador(),
              const SizedBox(height: 18),
              _cabeceraAcceso(),
              const SizedBox(height: 15),
              _cardAccesos(),
              const SizedBox(height: 16),
              _seguridad(),
            ],
          ),
        ),
      ),
    );
  }
  Widget _cardAccesos(){return Container(width:double.infinity,padding:const EdgeInsets.all(10),decoration:BoxDecoration(color:const Color(0xFFF7F9FB),borderRadius:BorderRadius.circular(18),border:Border.all(color:const Color(0xFFD9E1E8)),boxShadow:[BoxShadow(color:const Color(0xFF17365D).withOpacity(.06),blurRadius:14,offset:const Offset(0,5))]),child:Row(children:[Expanded(child:_botonBiometricoHorizontal()),const SizedBox(width:10),Expanded(child:_botonOtroUsuarioHorizontal())]));}

  Widget _botonBiometricoHorizontal(){return AnimatedScale(scale:_presionHuella?0.985:1.0,duration:const Duration(milliseconds:110),curve:Curves.easeOut,child:Material(color:Colors.transparent,borderRadius:BorderRadius.circular(15),clipBehavior:Clip.antiAlias,child:InkWell(onTap:()=>widget.controller.loginConBiometrico(),onHighlightChanged:(value){if(!mounted)return;setState(()=>_presionHuella=value);},splashColor:Colors.white.withOpacity(.15),child:Ink(height:118,decoration:BoxDecoration(borderRadius:BorderRadius.circular(15),gradient:const LinearGradient(begin:Alignment.topLeft,end:Alignment.bottomRight,colors:[Color(0xFF123F75),Color(0xFF195496),Color(0xFF2869AC)])),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Container(width:46,height:46,decoration:BoxDecoration(color:Colors.white.withOpacity(.13),borderRadius:BorderRadius.circular(14),border:Border.all(color:Colors.white.withOpacity(.12))),child:const Icon(Icons.fingerprint_rounded,color:Colors.white,size:29)),const SizedBox(height:9),const Text('Acceso biométrico',textAlign:TextAlign.center,maxLines:1,overflow:TextOverflow.ellipsis,style:TextStyle(color:Colors.white,fontSize:11.5,fontWeight:FontWeight.w800)),const SizedBox(height:4),Text('Huella o Face ID',textAlign:TextAlign.center,style:TextStyle(color:Colors.white.withOpacity(.72),fontSize:8.5,fontWeight:FontWeight.w500))])))));}

  Widget _botonOtroUsuarioHorizontal(){return AnimatedScale(scale:_presionUsuario?0.985:1.0,duration:const Duration(milliseconds:110),curve:Curves.easeOut,child:Material(color:Colors.transparent,borderRadius:BorderRadius.circular(15),clipBehavior:Clip.antiAlias,child:InkWell(onTap:()=>widget.controller.ingresoConOtroUsuario(),onHighlightChanged:(value){if(!mounted)return;setState(()=>_presionUsuario=value);},splashColor:const Color(0xFF195496).withOpacity(.08),child:Ink(height:118,decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(15),border:Border.all(color:const Color(0xFFD7E0E8))),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Container(width:46,height:46,decoration:BoxDecoration(color:const Color(0xFFE8F0F8),borderRadius:BorderRadius.circular(14),border:Border.all(color:const Color(0xFF195496).withOpacity(.10))),child:const Icon(Icons.person_add_alt_1_rounded,color:Color(0xFF195496),size:24)),const SizedBox(height:9),const Text('Otro usuario',textAlign:TextAlign.center,maxLines:1,overflow:TextOverflow.ellipsis,style:TextStyle(color:Color(0xFF17365D),fontSize:11.5,fontWeight:FontWeight.w800)),const SizedBox(height:4),const Text('Usuario y contraseña',textAlign:TextAlign.center,style:TextStyle(color:Color(0xFF728294),fontSize:8.5,fontWeight:FontWeight.w500))])))));}
  Widget _usuario() {
    return Obx(() {
      final foto = widget.controller.user.value.foto;
      final nombres = widget.controller.user.value.nombres;
      final sexo = widget.controller.user.value.sexo;
      return Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 78,
                height: 78,
                padding: const EdgeInsets.all(2.5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF7FB4E8),
                      Color(0xFF195496),
                      Color(0xFF123F75),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF195496).withOpacity(.18),
                      blurRadius: 17,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Container(
                  padding: const EdgeInsets.all(3.5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: ClipOval(child: _fotoUsuario(foto)),
                ),
              ),
              Positioned(
                right: -1,
                bottom: 4,
                child: Container(
                  width: 23,
                  height: 23,
                  decoration: BoxDecoration(
                    color: const Color(0xFF195496),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: const Icon(
                    Icons.verified_rounded,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _saludoPorSexo(sexo),
                  style: const TextStyle(
                    color: Color(0xFF195496),
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  nombres?.toString() ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF17365D),
                    fontSize: 16,
                    height: 1.18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 7),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF195496).withOpacity(.06),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: const Color(0xFF195496).withOpacity(.08),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.badge_outlined,
                        color: Color(0xFF195496),
                        size: 12,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Cuenta institucional',
                        style: TextStyle(
                          color: Color(0xFF667789),
                          fontSize: 8,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _fotoUsuario(dynamic foto) {
    final String valor = foto?.toString().trim() ?? '';
    if (valor.isEmpty || valor.toLowerCase() == 'null')
      return _fotoUsuarioDefault();
    try {
      if (valor.startsWith('http://') || valor.startsWith('https://')) {
        return Image.network(
          valor,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _fotoUsuarioDefault(),
        );
      }
      if (valor.startsWith('data:image')) {
        final String base64Data = valor.split(',').last;
        return Image.memory(
          base64Decode(base64Data),
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _fotoUsuarioDefault(),
        );
      }
      if (_esBase64(valor)) {
        return Image.memory(
          base64Decode(valor),
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _fotoUsuarioDefault(),
        );
      }
      return Image.asset(
        valor,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _fotoUsuarioDefault(),
      );
    } catch (e) {
      return _fotoUsuarioDefault();
    }
  }

  bool _esBase64(String valor) {
    try {
      if (valor.length < 100) return false;
      final String limpio = valor.replaceAll(RegExp(r'\s+'), '');
      base64Decode(limpio);
      return true;
    } catch (e) {
      return false;
    }
  }

  Widget _fotoUsuarioDefault() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFEAF1F8), Color(0xFFD8E4F0)],
        ),
      ),
      child: const Center(
        child: Icon(Icons.person_rounded, color: Color(0xFF195496), size: 40),
      ),
    );
  }

  String _saludoPorSexo(dynamic sexo) {
    final String valor = sexo?.toString().trim().toUpperCase() ?? '';
    if (valor == 'F' || valor == 'FEMENINO' || valor == 'MUJER')
      return 'BIENVENIDA';
    return 'BIENVENIDO';
  }

  Widget _separador() {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            const Color(0xFF195496).withOpacity(.16),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  Widget _cabeceraAcceso() {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: const Color(0xFF195496).withOpacity(.08),
            borderRadius: BorderRadius.circular(11),
            border: Border.all(color: const Color(0xFF195496).withOpacity(.10)),
          ),
          child: const Icon(
            Icons.security_rounded,
            color: Color(0xFF195496),
            size: 19,
          ),
        ),
        const SizedBox(width: 11),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Método de acceso',
                style: TextStyle(
                  color: Color(0xFF17365D),
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 3),
              Text(
                'Seleccione cómo desea continuar',
                style: TextStyle(color: Color(0xFF728294), fontSize: 9.5),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _botonBiometrico() {
    return AnimatedScale(
      scale: _presionHuella ? .985 : 1,
      duration: const Duration(milliseconds: 110),
      curve: Curves.easeOut,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          boxShadow: [
            BoxShadow(
              color: const Color(
                0xFF195496,
              ).withOpacity(_presionHuella ? .12 : .24),
              blurRadius: _presionHuella ? 9 : 18,
              offset: Offset(0, _presionHuella ? 3 : 7),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(17),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () => widget.controller.loginConBiometrico(),
            onHighlightChanged: (value) {
              if (!mounted) return;
              setState(() => _presionHuella = value);
            },
            splashColor: Colors.white.withOpacity(.15),
            child: Ink(
              width: double.infinity,
              height: 72,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
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
              child: Row(
                children: [
                  const SizedBox(width: 13),
                  Container(
                    width: 47,
                    height: 47,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.13),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.white.withOpacity(.12)),
                    ),
                    child: const Icon(
                      Icons.fingerprint_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 13),
                  const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                'Acceso biométrico',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            SizedBox(width: 7),
                            _BadgeRecomendado(),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Huella digital o Face ID',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 9.5,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 31,
                    height: 31,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.10),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 17,
                    ),
                  ),
                  const SizedBox(width: 13),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _botonOtroUsuario() {
    return AnimatedScale(
      scale: _presionUsuario ? .985 : 1,
      duration: const Duration(milliseconds: 110),
      curve: Curves.easeOut,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(17),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => widget.controller.ingresoConOtroUsuario(),
          onHighlightChanged: (value) {
            if (!mounted) return;
            setState(() => _presionUsuario = value);
          },
          splashColor: const Color(0xFF195496).withOpacity(.08),
          child: Ink(
            width: double.infinity,
            height: 68,
            decoration: BoxDecoration(
              color: const Color(0xFFF7F9FB),
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: const Color(0xFFD9E1E8)),
            ),
            child: Row(
              children: [
                const SizedBox(width: 13),
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F0F8),
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(
                      color: const Color(0xFF195496).withOpacity(.10),
                    ),
                  ),
                  child: const Icon(
                    Icons.person_add_alt_1_rounded,
                    color: Color(0xFF195496),
                    size: 21,
                  ),
                ),
                const SizedBox(width: 13),
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ingresar con otro usuario',
                        style: TextStyle(
                          color: Color(0xFF17365D),
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Utilice usuario y contraseña institucional',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Color(0xFF728294),
                          fontSize: 9,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF60758A),
                  size: 24,
                ),
                const SizedBox(width: 11),
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
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
      decoration: BoxDecoration(
        color: const Color(0xFF195496).withOpacity(.045),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF195496).withOpacity(.075)),
      ),
      child: const Row(
        children: [
          Icon(Icons.shield_outlined, color: Color(0xFF195496), size: 15),
          SizedBox(width: 7),
          Expanded(
            child: Text(
              'Autenticación institucional protegida',
              style: TextStyle(
                color: Color(0xFF667789),
                fontSize: 8.8,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Icon(Icons.verified_rounded, color: Color(0xFF195496), size: 14),
        ],
      ),
    );
  }

  Widget _footer() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.80),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: const Color(0xFF195496).withOpacity(.08)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF17365D).withOpacity(.05),
                blurRadius: 10,
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
                size: 12,
              ),
              const SizedBox(width: 5),
              Text(
                version,
                style: const TextStyle(
                  color: Color(0xFF667789),
                  fontSize: 8.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 7),
        const Text(
          'ACCESO INSTITUCIONAL SEGURO',
          style: TextStyle(
            color: Color(0xFF8A99A8),
            fontSize: 7,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.1,
          ),
        ),
      ],
    );
  }
}

class _BadgeRecomendado extends StatelessWidget {
  const _BadgeRecomendado();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(.13)),
      ),
      child: const Text(
        'RÁPIDO',
        style: TextStyle(
          color: Colors.white,
          fontSize: 6.7,
          fontWeight: FontWeight.w800,
          letterSpacing: .6,
        ),
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../../../app/core/app_config.dart';
import '../../../../../app/core/utils/tutorial_utils.dart';
import '../../../../../app/core/utils/utilidadesUtil.dart';
import '../../../../../app/core/values/app_colors.dart';
import '../../../../../app/core/values/app_images.dart';
import '../../../../../app/presentation/widgets/custom_app_widgets.dart';
import '../../../../core/siipne_config.dart';
import '../../../../../app/core/utils/responsiveUtil.dart';
import '../../../../core/values/siipne_images.dart';
import '../../../../core/values/siipne_strings.dart';
import '../../../../core/values/tutorial_app_strings.dart';
import '../../../../data/repository/data_repositories.dart';
import '../../../../domain/enums/enums.dart';
import '../../../../presentation/widgets/customWidgets.dart';
import '../../controllers.dart';

class WgLogin extends StatefulWidget {
  final controllerUser;

  final controllerPass;

  final VoidCallback? onPressed;
  final ValueChanged<ActionTutorial>? completeTutorial;
  final formKey;
  final double ancho;
  final bool mostrarFondo;

  const WgLogin(
      {Key? key,
      this.controllerUser,
      this.controllerPass,
      this.onPressed,
      this.completeTutorial,
      this.formKey,
      this.ancho = 50.0,
      this.mostrarFondo = false})
      : super(key: key);

  @override
  _WgLoginState createState() => _WgLoginState();
}

class _WgLoginState extends State<WgLogin> {
  @override
  void initState() {
   // createTutorial();

    super.initState();
  }

  late TutorialCoachMark tutorialCoachMark;

  GlobalKey keyAllLogin = GlobalKey();

  GlobalKey keyTextUsuario = GlobalKey();
  GlobalKey keyTextClave = GlobalKey();
  GlobalKey keyBtnLogin = GlobalKey();
  GlobalKey keyOlvidoContrasena = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();

    Widget desing = OnlyDesingUserPass(
      onPressed: widget.onPressed,
      keyBtnLogin: keyBtnLogin,
      ancho: widget.ancho,
      controllerPass: widget.controllerPass,
      controllerUser: widget.controllerUser,
      formKey: widget.formKey,
      keyTextClave: keyTextClave,
      keyTextUsuario: keyTextUsuario,
    );

    desing = Column(
      children: [
        desing,
        SizedBox(
          height: 0,
          key: keyAllLogin,
        ),
      ],
    );

    Widget wg = widget.mostrarFondo
        ? Stack(
            children: [
              Container(
                height: responsive.alto! / 2,
                width: responsive.ancho! - 100,
                child: Image.asset(
                  AppImages.imgFondoDefault,
                  fit: BoxFit.cover,
                ),
              ),
              desing
            ],
          )
        : desing;

    wg = Column(
      children: [
        wg,
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          key: keyOlvidoContrasena,
          onTap: () {
            UtilidadesUtil.abrirUrl(
                "https://siipne.policia.gob.ec/usuarios/Recuperar.php");
          },
          child: Container(
              child: TextSombrasWidget(
            title: "¿Olvidó su Contraseña?",
            colorSombra: Colors.white.withOpacity(0.5),
            size: responsive.diagonalP(AppConfig.tamTextoTitulo),
          )),
        ),
      ],
    );

    return GetBuilder<LoginController>(id: 'WgLogin', builder: (_) => wg);
  }

  List<TargetFocus> _createTargets() {
    List<TargetFocus> targets = [];

    targets.add(
      TutorialUtils.getTargetFocus(keyAllLogin,
          align: ContentAlign.top,
          title: TutorialAppStrings.pasoIntroduccionLogin.title,
          detalle: TutorialAppStrings.pasoIntroduccionLogin.pasos),
    );
    targets.add(
      TutorialUtils.getTargetFocus(keyTextUsuario,
          title: TutorialAppStrings.pasoUsuario.title,
          align: ContentAlign.top,
          detalle: TutorialAppStrings.pasoUsuario.pasos),
    );

    targets.add(
      TutorialUtils.getTargetFocus(keyTextClave,
          title: TutorialAppStrings.pasoClave.title,
          align: ContentAlign.top,
          detalle: TutorialAppStrings.pasoClave.pasos),
    );

    targets.add(
      TutorialUtils.getTargetFocus(keyBtnLogin,
          title: TutorialAppStrings.pasoBtnIngresar.title,
          align: ContentAlign.top,
          detalle: TutorialAppStrings.pasoBtnIngresar.pasos),
    );

    targets.add(
      TutorialUtils.getTargetFocus(keyOlvidoContrasena,
          title: TutorialAppStrings.pasoOlvidoSuClave.title,
          align: ContentAlign.top,
          detalle: TutorialAppStrings.pasoOlvidoSuClave.pasos),
    );

    return targets;
  }

  void showTutorial() {

    Future.delayed(Duration(milliseconds: 200),() {
      tutorialCoachMark.show(context: context);
    });

  }

  void createTutorial() async {
    final LocalStoreImpl _localStoreImpl = Get.find<LocalStoreImpl>();
    String tutorial = await _localStoreImpl.getShowTutorial();
    if (tutorial != ShowTutorial.Login.toString()) {
      return;
    }

    tutorialCoachMark = TutorialUtils.createTutorial(
        targets: _createTargets(),
        completeTutorial: (value) {
          if (value == ActionTutorial.onSkip) {
            DialogosAwesome.getWarningSiNo(
                descripcion:
                "¿Estás seguro de que no quieres continuar con el tutorial?",
                btnCancelOnPress: (){
                 showTutorial();
                },
                btnOkOnPress: () {
                 // widget.completeTutorial!(value);
                });
          }
        });

    showTutorial();
  }
}

class OnlyDesingUserPass extends StatelessWidget {
  final double ancho;
  final formKey;
  final controllerUser;
  final controllerPass;
  final keyTextUsuario;
  final keyTextClave;
  final keyBtnLogin;
  final VoidCallback? onPressed;
  const OnlyDesingUserPass(
      {super.key,
      this.formKey,
      this.ancho = 50.0,
      this.controllerUser,
      this.controllerPass,
      this.keyTextUsuario,
      this.keyTextClave,
      this.onPressed,
      this.keyBtnLogin});
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();
    final sizeTxt = responsive.diagonalP(AppConfig.tamTextoTitulo);

    Widget desing = Column(
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: responsive.ancho! - ancho,
            minWidth: responsive.ancho! - ancho,
          ),
          child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    key: keyTextUsuario,
                    decoration: BoxDecoration(
                      color: Colors.white, //PARA PROBAR CONTAINER
                      borderRadius: new BorderRadius.circular(15.0),
                    ),
                    child: ImputTextWidget(
                      imgString: AppImages.icon_usuario,
                      controller: controllerUser,
                      elevation: 1,
                      label: "Usuario",
                      fonSize: sizeTxt,
                      hitText: "Ingrese el usuario",
                      validar: (text) {
                        if (text!.length >= 10 ) {
                          return null;
                        }
                        return "Usuario no válido";
                      },
                    ),
                  ),
                  SizedBox(
                    height: responsive.altoP(2),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white, //PARA PROBAR CONTAINER
                      borderRadius: new BorderRadius.circular(15.0),
                    ),
                    child: ImputTextWidget(
                      key: keyTextClave,
                      imgString: AppImages.icon_clave,
                      elevation: 1,
                      isSegura: true,
                      controller: controllerPass,
                      hitText: "Ingrese la clave",
                      label: "Clave",
                      fonSize: sizeTxt,
                      validar: (text) {
                        if (text.toString().length >= 8) {
                          return null;
                        }
                        return "Clave no válida";
                      },
                    ),
                  )
                ],
              )),
        ),
        SizedBox(
          height: responsive.altoP(4),
        ),
        ConstrainedBox(
          key: keyBtnLogin,
          constraints: BoxConstraints(
            maxWidth: responsive.ancho! - 80,
            minWidth: responsive.ancho! - 80,
          ),
          child: BotonesWidget(
            iconData: Icons.check_circle,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            title: "INGRESAR",
            onPressed: onPressed,
          ),
        ),
      ],
    );
    return desing;
  }
}

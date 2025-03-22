import 'dart:ui';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../app/presentation/widgets/custom_app_widgets.dart';
import '../../../app_elecciones//domain/enums/enums.dart';
import '../../core/utils/responsiveUtil.dart';

import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../app_config.dart';
import '../values/app_colors.dart';

class TutorialUtils {


  static TargetFocus getTargetFocus(GlobalKey key,
      {required String title,
        required String detalle,
        ContentAlign align = ContentAlign.bottom}) {
    final responsive = ResponsiveUtil();
    return TargetFocus(
      enableOverlayTab: true,
      identify: key.toString(),
      keyTarget: key,
      color: AppColors.colorAzul,
      contents: [
        TargetContent(
          align: align,
          builder: (context, controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextSombrasWidget(
                  title: title,
                  colorSombra: Colors.black,
                  colorTexto: Colors.white,
                  size: responsive.diagonalP(AppConfig.tamTextoTitulo + 0.5),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: TextSombrasWidget(
                    colorSombra: Colors.black45,
                    colorTexto: Colors.white,
                    title: detalle,
                    size: responsive.diagonalP(AppConfig.tamTextoTitulo),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                        child: ElevatedButton(
                          onPressed: () {
                            controller.previous();
                          },
                          child: Icon(
                            Icons.chevron_left,
                            size: responsive.diagonalP(AppConfig.tamIcons),
                          ),
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                        child: ElevatedButton(
                          onPressed: () {
                            controller.next();
                          },
                          child: Icon(Icons.chevron_right,
                              size: responsive.diagonalP(AppConfig.tamIcons)),
                        )),
                  ],
                ),
              ],
            );
          },
        )
      ],
      shape: ShapeLightFocus.RRect,
      radius: 5,
    );
  }

  void showTutorial(
      {required TutorialCoachMark tutorialCoachMark,
        required BuildContext context}) {
    tutorialCoachMark.show(context: context);
  }

  static TutorialCoachMark createTutorial(
      {required ValueChanged<ActionTutorial> completeTutorial,
        required List<TargetFocus> targets}) {
    return TutorialCoachMark(
      targets: targets,
      colorShadow: Colors.red,
      textSkip: "SALTAR",
      paddingFocus: 10,
      opacityShadow: 0.5,
      imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      onFinish: () {
        print("finish");
        completeTutorial(ActionTutorial.onFinish);
      },
      onClickTarget: (target) {
        print('onClickTarget: $target');
        completeTutorial(ActionTutorial.onClickTarget);
      },
      onClickTargetWithTapPosition: (target, tapDetails) {
        completeTutorial(ActionTutorial.onClickTargetWithTapPosition);
        print("target: $target");
        print(
            "clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
      },
      onClickOverlay: (target) {
        print('onClickOverlay: $target');
        completeTutorial(ActionTutorial.onClickOverlay);
      },
      onSkip: () {
        print("skip");




        completeTutorial(ActionTutorial.onSkip);




        return true;
      },
    );
  }
}

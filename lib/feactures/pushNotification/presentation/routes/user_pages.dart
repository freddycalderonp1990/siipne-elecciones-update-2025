
import 'package:flutter/animation.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../modules/bindings.dart';
import '../modules/pages.dart';
import 'user_routes.dart';

class UserPages {
  static final _transition = Transition.rightToLeft;
  static final _transitionDuration = const Duration(milliseconds: 400);
  static final _curve = Curves.fastOutSlowIn;


  static GetPage _getPageConfig(
      {required String name,
        required GetPageBuilder page,
        required Bindings binding}) {
    return GetPage(
        transition: _transition,
        transitionDuration: _transitionDuration,
        curve: _curve,
        name: name,
        page: page,
        binding: binding);
  }

  static final List<GetPage> pages = [
_getPageConfig(
        name: UserRoutes.LOGIN,
        page: () => LoginPage(),
        binding: LoginBinding()),
    _getPageConfig(
        name: UserRoutes.LOGIN_RAPIDO,
        page: () => InicioRapidoPage(),
        binding: InicioRapidoBinding()),


  ];
}

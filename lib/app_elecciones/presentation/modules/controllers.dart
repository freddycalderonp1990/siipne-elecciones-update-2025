import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';

import 'package:siipnelecciones3/app_elecciones//core/values/tutorial_app_strings.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:siipnelecciones3/app_elecciones/core/values/siipne_images.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:geolocator/geolocator.dart' as myGeolocator;

import '../../../app/core/app_config.dart';

import '../../../app/core/exceptions/exception_helper.dart';
import '../../../app/core/exceptions/exceptions.dart';


import '../../../app/core/utils/check_internet_conexion.dart';
import '../../../app/core/utils/my_gps.dart';
import '../../../app/core/utils/tutorial_utils.dart';

import '../../../app/core/utils/device_info.dart';
import '../../../app/core/utils/encriptar_util.dart';

import '../../../app/data/provider/providers_impl_app.dart';
import '../../../app/presentation/routes/app_routes.dart';


import '../../../app/presentation/widgets/custom_app_widgets.dart';
import '../../core/values/mensajes_string.dart';
import '../../data/repository/data_repositories.dart';
import '../../domain/enums/enums.dart';
import '../../domain/request/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../data/models/models.dart';
import '../../core/siipne_config.dart';
import '../../../app/core/utils/utilidadesUtil.dart';
import '../../presentation/routes/siipne_routes.dart';
import '../../../app/core/utils/biometricUtil.dart';
import '../../presentation/widgets/customWidgets.dart';


part '../gps/my_gps_controller.dart';
part 'login/login_controller.dart';
part 'login/inicio_rapido/inicio_rapido_controller.dart';
part 'menu/menu_app_controller.dart';
part 'select_proceso_operativo/select_proceso_operativo_controller.dart';
part 'menu_recintos_electorales/menu_recintos_electorales_controller.dart';
part 'menu_unidades_policiales/menu_unidades_policiales_controller.dart';



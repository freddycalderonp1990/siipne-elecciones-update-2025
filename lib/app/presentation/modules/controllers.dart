


import 'dart:async';
import 'dart:convert';
import 'dart:io';




import 'package:api_provider/core/api_config.dart';
import 'package:api_provider/core/exceptions/exceptions.dart';
import 'package:api_provider/core/utils/prints_msj.dart';
import 'package:api_provider/domain/enums/enums.dart';
import 'package:app_mi_upc/app_mi_upc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:get/get.dart';


import '../../../app/core/utils/utilidadesUtil.dart';
import '../../../app/presentation/widgets/custom_app_widgets.dart';
import 'package:path_provider/path_provider.dart';



import '../../../app_censo/presentation/routes/app_censo_routes.dart';
import '../../../app_elecciones/data/models/models.dart';
import '../../../app_elecciones/data/repository/data_repositories.dart';
import '../../../app_elecciones/presentation/routes/elecciones_routes.dart';
import '../../../feactures/app_moviles/data/models/apps_model.dart';
import '../../../feactures/app_moviles/domain/request/verificar_update_request.dart';
import '../../../feactures/app_moviles/domain/use_cases/verificar_update_app.dart';
import '../../../feactures/menu_app/data/models/menu_app_model.dart';
import '../../../feactures/menu_app/domain/use_cases/get_menu_app_use_case.dart';
import '../../../feactures/user/domain/entities/user.dart';
import '../../../feactures/user/domain/use_cases/local_store.dart';
import '../../../feactures/user/presentation/modules/controllers.dart';
import '../../../feactures/user/presentation/routes/user_routes.dart';
import '../../core/app_config.dart';

import '../../core/exceptions/exception_dialogos.dart';
import '../../core/utils/device_info.dart';
import '../../core/utils/device_info_app.dart';


import '../../core/values/mensajes_string.dart';


import '../../domain/enums/enums.dart';
import '../routes/app_routes.dart';







part 'splash/splash_controller.dart';
part 'bienvenido/bienvenido_controller.dart';
part 'home/home_controller.dart';
part 'pdf/pdf_view_controller.dart';
part 'menu/menu_app_controller.dart';



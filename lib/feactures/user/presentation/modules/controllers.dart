import 'dart:async';
import 'dart:developer';
import 'dart:io';


import 'package:api_provider/api_provider.dart';
import 'package:api_provider/domain/enums/enums.dart';

import 'package:flutter/widgets.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';


import '../../../../app/core/app_config.dart';

import '../../../../app/core/biometric/biometricUtil.dart';
import '../../../../app/core/exceptions/exception_dialogos.dart';

import '../../../../app/core/utils/device_info_app.dart';
import '../../../../app/core/utils/utilidadesUtil.dart';

import '../../../../app/domain/enums/enums.dart';
import '../../../../app/presentation/routes/app_routes.dart';
import '../../../../app/presentation/widgets/custom_app_widgets.dart';

import '../../core/utils/encriptar_util.dart';
import '../../core/utils/token.dart';
import '../../data/models/models_user.dart';
import '../../domain/entities/user.dart';
import '../../domain/request/request_user.dart';
import '../../domain/use_cases/auth.dart';
import '../../domain/use_cases/get_data_user.dart';
import '../../domain/use_cases/local_store.dart';




part 'login/login_controller.dart';
part 'login/inicio_rapido/inicio_rapido_controller.dart';


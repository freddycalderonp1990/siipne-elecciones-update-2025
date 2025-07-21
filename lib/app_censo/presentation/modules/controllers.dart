import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../app/core/app_config.dart';
import '../../../app/core/exceptions/exception_dialogos.dart';
import '../../../app/core/utils/photo_helper.dart';
import '../../../app/presentation/routes/app_routes.dart';
import '../../../app/presentation/widgets/custom_app_widgets.dart';
import '../../../app_elecciones/data/models/models.dart';
import '../../../app_elecciones/presentation/routes/elecciones_routes.dart';
import '../../../feactures/my_qr/core/exceptions/qr_exception.dart';
import '../../../feactures/user/core/utils/encriptar_util.dart';
import '../../../feactures/user/domain/entities/user.dart';
import '../../../feactures/user/domain/use_cases/local_store.dart';
import '../../../feactures/user/presentation/modules/controllers.dart';
import '../../core/utils/algoritmo_TOTP_censo.dart';
import '../../data/models/models_censo.dart';
import '../../domain/request/request_censo.dart';
import '../../domain/usecases/get_datos_persona_censo.dart';
import '../../domain/usecases/local_store_censo.dart';
import 'totpCenso/totp_censo_controller.dart';

part 'menu/menu_app_censo_controller.dart';
part 'historial_censo/historial_censo_controller.dart';
part 'censo_policial/censo_policial_controller.dart';
part 'censista/censista_controller.dart';
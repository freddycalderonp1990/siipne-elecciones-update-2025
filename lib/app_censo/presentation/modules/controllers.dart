import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';


import '../../../app/core/exceptions/exception_dialogos.dart';
import '../../../app/core/utils/device_info_app.dart';
import '../../../app/core/utils/photo_helper.dart';

import '../../../app/core/utils/responsiveUtil.dart';
import '../../../app/presentation/widgets/custom_app_widgets.dart';

import '../../../feactures/gps/presentation/location/location_bloc.dart';
import '../../../feactures/save_file/data/models/file_model.dart';
import '../../../feactures/save_file/domain/request/file_request.dart';
import '../../../feactures/save_file/domain/use_cases/save_file_img_use_case.dart';

import '../../../feactures/user/domain/entities/user.dart';

import '../../../feactures/user/presentation/modules/controllers.dart';

import '../../data/models/models_censo.dart';
import '../../domain/request/request_censo.dart';
import '../../domain/usecases/censo_use_cases.dart';


import 'totpCenso/totp_censo_controller.dart';

part 'menu/menu_app_censo_controller.dart';
part 'historial_censo/historial_censo_controller.dart';
part 'censo_policial/censo_policial_controller.dart';
part 'censista/censista_controller.dart';
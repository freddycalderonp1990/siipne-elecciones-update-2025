import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import '../../../app/core/utils/device_info.dart';
import '../../../app/core/values/app_colors.dart';

import '../../../app/data/repository/data_repositories.dart';

import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../app_elecciones/core/values/siipne_images.dart';

import 'package:geolocator/geolocator.dart' as myGeolocator;

import '../../../app/core/app_config.dart';

import '../../../app/core/exceptions/exception_helper.dart';



import '../../../app/core/utils/check_internet_conexion.dart';
import '../../../app/core/utils/my_gps.dart';
import '../../../app/core/utils/photo_helper.dart';
import '../../../app/core/utils/responsiveUtil.dart';



import '../../../app/core/utils/encriptar_util.dart';


import '../../../app/presentation/blocs/location/location_bloc.dart';
import '../../../app/presentation/routes/app_routes.dart';


import '../../../app/presentation/widgets/custom_app_widgets.dart';
import '../../../feactures/saveFile/domain/request/file_request.dart';
import '../../../feactures/saveFile/domain/use_cases/save_file_img_use_case.dart';
import '../../../feactures/user/data/models/models_user.dart';
import '../../../feactures/user/domain/entities/user.dart';
import '../../../feactures/user/domain/request/request_user.dart';
import '../../../feactures/user/domain/use_cases/auth.dart';
import '../../../feactures/user/domain/use_cases/get_data_user.dart';

import '../../../feactures/user/domain/use_cases/local_store.dart';
import '../../data/providers/remote/apis/api_constantes.dart';
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
part 'tipos_servicios_ejes/tipos_servicios_ejes_controller.dart';

part 'recinto_electoral/crear_codigo/crear_codigo_recintos_controller.dart';
part 'unidades_policiales/crear_codigo/crear_codigo_unidad_poli_controller.dart';

part 'menu_recintos_electorales/jefe/menu_rec_elec_jefe_controller.dart';
part 'menu_recintos_electorales/integrante/menu_rec_elec_integrante_controller.dart';

part 'anexarse/anexarse_controller.dart';

part 'personal/add/add_person_controller.dart';
part 'personal/report/report_person_controller.dart';

part 'novedades/add/add_novedades_controller.dart';
part 'novedades/report/report_novedades_controller.dart';

part 'combo_dependiente/combo_dependiente_controller.dart';

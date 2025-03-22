


import 'dart:async';
import 'dart:convert';
import 'dart:io';



import 'package:app_mi_upc/app_mi_upc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../../../app/core/utils/utilidadesUtil.dart';
import '../../../app/presentation/widgets/custom_app_widgets.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../app_elecciones/presentation/widgets/customWidgets.dart';


import '../../../app_elecciones/core/siipne_config.dart';
import '../../../app_elecciones/core/values/mensajes_string.dart';
import '../../../app_elecciones/data/models/models.dart';
import '../../../app_elecciones/data/repository/data_repositories.dart';
import '../../../app_elecciones/domain/enums/enums.dart';

import '../../../app_elecciones/domain/request/request.dart';


import '../../../app_elecciones/presentation/modules/controllers.dart';
import '../../../app_elecciones/presentation/routes/siipne_routes.dart';
import '../../core/app_config.dart';
import '../../core/exceptions/exceptions.dart';
import '../../core/utils/device_info.dart';

import '../../core/utils/prints_msj.dart';
import '../../data/provider/providers_impl_app.dart';
import '../routes/app_routes.dart';






part 'splash/splash_controller.dart';
part 'bienvenido/bienvenido_controller.dart';
part 'home/home_controller.dart';
part 'pdf/pdf_view_controller.dart';



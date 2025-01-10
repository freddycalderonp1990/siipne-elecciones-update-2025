

import 'dart:async';
import 'dart:io';

import 'package:app_mi_upc/app_mi_upc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import 'package:get/get.dart';
import 'package:http/http.dart';
import '../../../app/core/utils/responsiveUtil.dart';

import '../../../app/core/values/app_images.dart';
import '../../../app/presentation/modules/splash/local_widget/loading_splash.dart';

import '../../../app_elecciones//core/siipne_config.dart';



import '../../../app_elecciones/data/models/models.dart';
import '../../../app_elecciones/domain/enums/enums.dart';
import '../../../app_elecciones/presentation/widgets/customWidgets.dart';



import '../../core/app_config.dart';

import '../../core/utils/encriptar_util.dart';
import '../../core/utils/my_qr.dart';
import '../../core/utils/utilidadesUtil.dart';
import '../../core/values/app_colors.dart';
import '../widgets/custom_app_widgets.dart';
import 'controllers.dart';
import 'home/local_widgets/desing_codigos_temporales.dart';





part 'splash/splash_page.dart';
part 'bienvenido/bienvenido_page.dart';
part 'home/home_page.dart';
part 'pdf/pdf_view_page.dart';





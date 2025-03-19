


import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siipnelecciones3/app/core/utils/utilidadesUtil.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:siipnelecciones3/app/core/values/app_colors.dart';
import 'package:siipnelecciones3/app/presentation/routes/app_routes.dart';

import 'package:siipnelecciones3/app/presentation/widgets/custom_app_widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:siipnelecciones3/app_elecciones/core/siipne_config.dart';
import 'package:siipnelecciones3/app_elecciones/presentation/modules/personal/report/local_widget/desing_personal.dart';

import 'package:siipnelecciones3/app_elecciones/presentation/routes/siipne_routes.dart';
import 'package:latlong2/latlong.dart' show LatLng;

import '../../../app/core/app_config.dart';



import '../../../app/core/utils/photo_helper.dart';
import '../../../app/core/values/app_images.dart';


import '../../../app/presentation/blocs/calculadora/calculadora_bloc.dart';
import '../../../app/presentation/blocs/gps/gps_bloc.dart';
import '../../../app/presentation/widgets/img_perfil_redonda.dart';
import '../../../app_elecciones//presentation/widgets/customWidgets.dart';



import 'package:get/get.dart';


import '../../core/values/siipne_colors.dart';
import '../../core/values/siipne_images.dart';
import '../../core/values/siipne_strings.dart';
import '../../data/models/models.dart';
import '../../domain/enums/enums.dart';
import '../widgets/gps_access_screen.dart';
import 'controllers.dart';
import '../../presentation/modules/login/local_widgets/wgLogin.dart';
import '../../../app/core/utils/responsiveUtil.dart';
import 'novedades/add/validate.dart';
import 'novedades/report/local_widget/desing_novedades.dart';




part 'login/login_page.dart';
part 'login/inicio_rapido/inicio_rapido_page.dart';
part 'menu/menu_app_page.dart';
part 'select_proceso_operativo/select_proceso_operativo_page.dart';
part 'tipos_servicios_ejes/tipos_servicios_ejes_page.dart';
part 'menu_recintos_electorales/menu_recintos_electorales_page.dart';
part 'anexarse/anexarse_page.dart';


part '1_RecintoElectoral/crear_codigo/crear_codigo_recintos_page.dart';
part 'unidades_policiales/crear_codigo/crear_codigo_unidad_poli_page.dart';

part 'personal/add/add_person_page.dart';
part 'personal/report/report_person_page.dart';

part 'novedades/add/add_novedades_page.dart';
part 'novedades/report/report_novedades_page.dart';
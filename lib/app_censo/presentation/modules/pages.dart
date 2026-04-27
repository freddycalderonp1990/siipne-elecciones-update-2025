import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:siipnemovil2/app_censo/data/models/models_censo.dart';
import 'package:siipnemovil2/app_censo/presentation/modules/bindings.dart';

import '../../../app/core/app_config.dart';
import '../../../app/core/utils/photo_helper.dart';
import '../../../app/core/utils/responsiveUtil.dart';
import '../../../app/core/values/app_colors.dart';
import '../../../app/core/values/app_images.dart';
import '../../../app/domain/enums/enums.dart';
import '../../../app/presentation/widgets/custom_app_widgets.dart';
import '../../../app/presentation/widgets/img_perfil_redonda.dart';
import '../../../app/services/bloc/notifications_bloc.dart';
import '../../../app_elecciones/core/values/siipne_images.dart';
import '../../../app_elecciones/core/values/siipne_strings.dart';
import '../../../app_elecciones/presentation/routes/elecciones_routes.dart';
import '../../../app_elecciones/presentation/widgets/customWidgets.dart';
import '../../../feactures/my_qr/presentation/widgets/qr_view_widget.dart';
import '../../core/values/app_censo_images.dart';
import '../../domain/request/request_censo.dart';
import '../routes/app_censo_routes.dart';
import '../widgets/custom_app_censo_widgets.dart';
import 'censista/validate_mesa/local_widget/desing_mapa.dart';
import 'controllers.dart';
import 'historial_censo/local_widgets/desing_history_censos.dart';

part 'menu/menu_app_censo_page.dart';
part 'historial_censo/historial_censo_page.dart';
part 'censo_policial/censo_policial_page.dart';
part 'censista/censista_page.dart';
part 'censista/validate_mesa/validate_mesa_page.dart';
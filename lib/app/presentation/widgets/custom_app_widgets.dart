import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';
import 'package:siipnelecciones3/app_elecciones/core/values/siipne_images.dart';
import 'package:latlong2/latlong.dart' show LatLng;


import '../../../app/core/utils/responsiveUtil.dart';
import '../../../app/core/utils/utilidadesUtil.dart';

import '../../../app_elecciones/presentation/widgets/customWidgets.dart';
import '../../core/app_config.dart';
import '../../core/utils/device_info.dart';
import '../../core/utils/photo_helper.dart';
import '../../core/values/app_colors.dart';
import '../../core/values/app_images.dart';


import '../blocs/location/location_bloc.dart';
import 'img_perfil_redonda.dart';


part 'btn_menu_img_widget.dart';

part 'btn_atras_widget.dart';
part 'cargando_widget.dart';
part 'icon_detalle_widget.dart';
part 'detalle_text_widget.dart';
part 'only_icon_widget.dart';
part 'contenedor_desing_widget.dart';
part 'imput_text_widget.dart';

part 'titulo_text_widget.dart';
part 'titulo_detalle_text_widget.dart';
part 'titulo_detalle_text_double_column_widget.dart';
part 'icon_title_detalle_widget.dart';
part 'botones_widget.dart';
part 'dialogos_desing_widget.dart';
part 'btn_icon_app_widget.dart';
part 'text_sobras_widget.dart';
part 'workAreaPageWidgetAndroid.dart';
part 'workAreaPageWidget.dart';
part 'workAreaPageLoginWidget.dart';


part 'combos/combo_busqueda.dart';
part 'combos/combo_con_busqueda.dart';
part 'my_ubicacion_widget.dart';

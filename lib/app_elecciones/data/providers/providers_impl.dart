
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'dart:typed_data';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../app/core/utils/parse_model.dart';
import '../../../app_elecciones/data/providers/remote/apis/api_constantes.dart';
import 'package:http/http.dart' as http;


import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';




import '../../../app/core/app_config.dart';
import '../../../app/core/exceptions/exceptions.dart';
import '../../../app/data/provider/providers_impl_app.dart';



import '../../../app/core/exceptions/exception_helper.dart';



import '../../core/utils/photo_helper.dart';

import '../../data/models/models.dart';
import '../../domain/enums/enums.dart';
import '../../domain/repositories/domain_repositories.dart';
import '../../domain/request/request.dart';


part 'remote/apis/responseApi.dart';
part 'remote/apis/host/host_siipne_elecciones.dart';

part 'remote/apis/elecciones_procesos_api_provider.dart';
part 'remote/apis/elecciones_recintos_api_provider.dart';
part 'remote/apis/elecciones_tipo_ejes_api_provider.dart';
part 'remote/apis/elecciones_novedades_api_provider.dart';


part 'remote/apis/host/url_api_provider_siipne_movil.dart';


part 'remote/apis/persona_api_provider.dart';













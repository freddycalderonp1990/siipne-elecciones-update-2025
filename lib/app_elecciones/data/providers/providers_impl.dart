
import 'dart:async';


import 'package:api_provider/core/exceptions/exception_helper.dart';
import 'package:api_provider/data/data_source/providers_impl_app.dart';
import 'package:api_provider/data/data_source/remote/apis/host/host_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


import '../../../app_elecciones/data/providers/remote/apis/api_constantes.dart';







import '../../data/models/models.dart';

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













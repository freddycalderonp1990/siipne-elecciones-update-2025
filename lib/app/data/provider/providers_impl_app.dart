
import 'dart:async';
import 'dart:convert';
import 'dart:developer';



import 'dart:io' as doc;
import 'dart:typed_data';

//NECESARIOS PARA SUBIR ARCHIVOS
import 'package:async/async.dart'; //DelegatingStream
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siipnemovil2/app/data/model/models.dart';
import 'package:siipnemovil2/feactures/user/domain/use_cases/local_store.dart';


import '../../../app_elecciones/core/utils/photo_helper.dart';
import '../../../app_elecciones/data/models/models.dart';
import '../../../app_elecciones/domain/enums/enums.dart';
import '../../../app_elecciones/domain/repositories/domain_repositories.dart';
import '../../../feactures/user/domain/entities/user.dart';
import '../../core/app_config.dart';
import '../../core/exceptions/exception_helper.dart';
import '../../core/exceptions/exceptions.dart';
import '../../core/utils/parse_model.dart';
import '../../core/utils/prints_msj.dart';
import '../../domain/repositories/domain_repositories.dart';



part 'remote/apis/host/host_app.dart';
part 'remote/apis/host/cabecera_json_model.dart';
part 'remote/apis/host/url_api_provider_app.dart';









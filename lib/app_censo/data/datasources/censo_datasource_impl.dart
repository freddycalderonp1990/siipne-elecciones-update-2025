
import 'dart:convert';

import 'package:api_provider/core/exceptions/exception_helper.dart';
import 'package:api_provider/data/data_source/providers_impl_app.dart';
import 'package:api_provider/data/data_source/remote/apis/host/host_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:siipnemovil2/app_censo/data/datasources/remote/apis/censo_api_constantes.dart';

import '../../domain/request/request_censo.dart';
import '../models/models_censo.dart';

part 'remote/apis/host/host_app_censo.dart';
part 'remote/apis/host/url_api_provider_app_censo.dart';

part 'remote/apis/censo_remote_data_source.dart';
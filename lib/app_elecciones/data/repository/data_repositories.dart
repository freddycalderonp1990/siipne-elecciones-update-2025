
import 'dart:typed_data';

import 'package:siipnelecciones3/app/core/app_config.dart';
import 'package:siipnelecciones3/app/core/values/app_mocks.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' as rootBundle;



import '../../../app/core/exceptions/exception_helper.dart';
import '../../../app/core/exceptions/exceptions.dart';
import '../../data/models/models.dart';
import '../../data/providers/providers_impl.dart';
import '../../domain/repositories/domain_repositories.dart';
import '../../domain/request/request.dart';



part 'remote/apis/auth_api_impl.dart';

part 'remote/apis/procesos_elecciones_api_impl.dart';



part 'local/local_store_impl.dart';

// ignore_for_file: library_prefixes

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nodes/core/controller/nav_controller.dart';
import 'package:nodes/core/services/local_storage.dart';
import 'package:nodes/features/auth/repo/auth_repository.dart';
import 'package:nodes/features/auth/service/auth_service.dart';
import 'package:nodes/features/auth/view_model/auth_controller.dart';
import 'package:nodes/features/community/repo/community_repository.dart';
import 'package:nodes/features/community/service/community_service.dart';
import 'package:nodes/features/community/view_model/community_controller.dart';
import 'package:nodes/interceptor/http_dio_interceptor.dart';

import 'env.config.dart' as envConfig;

final locator = GetIt.instance;

const baseUrl = envConfig.API_ENDPOINT;

void setUpLocator() {
  locator.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
  locator.registerSingleton<ImagePicker>(ImagePicker());
  locator.registerSingleton<LocalStorageService>(
      LocalStorageService(locator.get<FlutterSecureStorage>()));

  locator.registerSingleton<HttpDioInterceptors>(HttpDioInterceptors());

  locator.registerSingleton<Dio>(Dio());

  //repository
  locator.registerSingleton<AuthRepository>(
    AuthRepository(
      dioConfig(),
    ),
  );
  locator.registerSingleton<ComRepository>(
    ComRepository(
      dioConfig(),
    ),
  );

  // services
  locator.registerSingleton<AuthService>(
    AuthService(
      locator.get<AuthRepository>(),
    ),
  );
  locator.registerSingleton<ComService>(
    ComService(
      locator.get<ComRepository>(),
    ),
  );

  // controller
  locator.registerSingleton<AuthController>(
    AuthController(
      locator.get<AuthService>(),
      locator.get<LocalStorageService>(),
    ),
  );
  locator.registerSingleton<ComController>(
    ComController(
      locator.get<ComService>(),
    ),
  );
  locator.registerSingleton<NavController>(
    NavController(),
  );
}

Dio dioConfig() {
  Dio dio = locator<Dio>();
  dio.interceptors.add(locator<HttpDioInterceptors>());

  dio.options.baseUrl = baseUrl;
  dio.options.connectTimeout = const Duration(milliseconds: 20000);
  dio.options.sendTimeout = const Duration(milliseconds: 10000);

  return dio;
}

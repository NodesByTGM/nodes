import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:nodes/utilities/constants/key_strings.dart';
import 'package:nodes/config/dependencies.dart';
import 'package:nodes/core/services/local_storage.dart';
import 'package:nodes/core/models/current_session.dart';

class HttpDioInterceptors extends InterceptorsWrapper {
  final log = Logger("HttpDioInterceptors");

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Get the token::::::
    var localStorageService = locator<LocalStorageService>();
    Map<String, dynamic>? jsonModel =
        await localStorageService.getSecureJson(KeyString.currentSession);
    if (jsonModel != null && jsonModel['access'] != null) {
      // put it back later sha...
      CurrentSession session = CurrentSession.fromJson(jsonModel);
      options.headers["Authorization"] = "Bearer ${session.access}";
      options.headers["content-type"] = 'application/json';
      options.headers["accept"] = 'application/json';

      // log.info("REQUEST DATA ${options.baseUrl}");
      // log.info("REQUEST DATA ${options.uri.toString()}");
      // log.info("REQUEST DATA ${options.path}");
      // log.info("REQUEST DATA ${options.headers}");
      // log.info("REQUEST DATA ${options.data}");
      return handler.next(options);
    }
    log.info("REQUEST DATA ${options.path}");
    log.info("REQUEST DATA ${options.data}");
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    return handler.next(err);
  }
}

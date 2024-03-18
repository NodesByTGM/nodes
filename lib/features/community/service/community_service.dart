// ignore_for_file: non_constant_identifier_names


import 'package:logging/logging.dart';
import 'package:nodes/config/dependencies.dart';
import 'package:nodes/core/services/local_storage.dart';
import 'package:nodes/features/community/repo/community_repository.dart';

class ComService {
  final log = Logger('ComService');

  final ComRepository comRepository;

  ComService(this.comRepository);

  final localStorageService = locator.get<LocalStorageService>();

  // Functions
  // Future<ApiResponse> login(LoginDetails payload) async {
  //   try {
  //     ApiResponse res = await ComRepository.login(payload);
  //     return res;
  //   } on DioException catch (e) {
  //     log.severe("Error message @login User ::===> ${e.response?.data}");
  //     return NetworkException.errorHandler(e);
  //   }
  // }

}

import 'package:hip_quest/data/controller/BaseController.dart';
import 'package:hip_quest/data/dataSource/remote/dio/DioClient.dart';
import 'package:hip_quest/data/dataSource/remote/exception/ApiErrorHandler.dart';
import 'package:hip_quest/data/model/response/base/ApiResponse.dart';
import 'package:hip_quest/util/AppConstants.dart';

class RegisterController extends BaseController {
  final DioClient dioClient;

  RegisterController({required this.dioClient});

  Future<ApiResponse> register(Map<String, String?> mobileData, context) async {
    showLoader(context);
    try {
      final response = await dioClient.post(AppConstants.register, data: mobileData);
      dismissLoader(context);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      dismissLoader(context);
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}

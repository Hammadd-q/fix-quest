import 'package:hip_quest/data/controller/BaseController.dart';
import 'package:hip_quest/data/dataSource/remote/dio/DioClient.dart';
import 'package:hip_quest/data/dataSource/remote/exception/ApiErrorHandler.dart';
import 'package:hip_quest/data/model/response/base/ApiResponse.dart';
import 'package:hip_quest/util/AppConstants.dart';

class ForgotController extends BaseController {
  final DioClient dioClient;

  ForgotController({required this.dioClient});

  Future<ApiResponse> forgot(Map<String, dynamic> data, context) async {
    showLoader(context);
    try {
      final response = await dioClient.post(AppConstants.forgotPassword, data: data);
      dismissLoader(context);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      dismissLoader(context);
      return ApiResponse.withError(ApiErrorHandler.getMessage(e, isLogin: true));
    }
  }
}

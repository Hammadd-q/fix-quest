import 'package:hip_quest/data/controller/BaseController.dart';
import 'package:hip_quest/data/dataSource/remote/dio/DioClient.dart';
import 'package:hip_quest/data/dataSource/remote/exception/ApiErrorHandler.dart';
import 'package:hip_quest/data/model/response/base/ApiResponse.dart';
import 'package:hip_quest/util/AppConstants.dart';

class ChangePasswordController extends BaseController {
  final DioClient dioClient;

  ChangePasswordController({required this.dioClient});

  Future<ApiResponse> changePassword(Map<String, dynamic> data, context) async {
    showLoader(context);
    try {
      final response = await dioClient.post(AppConstants.changePassword, data: data);
      dismissLoader(context);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      dismissLoader(context);
      return ApiResponse.withError(ApiErrorHandler.getMessage(e, isLogin: true));
    }
  }
}

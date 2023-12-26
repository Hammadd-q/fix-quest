import 'package:hip_quest/data/controller/BaseController.dart';
import 'package:hip_quest/data/dataSource/remote/dio/DioClient.dart';
import 'package:hip_quest/data/dataSource/remote/exception/ApiErrorHandler.dart';
import 'package:hip_quest/data/model/response/base/ApiResponse.dart';
import 'package:hip_quest/util/AppConstants.dart';

class FreePdfController extends BaseController {
  final DioClient dioClient;

  FreePdfController({required this.dioClient});

  Future<ApiResponse> freeResource(context) async {
    showLoader(context);
    try {
      final response = await dioClient.get(AppConstants.freeResource);
      dismissLoader(context);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      dismissLoader(context);
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}

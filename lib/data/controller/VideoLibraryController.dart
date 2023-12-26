import 'package:hip_quest/data/controller/BaseController.dart';
import 'package:hip_quest/data/data.dart';
import 'package:hip_quest/data/dataSource/remote/dio/DioClient.dart';
import 'package:hip_quest/data/dataSource/remote/exception/ApiErrorHandler.dart';
import 'package:hip_quest/data/model/response/base/ApiResponse.dart';
import 'package:hip_quest/util/AppConstants.dart';

class VideoLibraryController extends BaseController {
  final DioClient dioClient;

  VideoLibraryController({required this.dioClient});

  Future<ApiResponse> videoLibrary(context) async {
    showLoader(context);
    try {
      final response = await dioClient.get(AppConstants.videoLibrary);
      dismissLoader(context);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      dismissLoader(context);
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> meetingLibrary(context) async {
    showLoader(context);
    try {
      final response = await dioClient
          .get("${AppConstants.stagingurl}member_meetings?user_id=$userid");
      dismissLoader(context);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      dismissLoader(context);
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}

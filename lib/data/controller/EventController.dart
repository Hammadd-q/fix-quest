import 'package:hip_quest/data/controller/BaseController.dart';
import 'package:hip_quest/data/dataSource/remote/dio/DioClient.dart';
import 'package:hip_quest/data/dataSource/remote/exception/ApiErrorHandler.dart';
import 'package:hip_quest/data/model/response/base/ApiResponse.dart';
import 'package:hip_quest/util/AppConstants.dart';

class EventController extends BaseController {
  final DioClient dioClient;

  EventController({required this.dioClient});

  Future<ApiResponse> events(context) async {
    showLoader(context);
    try {
      final response = await dioClient.get(AppConstants.events);
      dismissLoader(context);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      dismissLoader(context);
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> event(evenId, context) async {
    showLoader(context);
    try {
      final response = await dioClient.get(AppConstants.post.replaceFirst('{postId}', evenId.toString()));
      dismissLoader(context);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      dismissLoader(context);
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}

import 'package:hip_quest/data/controller/BaseController.dart';
import 'package:hip_quest/data/dataSource/remote/dio/DioClient.dart';
import 'package:hip_quest/data/dataSource/remote/exception/ApiErrorHandler.dart';
import 'package:hip_quest/data/model/response/base/ApiResponse.dart';
import 'package:hip_quest/util/AppConstants.dart';

class ChatUserController extends BaseController {
  final DioClient dioClient;

  ChatUserController({required this.dioClient});

  Future<ApiResponse> chatUsers(context) async {
    showLoader(context);
    try {
      final response = await dioClient.get(AppConstants.chatUsers);
      dismissLoader(context);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      dismissLoader(context);
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  // Future<ApiResponse> chatUser(userId, context) async {
  //   showLoader(context);
  //   try {
  //     final response = await dioClient.get(AppConstants.post.replaceFirst('{postId}', userId));
  //     dismissLoader(context);
  //     return ApiResponse.withSuccess(response);
  //   } catch (e) {
  //     dismissLoader(context);
  //     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
  //   }
  // }
}

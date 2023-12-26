import 'package:hip_quest/data/controller/BaseController.dart';
import 'package:hip_quest/data/dataSource/remote/dio/DioClient.dart';
import 'package:hip_quest/data/dataSource/remote/exception/ApiErrorHandler.dart';
import 'package:hip_quest/data/model/response/base/ApiResponse.dart';
import 'package:hip_quest/util/AppConstants.dart';

class EbookController extends BaseController {
  final DioClient dioClient;

  EbookController({required this.dioClient});

  Future<ApiResponse> ebook(ebookId, context) async {
    showLoader(context);
    try {
      final response = await dioClient.get(AppConstants.ebook.replaceFirst('{ebookId}', ebookId.toString()));
      dismissLoader(context);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      dismissLoader(context);
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}

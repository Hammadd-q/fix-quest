import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hip_quest/data/controller/BaseController.dart';
import 'package:hip_quest/data/dataSource/remote/dio/DioClient.dart';
import 'package:hip_quest/data/dataSource/remote/exception/ApiErrorHandler.dart';
import 'package:hip_quest/data/model/response/base/ApiResponse.dart';
import 'package:hip_quest/util/AppConstants.dart';

class CourseController extends BaseController {
  final DioClient dioClient;

  CourseController({required this.dioClient});

  Future<ApiResponse> courseDetail(courseId, context) async {
    showLoader(context);
    try {
      final response = await dioClient.get(AppConstants.course.replaceFirst('{courseId}', courseId.toString()));
      dismissLoader(context);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      dismissLoader(context);
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> courseProgress(userId, courseId, context) async {
    showLoader(context);
    try {
      String username = 'ck_649b05009a236fe1e72c1c101a5535b865fffb44';
      String password = 'cs_e348f09edea6c364d67207396dc47d42d9714e42';
      String basicAuth = 'Basic ${base64.encode(utf8.encode('$username:$password'))}';
      var url = AppConstants.courseProgress.replaceFirst('{courseId}', courseId.toString()).replaceFirst("{id}", userId.toString());
      final response = await dioClient.get(url, options: Options(headers: <String, String>{'authorization': basicAuth}));
      dismissLoader(context);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      dismissLoader(context);
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> courseSections(courseId, context) async {
    showLoader(context);
    try {
      final response = await dioClient.get(AppConstants.courseSections.replaceFirst('{courseId}', courseId.toString()));
      dismissLoader(context);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      dismissLoader(context);
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> courseSection(sectionId, context) async {
    String username = 'ck_649b05009a236fe1e72c1c101a5535b865fffb44';
    String password = 'cs_e348f09edea6c364d67207396dc47d42d9714e42';
    String basicAuth = 'Basic ${base64.encode(utf8.encode('$username:$password'))}';
    showLoader(context);
    try {
      var url = AppConstants.courseSection.replaceFirst('{sectionId}', sectionId.toString());
      final response = await dioClient.get(url, options: Options(headers: <String, String>{'authorization': basicAuth}));
      dismissLoader(context);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      dismissLoader(context);
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}

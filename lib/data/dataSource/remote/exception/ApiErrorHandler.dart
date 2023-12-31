import 'package:dio/dio.dart';
import 'package:hip_quest/data/model/response/base/ErrorResponse.dart';

class ApiErrorHandler {
  static dynamic getMessage(error, {bool isLogin = false}) {
    dynamic errorDescription = "";
    if (error is Exception) {
      try {
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              errorDescription = "Request to API server was cancelled";
              break;
            case DioErrorType.connectTimeout:
              errorDescription = "Connection timeout with API server";
              break;
            case DioErrorType.other:
              errorDescription = "Connection to API server failed due to internet connection";
              break;
            case DioErrorType.receiveTimeout:
              errorDescription = "Receive timeout in connection with API server";
              break;
            case DioErrorType.response:
              if (error.response != null) {
                switch (error.response?.statusCode) {
                  case 404:
                    errorDescription = error.response?.data['message'] ?? '';
                    break;
                  case 400:
                    errorDescription = error.response?.data['message'] ?? '';
                    break;
                  case 401:
                    errorDescription = error.response?.data['message'] ?? '';
                    break;
                  case 500:
                    errorDescription = error.response?.data['message'] ?? '';
                    break;
                  case 503:
                    errorDescription = error.response?.data['message'] ?? '';
                   // errorDescription = error.response?.statusMessage;
                    break;
                  default:
                    ErrorResponse errorResponse = ErrorResponse.fromJson(error.response?.data);
                    if (errorResponse.errors.isNotEmpty) {
                      errorDescription = errorResponse;
                    } else {
                      errorDescription = "Failed to load data - status code: ${error.response?.statusCode}";
                    }
                }
              } else {
                errorDescription = "Unknown Error";
              }
              break;
            case DioErrorType.sendTimeout:
              errorDescription = "Send timeout with server";
              break;
          }
        } else {
          errorDescription = "Unexpected error occurred";
        }
      } on FormatException catch (e) {
        errorDescription = e.toString();
      }
    } else {
      errorDescription = "is not a subtype of exception";
    }
    return errorDescription;
  }
}

import 'package:dio/dio.dart';

import 'resource.dart';

class ExceptionUtil {
  static Resource<T> handleDioException<T>(DioException e) {
    String errorMessage;
    int? errorCode;

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        errorMessage = 'Connection Timeout\n${e.message}';
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = 'Send Timeout\n${e.message}';
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = 'Receive Timeout\n${e.message}';
        break;
      case DioExceptionType.badCertificate:
        errorMessage = 'Bad Certificate Timeout\n${e.message}';
        break;
      case DioExceptionType.badResponse:
        errorMessage = 'Bad Response ${e.response?.statusCode}\n${e.message}';
        errorCode = e.response?.statusCode;
        break;
      case DioExceptionType.cancel:
        errorMessage = 'Request Cancelled\n${e.message}';
        break;
      case DioExceptionType.connectionError:
        errorMessage = 'Connection Error\n${e.message}';
        break;
      case DioExceptionType.unknown:
        errorMessage = 'Unknown\n${e.message}';
        break;
    }

    return Resource.error(errorMessage, errorCode);
  }
}

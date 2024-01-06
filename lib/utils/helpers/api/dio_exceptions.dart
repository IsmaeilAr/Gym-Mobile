import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        message = _handleError(
            dioError.response!.statusCode, dioError.response!.data);
        break;
      case DioExceptionType.unknown:
        message = "Connection to API server failed due to internet connection";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  late String message;

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 404:
        return 'Not Found';
      case 401:
        return getErrorMessage(error);
      case 500:
        return 'Internal server error';
      default:
        return getErrorMessage(error);
    }
  }

  getErrorMessage(error) {
    // var data = json.decode(error.toString());
    // String email =  error['email'].toString() !="[]"? error['email'][0] +"," : "";
    // String password =  error['password'].toString() !="[]" ?error['password'][0]??[]:"";
    String message = error
        .toString()
        .replaceAll("]", "")
        .replaceAll("[", "")
        .replaceAll("{", "")
        .replaceAll("}", "")
        .replaceAll(":", "");
    return message;
  }

  @override
  String toString() => message;
}

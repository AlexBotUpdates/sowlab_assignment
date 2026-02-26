import 'dart:io';
import 'package:dio/dio.dart';
import 'package:sowlab_app/core/errors/failures.dart';

class ApiErrorHandler {
  static Failure handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return NetworkFailure("Connection timed out. Please check your internet.");
        case DioExceptionType.badResponse:
          return _handleBadResponse(error);
        case DioExceptionType.cancel:
          return ServerFailure("Request was cancelled.");
        case DioExceptionType.connectionError:
          return NetworkFailure("No Internet Connection.");
        case DioExceptionType.unknown:
          if (error.error is SocketException) {
            return NetworkFailure("Slow or no internet connection.");
          }
          return ServerFailure("An unexpected error occurred.");
        default:
          return ServerFailure("Something went wrong.");
      }
    }
    return ServerFailure(error.toString());
  }

  static Failure _handleBadResponse(DioException error) {
    final statusCode = error.response?.statusCode;
    final message = error.response?.data?['message'] ?? "Server error occurred";

    switch (statusCode) {
      case 400:
        return ValidationFailure(message);
      case 401:
        return AuthFailure("Unauthorized: Please login again.");
      case 403:
        return AuthFailure("Forbidden: You don't have access.");
      case 404:
        return ServerFailure("Endpoint not found.");
      case 500:
        return ServerFailure("Internal Server Error. Please try later.");
      default:
        return ServerFailure(message);
    }
  }
}

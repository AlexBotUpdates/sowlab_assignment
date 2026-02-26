import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  final int retryIntervalInMs;

  RetryInterceptor({
    required this.dio,
    this.maxRetries = 3,
    this.retryIntervalInMs = 1000,
  });

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    var requestOptions = err.requestOptions;
    
    // Check if we should retry
    if (_shouldRetry(err)) {
      try {
        final retryCount = (requestOptions.extra['retryCount'] ?? 0) + 1;
        
        if (retryCount <= maxRetries) {
          requestOptions.extra['retryCount'] = retryCount;
          
          // Wait before retrying
          await Future.delayed(Duration(milliseconds: retryIntervalInMs));
          
          // Retry the request
          final response = await dio.fetch(requestOptions);
          return handler.resolve(response);
        }
      } catch (e) {
        return handler.next(err);
      }
    }
    
    return super.onError(err, handler);
  }

  bool _shouldRetry(DioException err) {
    return err.type != DioExceptionType.cancel &&
        err.type != DioExceptionType.badResponse &&
        err.response?.statusCode != 401 &&
        err.response?.statusCode != 403;
  }
}

import 'package:dio/dio.dart';
import 'dart:io';

class ConnectivityInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      // Use the target host itself instead of a third-party domain
      final uri = Uri.parse(options.baseUrl);
      final result = await InternetAddress.lookup(uri.host)
          .timeout(const Duration(seconds: 5));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return handler.next(options);
      }
    } on SocketException catch (_) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: "No Internet Connection",
          type: DioExceptionType.connectionError,
        ),
      );
    } catch (_) {
      // Timeout or other DNS error — let Dio's own timeout handle it
      return handler.next(options);
    }
    return handler.next(options);
  }
}

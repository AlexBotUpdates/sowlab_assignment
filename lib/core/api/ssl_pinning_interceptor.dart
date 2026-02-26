import 'package:dio/dio.dart';

class SslPinningInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // SSL Pinning placeholder: In production, implement certificate
    // pinning via native configuration or a package like dio_certificate_pinning.
    // No-op for now — passes requests through.
    return handler.next(options);
  }
}

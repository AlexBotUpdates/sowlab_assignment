import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sowlab_app/core/api/auth_interceptor.dart';
import 'package:sowlab_app/core/api/connectivity_interceptor.dart';
import 'package:sowlab_app/core/api/retry_interceptor.dart';
import 'package:sowlab_app/core/api/ssl_pinning_interceptor.dart';
import 'package:sowlab_app/core/config/env_config.dart';

class DioClient {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  DioClient(this._storage)
      : _dio = Dio(BaseOptions(
          baseUrl: EnvConfig.dev.baseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          headers: {
            'Accept': 'application/json',
          },
        )) {
    _initializeInterceptors();
  }

  void _initializeInterceptors() {
    _dio.interceptors.addAll([
      // 1. Connectivity Check (Fast Fail)
      ConnectivityInterceptor(),

      // 2. Security: SSL Pinning
      SslPinningInterceptor(),

      // 3. Auth: Token Attachment & 401
      AuthInterceptor(_storage),

      // 4. Resilience: Retry Logic
      RetryInterceptor(dio: _dio),

      // 5. Logging: Debug only
      if (kDebugMode)
        LogInterceptor(
          requestHeader: true,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          error: true,
        ),
    ]);
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Dio get instance => _dio;
}

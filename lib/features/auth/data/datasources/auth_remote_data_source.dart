import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:sowlab_app/core/api/dio_client.dart';
import 'package:sowlab_app/core/errors/exceptions.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> login(String email, String password);
  Future<Map<String, dynamic>> register(Map<String, dynamic> params);
  Future<Map<String, dynamic>> forgotPassword(String email);
  Future<Map<String, dynamic>> verifyOtp(String email, String otp);
  Future<Map<String, dynamic>> resetPassword(
      String email, String otp, String newPassword);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient _client;

  AuthRemoteDataSourceImpl(this._client);

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    // 1️⃣ Fix login() - discovery: backend needs extra fields for standard email login
    final response = await _client.post('user/login', data: {
      'email': email,
      'password': password,
      'role': 'farmer', // Required per backend requirements
      'type': 'email', // Required per backend requirements
      'social_id': 'NA', // Required per backend requirements
    });
    return _processResponse(response);
  }

  @override
  Future<Map<String, dynamic>> register(Map<String, dynamic> params) async {
    final Map<String, dynamic> data = Map.from(params);

    // 1. Inject required constants
    data['role'] = 'farmer';
    data['type'] = 'email';
    data['social_id'] = 'NA';

    // 2. Normalize Keys
    if (data.containsKey('name')) {
      data['full_name'] = data.remove('name');
    }

    // 3. Encode nested structures
    if (data['business_hours'] != null && data['business_hours'] is! String) {
      data['business_hours'] = jsonEncode(data['business_hours']);
    }

    // 4. Safely construct the FormData payload
    final formData = FormData();

    for (var entry in data.entries) {
      if (entry.value == null) continue;

      if (entry.key == 'registration_proof') {
        final filePath = entry.value.toString();
        if (filePath.isNotEmpty) {
          formData.files.add(MapEntry(
            entry.key,
            await MultipartFile.fromFile(
              filePath,
              filename: filePath.split('/').last,
            ),
          ));
        }
      } else {
        // ENFORCE robust string-only evaluation to prevent silent dropping by Dio
        formData.fields.add(MapEntry(entry.key, entry.value.toString()));
      }
    }

    // 5. Send with Explicit Form-Data Options
    final response = await _client.post(
      'user/register',
      data: formData,
      options: Options(
        // Guarantee boundary attachment and prevent JSON mutation
        contentType: 'multipart/form-data',
      ),
    );

    return _processResponse(response);
  }

  @override
  Future<Map<String, dynamic>> forgotPassword(String email) async {
    final response =
        await _client.post('user/forgot-password', data: {'email': email});
    return _processResponse(response);
  }

  @override
  Future<Map<String, dynamic>> verifyOtp(String email, String otp) async {
    final response = await _client.post('user/verify-otp', data: {
      'email': email,
      'otp': otp,
    });
    return _processResponse(response);
  }

  @override
  Future<Map<String, dynamic>> resetPassword(
      String email, String otp, String newPassword) async {
    final response = await _client.post('user/reset-password', data: {
      'email': email,
      'otp': otp,
      'password': newPassword,
    });
    return _processResponse(response);
  }

  // 3️⃣ Improved success validation and error handling
  Map<String, dynamic> _processResponse(Response response) {
    final data = response.data;

    if (data is! Map<String, dynamic>) {
      throw ServerException(message: "Invalid response format from server");
    }

    // Enterprise Rule: Check the 'success' flag in the body robustly
    // Discovery: Backend sometimes sends bool true/false, sometimes string "true"/"false"
    final rawSuccess = data['success'];
    bool isSuccess = false;

    if (rawSuccess is bool) {
      isSuccess = rawSuccess;
    } else if (rawSuccess is String) {
      isSuccess = rawSuccess.toLowerCase() == "true";
    }

    if (!isSuccess) {
      // Safe error message extraction
      final message = data['message'] ??
          data['error'] ??
          "An unexpected server error occurred";
      throw ServerException(message: message.toString());
    }

    return data;
  }
}

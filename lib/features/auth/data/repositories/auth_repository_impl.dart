import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sowlab_app/core/api/api_error_handler.dart';
import 'package:sowlab_app/core/errors/failures.dart';
import 'package:sowlab_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:sowlab_app/features/auth/data/models/user_model.dart';
import 'package:sowlab_app/features/auth/domain/entities/user_entity.dart';
import 'package:sowlab_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final FlutterSecureStorage _storage;

  AuthRepositoryImpl(this._remoteDataSource, this._storage);

  @override
  Future<Either<Failure, UserEntity>> login(
      String email, String password) async {
    try {
      final result = await _remoteDataSource.login(email, password);

      // Robust Token Extraction
      final token = result['token'] ?? result['data']?['token'];
      if (token != null && token.toString().isNotEmpty) {
        await _storage.write(key: 'access_token', value: token.toString());
      } else {
        return Left(ServerFailure("Login successful but no token received"));
      }

      final userData = result['data'] ?? result;
      final userModel = UserModel.fromJson(userData);
      return Right(userModel.toEntity());
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, void>> register(Map<String, dynamic> params) async {
    try {
      await _remoteDataSource.register(params);
      return const Right(null);
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, void>> forgotPassword(String email) async {
    try {
      await _remoteDataSource.forgotPassword(email);
      return const Right(null);
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, void>> verifyOtp(String email, String otp) async {
    try {
      await _remoteDataSource.verifyOtp(email, otp);
      return const Right(null);
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(
      String email, String otp, String newPassword) async {
    try {
      await _remoteDataSource.resetPassword(email, otp, newPassword);
      return const Right(null);
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<void> logout() async {
    await _storage.delete(key: 'access_token');
  }
}

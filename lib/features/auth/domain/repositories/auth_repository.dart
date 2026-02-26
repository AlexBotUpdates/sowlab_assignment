import 'package:dartz/dartz.dart';
import 'package:sowlab_app/core/errors/failures.dart';
import 'package:sowlab_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(String email, String password);
  Future<Either<Failure, void>> register(Map<String, dynamic> params);
  Future<Either<Failure, void>> forgotPassword(String email);
  Future<Either<Failure, void>> verifyOtp(String email, String otp);
  Future<Either<Failure, void>> resetPassword(String email, String otp, String newPassword);
  Future<void> logout();
}

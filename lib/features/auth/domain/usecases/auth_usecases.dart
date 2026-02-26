import 'package:dartz/dartz.dart';
import 'package:sowlab_app/core/errors/failures.dart';
import 'package:sowlab_app/features/auth/domain/entities/user_entity.dart';
import 'package:sowlab_app/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;
  LoginUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call(String email, String password) {
    return repository.login(email, password);
  }
}

class RegisterUseCase {
  final AuthRepository repository;
  RegisterUseCase(this.repository);

  Future<Either<Failure, void>> call(Map<String, dynamic> params) {
    return repository.register(params);
  }
}

class ForgotPasswordUseCase {
  final AuthRepository repository;
  ForgotPasswordUseCase(this.repository);

  Future<Either<Failure, void>> call(String email) {
    return repository.forgotPassword(email);
  }
}

class VerifyOtpUseCase {
  final AuthRepository repository;
  VerifyOtpUseCase(this.repository);

  Future<Either<Failure, void>> call(String email, String otp) {
    return repository.verifyOtp(email, otp);
  }
}

class ResetPasswordUseCase {
  final AuthRepository repository;
  ResetPasswordUseCase(this.repository);

  Future<Either<Failure, void>> call(String email, String otp, String newPassword) {
    return repository.resetPassword(email, otp, newPassword);
  }
}

class LogoutUseCase {
  final AuthRepository repository;
  LogoutUseCase(this.repository);

  Future<void> call() {
    return repository.logout();
  }
}

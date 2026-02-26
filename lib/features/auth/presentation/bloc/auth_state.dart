import 'package:sowlab_app/features/auth/domain/entities/user_entity.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthAuthenticated extends AuthState {
  final UserEntity user;
  AuthAuthenticated(this.user);
}

final class AuthUnauthenticated extends AuthState {}

final class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

final class AuthOtpSent extends AuthState {
  final String email;
  AuthOtpSent(this.email);
}

final class AuthOtpVerified extends AuthState {
  final String email;
  final String otp;
  AuthOtpVerified(this.email, this.otp);
}

final class AuthPasswordResetSuccess extends AuthState {}

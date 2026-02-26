import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sowlab_app/features/auth/domain/usecases/auth_usecases.dart';
import 'package:sowlab_app/features/auth/presentation/bloc/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final VerifyOtpUseCase _verifyOtpUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final LogoutUseCase _logoutUseCase;

  AuthCubit({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required ForgotPasswordUseCase forgotPasswordUseCase,
    required VerifyOtpUseCase verifyOtpUseCase,
    required ResetPasswordUseCase resetPasswordUseCase,
    required LogoutUseCase logoutUseCase,
  })  : _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        _forgotPasswordUseCase = forgotPasswordUseCase,
        _verifyOtpUseCase = verifyOtpUseCase,
        _resetPasswordUseCase = resetPasswordUseCase,
        _logoutUseCase = logoutUseCase,
        super(AuthInitial());

  // Helper to wrap execution with safety
  Future<void> _safeExecute(Future<void> Function() action) async {
    try {
      await action();
    } catch (e) {
      emit(AuthError("An unexpected system error occurred. Please try again later."));
    }
  }

  Future<void> login(String email, String password) async {
    await _safeExecute(() async {
      emit(AuthLoading());
      final result = await _loginUseCase(email, password);
      result.fold(
        (failure) => emit(AuthError(failure.message)),
        (user) => emit(AuthAuthenticated(user)),
      );
    });
  }

  Future<void> register(Map<String, dynamic> params) async {
    await _safeExecute(() async {
      emit(AuthLoading());
      final result = await _registerUseCase(params);
      result.fold(
        (failure) => emit(AuthError(failure.message)),
        (_) => emit(AuthUnauthenticated()),
      );
    });
  }

  Future<void> forgotPassword(String email) async {
    await _safeExecute(() async {
      emit(AuthLoading());
      final result = await _forgotPasswordUseCase(email);
      result.fold(
        (failure) => emit(AuthError(failure.message)),
        (_) => emit(AuthOtpSent(email)),
      );
    });
  }

  Future<void> verifyOtp(String email, String otp) async {
    await _safeExecute(() async {
      emit(AuthLoading());
      final result = await _verifyOtpUseCase(email, otp);
      result.fold(
        (failure) => emit(AuthError(failure.message)),
        (_) => emit(AuthOtpVerified(email, otp)),
      );
    });
  }

  Future<void> resetPassword(String email, String otp, String newPassword) async {
    await _safeExecute(() async {
      emit(AuthLoading());
      final result = await _resetPasswordUseCase(email, otp, newPassword);
      result.fold(
        (failure) => emit(AuthError(failure.message)),
        (_) => emit(AuthPasswordResetSuccess()),
      );
    });
  }

  Future<void> logout() async {
    await _safeExecute(() async {
      await _logoutUseCase();
      emit(AuthUnauthenticated());
    });
  }
}

import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sowlab_app/core/api/dio_client.dart';
import 'package:sowlab_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:sowlab_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:sowlab_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:sowlab_app/features/auth/domain/usecases/auth_usecases.dart';
import 'package:sowlab_app/features/auth/presentation/bloc/auth_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(() => DioClient(sl()));

  // Features - Auth
  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl(), sl()));
  
  // UseCases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => ForgotPasswordUseCase(sl()));
  sl.registerLazySingleton(() => VerifyOtpUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  
  // BLoCs
  sl.registerFactory(() => AuthCubit(
    loginUseCase: sl(),
    registerUseCase: sl(),
    forgotPasswordUseCase: sl(),
    verifyOtpUseCase: sl(),
    resetPasswordUseCase: sl(),
    logoutUseCase: sl(),
  ));
}

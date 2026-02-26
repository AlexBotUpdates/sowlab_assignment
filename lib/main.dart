import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sowlab_app/core/theme/app_theme.dart';
import 'package:sowlab_app/core/utils/message_service.dart';
import 'package:sowlab_app/core/widgets/global_loading_overlay.dart';
import 'package:sowlab_app/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:sowlab_app/features/auth/presentation/pages/splash_screen.dart';
import 'package:sowlab_app/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoadingProvider()),
        BlocProvider(create: (context) => di.sl<AuthCubit>()),
      ],
      child: MaterialApp(
        title: 'Sowlab App',
        scaffoldMessengerKey: MessageService.messengerKey,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        builder: (context, child) => GlobalLoadingOverlay(child: child!),
        home: const SplashScreen(),
      ),
    );
  }
}

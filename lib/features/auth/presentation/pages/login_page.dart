import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sowlab_app/core/theme/app_colors.dart';
import 'package:sowlab_app/core/theme/app_text_styles.dart';
import 'package:sowlab_app/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:sowlab_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:sowlab_app/features/auth/presentation/widgets/auth/auth_text_field.dart';
import 'package:sowlab_app/features/auth/presentation/widgets/auth/auth_primary_button.dart';
import 'package:sowlab_app/features/auth/presentation/widgets/auth/social_login_button.dart';
import 'package:sowlab_app/features/auth/presentation/pages/register_page.dart';
import 'package:sowlab_app/features/auth/presentation/pages/recovery_flow_pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter email and password'),
            backgroundColor: Colors.red),
      );
      return;
    }

    context.read<AuthCubit>().login(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Login Successful!'),
                backgroundColor: Colors.green),
          );
          // TODO: Navigate to Home
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundWhite,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Text(
                  "FarmerEats",
                  style: AppTextStyles.bodyMedium,
                ),
                const SizedBox(height: 80),
                Text(
                  "Welcome back!",
                  style: AppTextStyles.titleLarge,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Text(
                      "New here? ",
                      style:
                          AppTextStyles.bodyMedium.copyWith(color: Colors.grey),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const RegisterPage()),
                        );
                      },
                      child: Text(
                        "Create account",
                        style: AppTextStyles.linkText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 72),
                AuthTextField(
                  controller: _emailController,
                  hintText: "Email Address",
                  prefixIcon: Image.asset(
                    'assets/icons/Vector@3x-1.png',
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                AuthTextField(
                  controller: _passwordController,
                  hintText: "Password",
                  obscureText: true,
                  prefixIcon: Image.asset(
                    'assets/icons/Group 47@3x.png',
                    color: AppColors.textPrimary,
                  ),
                  suffixIcon: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ForgotPasswordPage()),
                      );
                    },
                    child: Text(
                      "Forgot?",
                      style: AppTextStyles.forgotText,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return AuthPrimaryButton(
                      text: "Login",
                      isLoading: state is AuthLoading,
                      onPressed: _onLogin,
                    );
                  },
                ),
                const SizedBox(height: 40),
                Center(
                  child: Text(
                    "or login with",
                    style: AppTextStyles.labelSmall,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SocialLoginButton(
                      iconPath: 'assets/icons/Group 52@3x.png', // Google
                      onTap: () {},
                    ),
                    SocialLoginButton(
                      iconPath:
                          'assets/icons/icons8-apple-logo 1@3x.png', // Apple
                      onTap: () {},
                    ),
                    SocialLoginButton(
                      iconPath: 'assets/icons/Group 71@3x.png', // Facebook
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

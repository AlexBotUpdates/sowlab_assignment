import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sowlab_app/core/theme/app_colors.dart';
import 'package:sowlab_app/core/theme/app_text_styles.dart';
import 'package:sowlab_app/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:sowlab_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:sowlab_app/features/auth/presentation/widgets/auth/auth_text_field.dart';
import 'package:sowlab_app/features/auth/presentation/widgets/auth/auth_primary_button.dart';
import 'package:sowlab_app/features/auth/presentation/widgets/auth/social_login_button.dart';
import 'package:sowlab_app/features/auth/presentation/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onContinue() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fill in all fields'),
            backgroundColor: Colors.red),
      );
      return;
    }
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Passwords do not match'),
            backgroundColor: Colors.red),
      );
      return;
    }

    context.read<AuthCubit>().register({
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Registration successful! Please login.'),
                backgroundColor: Colors.green),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LoginPage()),
          );
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
                const SizedBox(height: 32),
                Text(
                  "Signup 1 of 4",
                  style: AppTextStyles.labelSmall.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text(
                  "Welcome!",
                  style: AppTextStyles.titleLarge,
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SocialLoginButton(
                      iconPath: 'assets/icons/Group 52@3x.png',
                      onTap: () {},
                    ),
                    SocialLoginButton(
                      iconPath: 'assets/icons/icons8-apple-logo 1@3x.png',
                      onTap: () {},
                    ),
                    SocialLoginButton(
                      iconPath: 'assets/icons/Group 71@3x.png',
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Center(
                  child: Text(
                    "or signup with",
                    style: AppTextStyles.labelSmall,
                  ),
                ),
                const SizedBox(height: 32),
                AuthTextField(
                  controller: _nameController,
                  hintText: "Full Name",
                  prefixIcon: Image.asset(
                    'assets/icons/Group 54@3x.png',
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
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
                  controller: _phoneController,
                  hintText: "Phone Number",
                  prefixIcon: Image.asset(
                    'assets/icons/Vector@3x-2.png',
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
                ),
                const SizedBox(height: 16),
                AuthTextField(
                  controller: _confirmPasswordController,
                  hintText: "Re-enter Password",
                  obscureText: true,
                  prefixIcon: Image.asset(
                    'assets/icons/Group 47@3x.png',
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginPage()),
                        );
                      },
                      child: Text(
                        "Login",
                        style: AppTextStyles.linkText.copyWith(
                          decoration: TextDecoration.underline,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return SizedBox(
                          width: 220,
                          child: AuthPrimaryButton(
                            text: "Continue",
                            isLoading: state is AuthLoading,
                            onPressed: _onContinue,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

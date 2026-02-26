import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sowlab_app/core/widgets/custom_widgets.dart';
import 'package:sowlab_app/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:sowlab_app/features/auth/presentation/bloc/auth_state.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Recovery")),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthOtpSent) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => OtpVerificationPage(email: _emailController.text)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Recover Password",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text("Enter your registered email to receive an OTP"),
                const SizedBox(height: 32),
                CustomTextField(
                  label: "Email",
                  controller: _emailController,
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 32),
                CustomButton(
                  text: "Send OTP",
                  isLoading: state is AuthLoading,
                  onPressed: () => context.read<AuthCubit>().forgotPassword(_emailController.text),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class OtpVerificationPage extends StatefulWidget {
  final String email;
  const OtpVerificationPage({super.key, required this.email});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify")),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthOtpVerified) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ResetPasswordPage(email: widget.email, otp: _otpController.text),
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Text("Verification code sent to ${widget.email}"),
                const SizedBox(height: 32),
                CustomTextField(
                  label: "Enter OTP",
                  controller: _otpController,
                  prefixIcon: Icons.password_outlined,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 32),
                CustomButton(
                  text: "Verify",
                  isLoading: state is AuthLoading,
                  onPressed: () => context.read<AuthCubit>().verifyOtp(
                        widget.email,
                        _otpController.text,
                      ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ResetPasswordPage extends StatefulWidget {
  final String email;
  final String otp;
  const ResetPasswordPage({super.key, required this.email, required this.otp});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reset")),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthPasswordResetSuccess) {
            Navigator.popUntil(context, (route) => route.isFirst);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Password updated successfully!")),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                CustomTextField(
                  label: "New Password",
                  controller: _passwordController,
                  isPassword: true,
                  prefixIcon: Icons.lock_outline,
                ),
                const SizedBox(height: 32),
                CustomButton(
                  text: "Reset Password",
                  isLoading: state is AuthLoading,
                  onPressed: () => context.read<AuthCubit>().resetPassword(
                        widget.email,
                        widget.otp,
                        _passwordController.text,
                      ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

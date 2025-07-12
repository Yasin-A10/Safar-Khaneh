import 'package:flutter/material.dart';
import 'package:safar_khaneh/config/router/app_router.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
import 'package:safar_khaneh/core/network/secure_token_storage.dart';
import 'package:safar_khaneh/core/utils/validators.dart';
import 'package:safar_khaneh/features/auth/data/reset_password_servise.dart';
import 'package:safar_khaneh/widgets/inputs/text_form_field.dart';
import 'package:safar_khaneh/widgets/button.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  final ResetPasswordService _resetPasswordService = ResetPasswordService();

  void _handleResetPassword(context) async {
    if (!resetPasswordFormKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final resetToken = await TokenStorage.getResetToken();

    try {
      final response = await _resetPasswordService.resetPassword(
        token: resetToken!,
        newPassword: _passwordController.text.trim(),
      );

      if (response['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'رمز با موفقیت تغییر یافت',
              textDirection: TextDirection.rtl,
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );
        TokenStorage.clearResetToken();
        GoRouter.of(navigatorKey.currentContext!).go('/login');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Text(e.toString(), textDirection: TextDirection.rtl),
          backgroundColor: AppColors.error200,
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'انتخاب رمز جدید',
                    style: TextStyle(
                      color: AppColors.grey900,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'رمز جدید خودت رو بنویس و فراموش نکن',
                    style: TextStyle(color: AppColors.grey500, fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  Form(
                    key: resetPasswordFormKey,
                    child: Column(
                      children: [
                        InputTextFormField(
                          controller: _passwordController,
                          label: 'رمز جدید',
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) => AppValidator.password(value),
                        ),
                        const SizedBox(height: 24),
                        Button(
                          label: 'تایید',
                          onPressed: () {
                            _handleResetPassword(context);
                          },
                          width: double.infinity,
                          enabled: !_isLoading,
                          isLoading: _isLoading,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

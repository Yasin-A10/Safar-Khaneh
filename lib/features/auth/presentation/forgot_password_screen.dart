import 'package:flutter/material.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
import 'package:safar_khaneh/core/utils/validators.dart';
import 'package:safar_khaneh/features/auth/data/forgot_password_service.dart';
import 'package:safar_khaneh/widgets/inputs/text_form_field.dart';
import 'package:safar_khaneh/widgets/button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  final ForgetPasswordService _forgotPasswordService = ForgetPasswordService();

  void _handleForgotPassword(context) async {
    if (!forgotPasswordFormKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _forgotPasswordService.forgotPassword(
        email: _emailController.text.trim(),
      );

      if (response['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'ایمیل با موفقیت تایید شد. لطفا رمز جدید را ثبت کنید',
              textDirection: TextDirection.rtl,
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );
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
    _emailController.dispose();
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
                    'ایمیل خود را وارد کنید',
                    style: TextStyle(
                      color: AppColors.grey900,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'اصلا نگران نباش! رمزت جور میشه',
                    style: TextStyle(color: AppColors.grey500, fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  Form(
                    key: forgotPasswordFormKey,
                    child: Column(
                      children: [
                        InputTextFormField(
                          controller: _emailController,
                          label: 'ایمیل',
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => AppValidator.email(value),
                        ),
                        const SizedBox(height: 24),
                        Button(
                          label: 'تایید',
                          onPressed: () {
                            _handleForgotPassword(context);
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

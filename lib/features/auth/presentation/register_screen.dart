import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
import 'package:safar_khaneh/core/utils/validators.dart';
import 'package:safar_khaneh/features/auth/data/register_service.dart';
import 'package:safar_khaneh/widgets/button.dart';
import 'package:safar_khaneh/widgets/inputs/text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final RegisterService _registerService = RegisterService();

  bool _isLoading = false;

  Future<void> _handleRegister() async {
    if (!registerFormKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await _registerService.register(
        fullName: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('ثبت‌نام با موفقیت انجام شد'),),
        );
        context.go('/login'); // یا '/home' بسته به مسیر بعد از ثبت‌نام
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
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
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo/SAFAR-KHANEH.png',
                height: 250,
                width: 500,
              ),
              Column(
                children: [
                  Text(
                    'اطلاعات خود را وارد کنید',
                    style: TextStyle(
                      color: AppColors.grey900,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'از این که ما را انتخاب کردید بسیار خوشحالیم',
                    style: TextStyle(
                      color: AppColors.grey500,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: registerFormKey,
                  child: Column(
                    children: [
                      InputTextFormField(
                        controller: _nameController,
                        label: 'نام کاربری',
                        keyboardType: TextInputType.text,
                        validator: (value) => AppValidator.userName(value, fieldName: 'نام کاربری'),
                      ),
                      const SizedBox(height: 12),
                      InputTextFormField(
                        controller: _emailController,
                        label: 'ایمیل',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => AppValidator.email(value, fieldName: 'ایمیل'),
                      ),
                      const SizedBox(height: 12),
                      InputTextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        maxLines: 1,
                        label: 'رمز عبور',
                        validator: (value) => AppValidator.password(value, fieldName: 'رمز عبور'),
                      ),
                      const SizedBox(height: 24),
                      Button(
                        label: _isLoading ? 'لطفاً صبر کنید...' : 'ثبت‌نام',
                        isLoading: _isLoading,
                        onPressed: _isLoading ? null : _handleRegister,
                        width: double.infinity,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('قبلاً ثبت‌نام کرده‌اید؟'),
                          TextButton(
                            child: Text(
                              'ورود',
                              style: TextStyle(
                                color: AppColors.primary800,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () => context.go('/login'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

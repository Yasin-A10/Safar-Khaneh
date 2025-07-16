import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safar_khaneh/config/router/app_router.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
import 'package:safar_khaneh/core/network/secure_token_storage.dart';
import 'package:safar_khaneh/core/utils/validators.dart';
import 'package:safar_khaneh/features/auth/data/login_sevice.dart';
import 'package:safar_khaneh/widgets/inputs/text_form_field.dart';
import 'package:safar_khaneh/widgets/button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  final LoginService _loginService = LoginService();

  void _handleLogin(context) async {
    if (!loginFormKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _loginService.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      final token = response['access'];
      final refreshToken = response['refresh'];
      final userId = response['user']['id'];

      if (token != null && refreshToken != null && userId != null) {
        await TokenStorage.saveTokens(
          accessToken: token,
          refreshToken: refreshToken,
        );
        await TokenStorage.saveUserId(userId);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'ورود با موفقیت انجام شد',
              textDirection: TextDirection.rtl,
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );

        GoRouter.of(navigatorKey.currentContext!).go('/home');
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
                    'ورود به حساب کاربری',
                    style: TextStyle(
                      color: AppColors.grey900,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'از این که ما را انتخاب کردید بسیار خوشحالیم',
                    style: TextStyle(color: AppColors.grey500, fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  Form(
                    key: loginFormKey,
                    child: Column(
                      children: [
                        InputTextFormField(
                          controller: _emailController,
                          label: 'ایمیل',
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => AppValidator.email(value),
                        ),
                        const SizedBox(height: 8),
                        InputTextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          label: 'رمز عبور',
                          maxLines: 1,
                          validator: (value) => AppValidator.password(value),
                        ),
                        const SizedBox(height: 24),
                        Button(
                          label: 'ورود',
                          onPressed: () => _handleLogin(context),
                          width: double.infinity,
                          enabled: !_isLoading,
                          isLoading: _isLoading,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'حساب کاربری ندارید؟',
                        style: TextStyle(color: AppColors.grey600),
                      ),
                      TextButton(
                        onPressed: () => context.go('/register'),
                        child: Text(
                          'ثبت نام',
                          style: TextStyle(
                            color: AppColors.primary800,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'رمز عبور را فراموش کرده اید؟',
                        style: TextStyle(color: AppColors.grey600),
                      ),
                      TextButton(
                        onPressed: () => context.go('/forgot-password'),
                        child: Text(
                          'بازیابی رمز عبور',
                          style: TextStyle(
                            color: AppColors.primary800,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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

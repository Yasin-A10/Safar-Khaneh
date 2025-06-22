import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
import 'package:safar_khaneh/widgets/inputs/text_field.dart';
import 'package:safar_khaneh/widgets/button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          // resizeToAvoidBottomInset: false, //for bottom overload
          backgroundColor: AppColors.white,
          body: Column(
            spacing: 0,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(
              //   'assets/images/SAFAR-KHANEH.png',
              //   height: 250,
              //   width: 500,
              // ),
              Column(
                spacing: 8,
                children: [
                  Text(
                    'بیا وارد برنامه بشیم',
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
                child: Column(
                  spacing: 12,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputTextField(
                      label: 'ایمیل',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    InputTextField(
                      obscureText: true,
                      label: 'رمز عبور',
                      maxLines: 1,
                    ),
                    Button(
                      label: 'ورود',
                      onPressed: () {
                        context.go('/home');
                      },
                      width: double.infinity,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 8,
                      children: [
                        Text(
                          'حساب کاربری ندارید؟',
                          style: TextStyle(
                            color: AppColors.grey500,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.go('/register');
                          },
                          child: Text(
                            'ثبت نام',
                            style: TextStyle(
                              color: AppColors.primary800,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

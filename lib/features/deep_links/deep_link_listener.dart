import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safar_khaneh/config/router/app_router.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
import 'package:safar_khaneh/core/network/secure_token_storage.dart';
import 'package:safar_khaneh/features/auth/data/models/verify_email_service.dart';

class DeepLinkListener extends StatefulWidget {
  const DeepLinkListener({super.key, required this.child});
  final Widget child;

  @override
  State<DeepLinkListener> createState() => _DeepLinkListenerState();
}

class _DeepLinkListenerState extends State<DeepLinkListener> {
  final VerifyEmailService _verifyEmailService = VerifyEmailService();
  @override
  void initState() {
    final appLinks = AppLinks();
    appLinks.uriLinkStream.listen(
      (uri) {
        if (uri.path == '/payment-result' && mounted) {
          final success = uri.queryParameters['success'];
          if (success == 'true') {
            GoRouter.of(navigatorKey.currentContext!).go('/payment-success');
          } else {
            GoRouter.of(navigatorKey.currentContext!).go('/payment-failed');
          }
        }
        if (uri.path == '/verify-email' && mounted) {
          final token = uri.queryParameters['token'];
          if (token != null) {
            _verifyEmailService.verifyEmail(token: token).then((value) {
              if (value['status'] == 'success') {
                GoRouter.of(navigatorKey.currentContext!).go('/verify-email');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    content: Text(
                      'ایمیل با موفقیت تایید شد',
                      textDirection: TextDirection.rtl,
                    ),
                    backgroundColor: AppColors.success200,
                    duration: const Duration(seconds: 3),
                  ),
                );
              } else {
                return;
              }
            });
          }
        }
        if (uri.path == '/reset-password' && mounted) {
          final token = uri.queryParameters['token'];
          if (token != null) {
            GoRouter.of(navigatorKey.currentContext!).go('/reset-password');
            TokenStorage.saveResetToken(token: token);
          } else {
            return;
          }
        }
      },

      onError: (err) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              content: Text(
                'خطایی رخ داده است',
                textDirection: TextDirection.rtl,
              ),
              backgroundColor: AppColors.error200,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

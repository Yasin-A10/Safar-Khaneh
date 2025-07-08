import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safar_khaneh/config/router/app_router.dart';

class DeepLinkListener extends StatefulWidget {
  const DeepLinkListener({super.key, required this.child});
  final Widget child;

  @override
  State<DeepLinkListener> createState() => _DeepLinkListenerState();
}

class _DeepLinkListenerState extends State<DeepLinkListener> {
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
      },
      onError: (err) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(err.toString())));
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

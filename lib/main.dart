import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:safar_khaneh/config/router/app_router.dart';
import 'package:safar_khaneh/config/theme/app_theme.dart';
import 'package:safar_khaneh/features/deep_links/deep_link_listener.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // for app_links
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: MaterialApp.router(
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
        locale: Locale('fa', 'IR'),
        supportedLocales: const [Locale('fa', 'IR')],
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: AppTheme.lightTheme,
        builder: (context, child) {
          if (child == null) return const SizedBox();
          return DeepLinkListener(child: child);
        },
      ),
    );
  }
}

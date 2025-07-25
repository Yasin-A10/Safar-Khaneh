import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
import 'package:safar_khaneh/core/network/secure_token_storage.dart';
import 'package:safar_khaneh/features/auth/data/models/logout_service.dart';

class RootScreen extends StatefulWidget {
  final Widget child;

  const RootScreen({super.key, required this.child});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final LogoutService logoutService = LogoutService();

  int _currentIndex = 0;
  String _appBarTitle = 'خانه';
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final hasToken = await TokenStorage.hasAccessToken();
    setState(() {
      _isLoggedIn = hasToken;
    });
  }

  void handleLogout() async {
    try {
      await logoutService.logout();
      if (mounted) {
        context.pop();
        setState(() {
          _isLoggedIn = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            content: Text(
              'خروج موفقیت آمیز بود',
              textDirection: TextDirection.rtl,
            ),
            backgroundColor: AppColors.success200,
            duration: const Duration(seconds: 3),
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
    }
  }

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0:
          _appBarTitle = 'خانه';
          context.push('/home');
          break;
        case 1:
          _appBarTitle = 'رزروهای من';
          context.push('/my_bookings');
          break;
        case 2:
          _appBarTitle = 'جستجو';
          context.push('/search');
          break;
        case 3:
          _appBarTitle = 'پروفایل';
          context.push('/profile');
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // تشخیص مسیر فعلی
    final location = GoRouter.of(context).state.uri.toString();

    // تعیین ایندکس و عنوان جدید بر اساس مسیر
    int newIndex = 0;
    String newTitle = 'خانه';

    if (location == '/my_bookings') {
      newIndex = 1;
      newTitle = 'رزروهای من';
    } else if (location == '/search') {
      newIndex = 2;
      newTitle = 'جستجو';
    } else if (location == '/profile') {
      newIndex = 3;
      newTitle = 'پروفایل';
    }

    // به‌روزرسانی وضعیت اگر لازم باشد
    if (newIndex != _currentIndex || newTitle != _appBarTitle) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _currentIndex = newIndex;
          _appBarTitle = newTitle;
        });
      });
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_appBarTitle),
          actions: [
            if (_currentIndex == 0)
              if (_isLoggedIn)
                IconButton(
                  icon: const Icon(Iconsax.logout),
                  onPressed:
                      () => showDialog(
                        context: context,
                        builder: (context) {
                          return Directionality(
                            textDirection: TextDirection.rtl,
                            child: AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              title: const Text(
                                'آیا از خروج خود مطمئن هستید؟',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () => context.pop(),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.error200,
                                        foregroundColor: AppColors.white,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        textStyle: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Vazir',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      child: const Text('بازگشت'),
                                    ),
                                    SizedBox(width: 16),
                                    OutlinedButton(
                                      onPressed: () {
                                        handleLogout();
                                      },
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          color: AppColors.primary800,
                                          width: 2,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                      ),
                                      child: const Text(
                                        'بله',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.primary800,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                )
              else
                IconButton(
                  icon: const Icon(Iconsax.add),
                  onPressed: () => context.go('/login'),
                )
            else
              IconButton(
                icon: const Icon(Iconsax.arrow_left),
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.go('/home');
                  }
                },
              ),
          ],
        ),
        body: widget.child,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTap,
          type: BottomNavigationBarType.shifting,
          iconSize: 28,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Iconsax.home),
              activeIcon: Icon(Iconsax.home_15),
              label: 'خانه',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.archive_1),
              activeIcon: Icon(Iconsax.archive_15),
              label: 'رزروهای من',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.search_normal),
              activeIcon: Icon(Iconsax.search_normal),
              label: 'جستجو',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.profile_circle),
              activeIcon: Icon(Iconsax.profile_circle5),
              label: 'پروفایل',
            ),
          ],
        ),
      ),
    );
  }
}

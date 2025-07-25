import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
import 'package:safar_khaneh/core/utils/validators.dart';
import 'package:safar_khaneh/features/profile/data/models/profile_model.dart';
import 'package:safar_khaneh/features/profile/data/services/profile_services.dart';
import 'package:safar_khaneh/widgets/button.dart';
import 'package:safar_khaneh/widgets/inputs/text_form_field.dart';

class PersonalInfoScreen extends StatefulWidget {
  final ProfileModel profile;
  const PersonalInfoScreen({super.key, required this.profile});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final GlobalKey<FormState> _updateProfileFormKey = GlobalKey<FormState>();

  final ProfileService _profileService = ProfileService();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fullNameController.text = widget.profile.fullName;
    _emailController.text = widget.profile.email;
    _phoneController.text = widget.profile.phoneNumber;
  }

  void _handleUpdateProfile(context) async {
    if (!_updateProfileFormKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });
    try {
      final fullName = _fullNameController.text.trim();
      final phone = _phoneController.text.trim();
      final password = _passwordController.text.trim();

      if (fullName.isEmpty || phone.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            content: Text(
              'لطفاً همه فیلدها را پر کنید',
              textDirection: TextDirection.rtl,
            ),
            backgroundColor: AppColors.warning200,
            duration: const Duration(seconds: 3),
          ),
        );

        return;
      }

      await _profileService.updateProfile(
        fullName: fullName,
        phoneNumber: phone,
        password: password,
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('اطلاعات با موفقیت ذخیره شد')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('خطا در ذخیره اطلاعات: $e')));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('اطلاعات شخصی'),
            actions: [
              IconButton(
                icon: const Icon(Iconsax.arrow_left),
                onPressed: () => context.pop(),
              ),
            ],
          ),
          body: Container(
            color: AppColors.white,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _updateProfileFormKey,
                  child: Column(
                    children: [
                      SizedBox(height: 16),
                      InputTextFormField(
                        label: 'نام و نام خانوادگی',
                        keyboardType: TextInputType.text,
                        controller: _fullNameController,
                        validator: (value) {
                          return AppValidator.userName(value);
                        },
                      ),
                      SizedBox(height: 16),
                      InputTextFormField(
                        label: 'ایمیل',
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                      ),
                      SizedBox(height: 16),
                      InputTextFormField(
                        label: 'شماره همراه',
                        keyboardType: TextInputType.number,
                        controller: _phoneController,
                        validator: (value) {
                          return AppValidator.phoneNumber(value);
                        },
                      ),
                      SizedBox(height: 16),
                      InputTextFormField(
                        label: 'رمز عبور',
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordController,
                      ),
                      SizedBox(height: 24),
                      Button(
                        label: 'ذخیره اطلاعات',
                        onPressed: () {
                          _handleUpdateProfile(context);
                        },
                        width: double.infinity,
                        enabled: !_isLoading,
                        isLoading: _isLoading,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

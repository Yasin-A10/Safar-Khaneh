import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
import 'package:safar_khaneh/widgets/button.dart';
import 'package:safar_khaneh/widgets/inputs/text_field.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
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
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    InputTextField(
                      label: 'نام',
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: 16),
                    InputTextField(
                      label: 'نام خانوادگی',
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: 16),
                    InputTextField(
                      label: 'شماره همراه',
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 16),
                    InputTextField(
                      label: 'رمز عبور',
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    SizedBox(height: 24),
                    Button(
                      label: 'ذخیره اطلاعات',
                      onPressed: () {},
                      width: double.infinity,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

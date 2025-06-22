import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh/widgets/button.dart';
import 'package:safar_khaneh/widgets/inputs/image_input.dart';
import 'package:safar_khaneh/widgets/inputs/text_field.dart';
import 'package:safar_khaneh/widgets/map_picker.dart';

class RequestToAddResidenceScreen extends StatefulWidget {
  const RequestToAddResidenceScreen({super.key});

  @override
  State<RequestToAddResidenceScreen> createState() =>
      _RequestToAddResidenceScreenState();
}

class _RequestToAddResidenceScreenState
    extends State<RequestToAddResidenceScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  double? latitude;
  double? longitude;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    titleController.dispose();
    cityController.dispose();
    provinceController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    latitude = null;
    longitude = null;
    super.dispose();
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
            title: const Text('درخواست اضافه کردن اقامتگاه'),
            actions: [
              IconButton(
                icon: const Icon(Iconsax.arrow_left),
                onPressed: () => context.pop(),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputTextField(
                    label: 'نام و نام خانوادگی مدیر',
                    initialValue: fullNameController,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 16),
                  InputTextField(
                    label: 'عنوان اقامتگاه',
                    initialValue: titleController,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: InputTextField(
                          label: 'شهر',
                          initialValue: cityController,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: InputTextField(
                          label: 'استان',
                          initialValue: provinceController,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  InputTextField(
                    label: 'شماره تماس',
                    initialValue: phoneNumberController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  InputTextField(
                    label: 'آدرس',
                    initialValue: addressController,
                    keyboardType: TextInputType.text,
                    maxLines: 4,
                  ),
                  const SizedBox(height: 16),
                  MapPicker(
                    initialLatitude: 35.6892,
                    initialLongitude: 51.3890,
                    onLocationSelected: (latitude, longitude) {
                      setState(() {
                        this.latitude = latitude;
                        this.longitude = longitude;
                      });
                    },
                  ),
                  const SizedBox(height: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'سند اقامتگاه',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ImageUploadInput(
                        onImageSelected: (file) {
                          // اینجا می‌تونی فایل رو ذخیره کنی یا بفرستی سمت سرور
                          print("عکس انتخاب شد: ${file?.path}");
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Button(
                    width: double.infinity,
                    label: 'ارسال درخواست',
                    onPressed: () {},
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

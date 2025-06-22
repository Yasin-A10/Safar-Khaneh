import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
import 'package:safar_khaneh/core/utils/number_formater.dart';
import 'package:safar_khaneh/data/models/my_residence_model.dart';
import 'package:safar_khaneh/widgets/button.dart';
import 'package:safar_khaneh/widgets/feature_selector.dart';
import 'package:safar_khaneh/widgets/inputs/image_input.dart';
import 'package:safar_khaneh/widgets/inputs/text_field.dart';
import 'package:safar_khaneh/widgets/map_picker.dart';

class EditResidenceDetailScreen extends StatefulWidget {
  final MyResidenceModel residence;

  const EditResidenceDetailScreen({super.key, required this.residence});

  @override
  State<EditResidenceDetailScreen> createState() =>
      _EditResidenceDetailScreenState();
}

class _EditResidenceDetailScreenState extends State<EditResidenceDetailScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController roomCountController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController maxDaysController = TextEditingController();
  TextEditingController cleaningFeeController = TextEditingController();
  TextEditingController serviceFeeController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  List<String> facilities = [];
  double? latitude;
  double? longitude;

  @override
  void initState() {
    titleController.text = widget.residence.title;
    descriptionController.text = widget.residence.description.toString();
    roomCountController.text = formatNumberToPersianWithoutSeparator(
      widget.residence.roomCount,
    );
    capacityController.text = formatNumberToPersianWithoutSeparator(
      widget.residence.capacity,
    );
    phoneNumberController.text = formatNumberToPersianWithoutSeparator(
      widget.residence.phoneNumber,
    );
    priceController.text = formatNumberToPersian(widget.residence.price);
    maxDaysController.text = formatNumberToPersian(
      widget.residence.maxDays ?? 0,
    );
    cleaningFeeController.text = formatNumberToPersian(
      widget.residence.cleaningFee ?? 0,
    );
    serviceFeeController.text = formatNumberToPersian(
      widget.residence.serviceFee ?? 0,
    );
    provinceController.text = widget.residence.province.toString();
    cityController.text = widget.residence.city.toString();
    facilities = widget.residence.facilities;
    latitude = widget.residence.latitude;
    longitude = widget.residence.longitude;
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    roomCountController.dispose();
    capacityController.dispose();
    phoneNumberController.dispose();
    priceController.dispose();
    maxDaysController.dispose();
    cleaningFeeController.dispose();
    serviceFeeController.dispose();
    facilities.clear();
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
            backgroundColor: AppColors.white,
            leading: Padding(
              padding: const EdgeInsets.only(right: 7.1),
              child: Row(
                children: [
                  Text(
                    formatNumberToPersianWithoutSeparator(
                      widget.residence.rating.toString(),
                    ),
                    style: TextStyle(
                      color: AppColors.grey600,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 1),
                  const Icon(
                    Iconsax.star1,
                    color: AppColors.accentColor,
                    size: 22,
                  ),
                ],
              ),
            ),
            title: Text(widget.residence.title),
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
                    label: 'عنوان',
                    initialValue: titleController,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 16),
                  InputTextField(
                    label: 'شماره تماس',
                    initialValue: phoneNumberController,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16),
                  FeaturesSelector(
                    allFeatures: const ['استخر', 'غذا', 'حسوم', 'عدم وجود پسر'],
                    selectedFeatures: facilities,
                    onChanged: (selectedFeatures) {
                      setState(() {
                        facilities = selectedFeatures;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  InputTextField(
                    label: 'توضیحات',
                    initialValue: descriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 6,
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: InputTextField(
                          label: 'استان',
                          initialValue: provinceController,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: InputTextField(
                          label: 'شهر',
                          initialValue: cityController,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: InputTextField(
                          label: 'ظرفیت نفرات',
                          initialValue: capacityController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: InputTextField(
                          label: 'تعداد اتاق خواب',
                          initialValue: roomCountController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: InputTextField(
                          label: 'حداکثر تعداد روز',
                          initialValue: maxDaysController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: InputTextField(
                          label: 'قیمت هر شب',
                          initialValue: priceController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: InputTextField(
                          label: 'قیمت نظافت',
                          initialValue: cleaningFeeController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: InputTextField(
                          label: 'قیمت خدمات',
                          initialValue: serviceFeeController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  MapPicker(
                    initialLatitude: widget.residence.latitude,
                    initialLongitude: widget.residence.longitude,
                    onLocationSelected: (latitude, longitude) {
                      setState(() {
                        this.latitude = latitude;
                        this.longitude = longitude;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  ImageUploadInput(
                    onImageSelected: (file) {
                      // اینجا می‌تونی فایل رو ذخیره کنی یا بفرستی سمت سرور
                      print("عکس انتخاب شد: ${file?.path}");
                    },
                  ),
                  SizedBox(height: 24),
                  Button(
                    label: 'ذخیره',
                    onPressed: () {},
                    width: double.infinity,
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

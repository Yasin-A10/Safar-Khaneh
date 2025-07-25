import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
import 'package:safar_khaneh/core/utils/validators.dart';
import 'package:safar_khaneh/data/api/geo_sevices.dart';
import 'package:safar_khaneh/features/profile/data/services/request_to_add_service.dart';
import 'package:safar_khaneh/features/search/data/residence_model.dart';
import 'package:safar_khaneh/widgets/button.dart';
import 'package:safar_khaneh/widgets/inputs/image_input.dart';
import 'package:safar_khaneh/widgets/inputs/text_form_field.dart';
import 'package:safar_khaneh/widgets/map_picker.dart';

class RequestToAddResidenceScreen extends StatefulWidget {
  const RequestToAddResidenceScreen({super.key});

  @override
  State<RequestToAddResidenceScreen> createState() =>
      _RequestToAddResidenceScreenState();
}

class _RequestToAddResidenceScreenState
    extends State<RequestToAddResidenceScreen> {
  final GlobalKey<FormState> _requestToAddResidenceFormKey =
      GlobalKey<FormState>();

  final RequestToAddResidenceService requestToAddResidenceService =
      RequestToAddResidenceService();

  //دریافت استانها
  final geoService = GeoService();
  Future<void> _loadProvinces() async {
    try {
      final fetchedProvinces = await geoService.fetchProvinces();
      setState(() {
        provinces = fetchedProvinces;
      });
    } catch (e) {
      throw Exception('خطا در دریافت استانها: $e');
    }
  }

  Province? selectedProvince;
  City? selectedCity;
  List<Province> provinces = [];
  List<City> cities = [];
  // ===========================
  List<String> types = ['villa'];
  String? selectedType;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  double? latitude = 35.6892;
  double? longitude = 51.3890;
  File? documentFile;

  @override
  void initState() {
    super.initState();
    _loadProvinces();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    titleController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    selectedProvince = null;
    selectedCity = null;
    latitude = null;
    longitude = null;
    documentFile = null;
    super.dispose();
  }

  bool _isLoading = false;
  void handleRequestToAddResidence(context) async {
    if (!_requestToAddResidenceFormKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final title = titleController.text.trim();
      final type = selectedType!.trim();
      final address = addressController.text.trim();
      final lat = latitude!.toString();
      final lng = longitude!.toString();
      final cityId = selectedCity!.id!.toString();
      final document = documentFile!.path;

      if (title.isEmpty ||
          type.isEmpty ||
          address.isEmpty ||
          lat.isEmpty ||
          lng.isEmpty ||
          cityId.isEmpty ||
          document.isEmpty) {
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

      await requestToAddResidenceService.requestToAddResidence(
        title: titleController.text,
        type: selectedType!,
        address: addressController.text,
        lat: double.parse(latitude!.toStringAsFixed(6)),
        lng: double.parse(longitude!.toStringAsFixed(6)),
        cityId: selectedCity!.id!,
        documentFile: documentFile!,
      );
      titleController.clear();
      addressController.clear();
      phoneNumberController.clear();
      selectedProvince = null;
      selectedCity = null;
      latitude = null;
      longitude = null;
      documentFile = null;
      setState(() {});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Text(
            'درخواست با موفقیت ثبت شد',
            textDirection: TextDirection.rtl,
          ),
          backgroundColor: AppColors.success200,
          duration: const Duration(seconds: 3),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Text(
            'خطا در ارسال درخواست اقامتگاه: $e',
            textDirection: TextDirection.rtl,
          ),
          backgroundColor: AppColors.error200,
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
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
              child: Form(
                key: _requestToAddResidenceFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputTextFormField(
                      label: 'عنوان اقامتگاه',
                      controller: titleController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        return AppValidator.userName(value);
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 0,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.grey600,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            child: DropdownButtonFormField<Province>(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              isExpanded: true,
                              validator: (value) {
                                return AppValidator.province(value);
                              },
                              icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                              ),
                              dropdownColor: Colors.white,
                              value:
                                  provinces.contains(selectedProvince)
                                      ? selectedProvince
                                      : null,
                              hint: const Text(
                                'انتخاب استان',
                                style: TextStyle(
                                  fontFamily: 'Vazir',
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              items:
                                  provinces.map((province) {
                                    return DropdownMenuItem<Province>(
                                      value: province,
                                      child: Text(
                                        province.name ?? '',
                                        style: const TextStyle(
                                          fontFamily: 'Vazir',
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                              onChanged: (Province? newProvince) async {
                                setState(() {
                                  selectedProvince = newProvince;
                                  selectedCity = null;
                                  cities = [];
                                });

                                if (newProvince != null) {
                                  final fetchedCities = await geoService
                                      .fetchCitiesByProvince(newProvince.id!);
                                  setState(() {
                                    cities = fetchedCities;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 0,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.grey600,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            child: DropdownButtonFormField<City>(
                              isExpanded: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                return AppValidator.city(value);
                              },
                              icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                              ),
                              dropdownColor: Colors.white,
                              value:
                                  cities.contains(selectedCity)
                                      ? selectedCity
                                      : null,
                              hint: const Text(
                                'انتخاب شهر',
                                style: TextStyle(
                                  fontFamily: 'Vazir',
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              items:
                                  cities.map((city) {
                                    return DropdownMenuItem<City>(
                                      value: city,
                                      child: Text(
                                        city.name ?? '',
                                        style: const TextStyle(
                                          fontFamily: 'Vazir',
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                              onChanged: (City? newCity) {
                                setState(() {
                                  selectedCity = newCity;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.grey600,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          return AppValidator.type(value);
                        },
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        dropdownColor: Colors.white,
                        value:
                            types.contains(selectedType) ? selectedType : null,
                        hint: const Text(
                          'انتخاب نوع',
                          style: TextStyle(
                            fontFamily: 'Vazir',
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        items:
                            types.map((type) {
                              return DropdownMenuItem<String>(
                                value: type,
                                child: Text(
                                  type == 'villa' ? 'ویلا' : '',
                                  style: const TextStyle(
                                    fontFamily: 'Vazir',
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            }).toList(),
                        onChanged: (String? newType) {
                          setState(() {
                            selectedType = newType;
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 16),
                    InputTextFormField(
                      label: 'شماره تماس',
                      controller: phoneNumberController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        return AppValidator.phoneNumber(value);
                      },
                    ),
                    const SizedBox(height: 16),
                    InputTextFormField(
                      label: 'آدرس',
                      controller: addressController,
                      keyboardType: TextInputType.text,
                      maxLines: 4,
                      validator: (value) {
                        return AppValidator.userName(value);
                      },
                    ),
                    const SizedBox(height: 16),
                    MapPicker(
                      initialLatitude: '35.6892',
                      initialLongitude: '51.3890',
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
                            setState(() {
                              documentFile = file;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.only(
              top: 16,
              bottom: 20,
              left: 16,
              right: 16,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, -4),
                  blurRadius: 12,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Button(
              width: double.infinity,
              label: 'ارسال درخواست',
              onPressed: () {
                handleRequestToAddResidence(context);
              },
              isLoading: _isLoading,
              enabled: !_isLoading,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
import 'package:safar_khaneh/core/utils/number_formater.dart';
import 'package:safar_khaneh/data/api/feature_service.dart';
import 'package:safar_khaneh/data/api/geo_sevices.dart';
import 'package:safar_khaneh/data/real-models/feature_model.dart';
import 'package:safar_khaneh/features/search/data/residence_model.dart';
import 'package:safar_khaneh/features/search/data/residence_service.dart';
import 'package:safar_khaneh/widgets/button.dart';
import 'package:safar_khaneh/widgets/cards/simple_residence_card.dart';
import 'package:safar_khaneh/widgets/search_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ResidenceService _residenceService = ResidenceService();

  late Future<List<ResidenceModel>> _futureResidences;

  @override
  void initState() {
    super.initState();
    _futureResidences = _residenceService.fetchResidences();
  }

  void _handleSearch(String query) async {
    final result = await _residenceService.fetchResidences(query: query);
    setState(() {
      _futureResidences = Future.value(result);
    });
  }

  void _handleFilter(
    int? provinceId,
    int? cityId,
    int? minPrice,
    int? maxPrice,
    List<int>? features,
  ) async {
    final result = await _residenceService.fetchResidences(
      provinceId: provinceId,
      cityId: cityId,
      minPrice: minPrice,
      maxPrice: maxPrice,
      features: features,
    );
    setState(() {
      _futureResidences = Future.value(result);
    });
  }

  Province? _selectedProvince;
  City? _selectedCity;
  List<Province> provinces = [];
  List<City> cities = [];
  RangeValues _priceRange = const RangeValues(0, 1000000);
  final List<int> _selectedFeatures = [];
  List<FeatureModel> features = [];

  void _showFilterModal() async {
    final geoService = GeoService();
    final featureService = FeatureService();

    if (features.isEmpty) {
      features = await featureService.fetchFeatures();
    }

    // اگر لیست استان‌ها خالیه، یکبار واکشی کن
    if (provinces.isEmpty) {
      provinces = await geoService.fetchProvinces();
    }

    if (!mounted) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.only(
                top: 0,
                bottom: 16,
                left: 16,
                right: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'فیلترها',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 32),
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
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<Province>(
                              isExpanded: true,
                              icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                              ),
                              dropdownColor: Colors.white,
                              value:
                                  provinces.contains(_selectedProvince)
                                      ? _selectedProvince
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
                                setModalState(() {
                                  _selectedProvince = newProvince;
                                  _selectedCity = null;
                                  cities = [];
                                });

                                if (newProvince != null) {
                                  final fetchedCities = await geoService
                                      .fetchCitiesByProvince(newProvince.id!);
                                  setModalState(() {
                                    cities = fetchedCities;
                                  });
                                }
                              },
                            ),
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
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<City>(
                              isExpanded: true,
                              icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                              ),
                              dropdownColor: Colors.white,
                              value:
                                  cities.contains(_selectedCity)
                                      ? _selectedCity
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
                                setModalState(() {
                                  _selectedCity = newCity;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'محدوده قیمت',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      RangeSlider(
                        values: _priceRange,
                        onChanged: (RangeValues values) {
                          setModalState(() {
                            _priceRange = values;
                          });
                        },
                        min: 0,
                        max: 1000000,
                        activeColor: AppColors.primary800,
                        inactiveColor: AppColors.grey300,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'از ${formatNumberToPersian(_priceRange.start.toInt())} تومان',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            'تا ${formatNumberToPersian(_priceRange.end.toInt())} تومان',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'انتخاب امکانات',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...features.map((feature) {
                        return CheckboxListTile(
                          value: _selectedFeatures.contains(feature.id),
                          title: Text(
                            feature.name,
                            style: const TextStyle(fontSize: 14),
                          ),
                          onChanged: (bool? isChecked) {
                            setModalState(() {
                              if (isChecked == true) {
                                _selectedFeatures.add(feature.id);
                              } else {
                                _selectedFeatures.remove(feature.id);
                              }
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () => context.pop(),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColors.error200, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                        ),
                        child: const Text(
                          'بازگشت',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColors.error200,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Button(
                          label: 'اعمال فیلتر',
                          onPressed: () {
                            if (_selectedProvince != null &&
                                _selectedCity != null) {
                              _handleFilter(
                                _selectedProvince?.id,
                                _selectedCity?.id,
                                _priceRange.start.toInt(),
                                _priceRange.end.toInt(),
                                _selectedFeatures,
                              );
                              context.pop();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        _showFilterModal();
                      },
                      icon: const Icon(Iconsax.filter),
                    ),
                    Expanded(
                      child: CustomSearchBar(
                        onSearch: _handleSearch,
                        hintText: 'جستجو...',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                FutureBuilder(
                  future: _futureResidences,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('هیچ اقامتگاهی یافت نشد'),
                      );
                    }
                    final residences = snapshot.data ?? [];
                    return Expanded(
                      child: ListView.builder(
                        itemCount: residences.length,
                        itemBuilder: (context, index) {
                          final item = residences[index];
                          return Column(
                            children: [
                              SimpleResidenceCard(residence: item),
                              const SizedBox(height: 16),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// showModalBottomSheet(
                        //   isScrollControlled: true,
                        //   backgroundColor: AppColors.white,
                        //   context: context,
                        //   builder:
                        //       (context) => Container(
                        //         padding: EdgeInsets.all(16.0),
                        //         width: MediaQuery.of(context).size.width,
                        //         child: SingleChildScrollView(
                        //           child: Column(
                        //             mainAxisSize: MainAxisSize.min,
                        //             children: [
                        //               const Text(
                        //                 'فیلترها',
                        //                 style: TextStyle(
                        //                   fontSize: 20,
                        //                   fontWeight: FontWeight.bold,
                        //                   color: AppColors.primary800,
                        //                 ),
                        //               ),
                        //               const SizedBox(height: 16),
                        //               Column(
                        //                 crossAxisAlignment:
                        //                     CrossAxisAlignment.start,
                        //                 children: [
                        //                   const Text(
                        //                     'قیمت',
                        //                     style: TextStyle(
                        //                       fontSize: 16,
                        //                       fontWeight: FontWeight.bold,
                        //                     ),
                        //                   ),
                        //                   const SizedBox(height: 2),
                        //                   Row(
                        //                     children: [
                        //                       Expanded(
                        //                         child: InputTextField(
                        //                           label: 'حداقل قیمت',
                        //                           keyboardType:
                        //                               TextInputType.number,
                        //                         ),
                        //                       ),
                        //                       const SizedBox(width: 16),
                        //                       Expanded(
                        //                         child: InputTextField(
                        //                           label: 'حداکثر قیمت',
                        //                           keyboardType:
                        //                               TextInputType.number,
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ],
                        //               ),
                        //               const SizedBox(height: 16),
                        //               Column(
                        //                 crossAxisAlignment:
                        //                     CrossAxisAlignment.start,
                        //                 children: [
                        //                   const Text(
                        //                     'مکان',
                        //                     style: TextStyle(
                        //                       fontSize: 16,
                        //                       fontWeight: FontWeight.bold,
                        //                     ),
                        //                   ),
                        //                   const SizedBox(height: 8),
                        //                   Row(
                        //                     children: [
                        //                       Expanded(
                        //                         child: DropDownField<
                        //                           ProvinceModel
                        //                         >(
                        //                           list: provinces,
                        //                           label: 'انتخاب استان',
                        //                           getLabel:
                        //                               (province) =>
                        //                                   province.name,
                        //                           initialValue:
                        //                               selectedProvince,
                        //                           onChanged: (province) {
                        //                             setState(() {
                        //                               selectedProvince =
                        //                                   province;
                        //                               selectedCity = null;
                        //                             });
                        //                           },
                        //                         ),
                        //                       ),
                        //                       const SizedBox(width: 8),
                        //                       Expanded(
                        //                         child: DropDownField<CityModel>(
                        //                           list:
                        //                               selectedProvince
                        //                                   ?.cities ??
                        //                               [],
                        //                           label: 'انتخاب شهر',
                        //                           getLabel: (city) => city.name,
                        //                           initialValue: selectedCity,
                        //                           onChanged: (city) {
                        //                             setState(() {
                        //                               selectedCity = city;
                        //                             });
                        //                           },
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ],
                        //               ),
                        //               const SizedBox(height: 24),
                        //               Column(
                        //                 crossAxisAlignment:
                        //                     CrossAxisAlignment.start,
                        //                 children: [
                        //                   const Text(
                        //                     'امکانات',
                        //                     style: TextStyle(
                        //                       fontSize: 16,
                        //                       fontWeight: FontWeight.bold,
                        //                     ),
                        //                   ),
                        //                   const SizedBox(height: 8),
                        //                   MultiSelectDropdown(
                        //                     options: facilities,
                        //                     selectedOptions: selectedFacilities,
                        //                     onSelectionChanged: (
                        //                       List<String> values,
                        //                     ) {
                        //                       setState(() {
                        //                         selectedFacilities = values;
                        //                       });
                        //                     },
                        //                   ),
                        //                 ],
                        //               ),
                        //               const SizedBox(height: 16),
                        //               Row(
                        //                 mainAxisAlignment:
                        //                     MainAxisAlignment.spaceBetween,
                        //                 children: [
                        //                   OutlinedButton(
                        //                     onPressed: () => context.pop(),
                        //                     style: OutlinedButton.styleFrom(
                        //                       side: BorderSide(
                        //                         color: AppColors.error200,
                        //                         width: 2,
                        //                       ),
                        //                       shape: RoundedRectangleBorder(
                        //                         borderRadius:
                        //                             BorderRadius.circular(8),
                        //                       ),
                        //                       padding: EdgeInsets.symmetric(
                        //                         horizontal: 16,
                        //                         vertical: 10,
                        //                       ),
                        //                     ),
                        //                     child: const Text(
                        //                       'بازگشت',
                        //                       style: TextStyle(
                        //                         fontSize: 18,
                        //                         fontWeight: FontWeight.w500,
                        //                         color: AppColors.error200,
                        //                       ),
                        //                     ),
                        //                   ),
                        //                   const SizedBox(width: 16),
                        //                   Expanded(
                        //                     child: Button(
                        //                       label: 'اعمال فیلتر',
                        //                       onPressed: () {},
                        //                     ),
                        //                   ),
                        //                 ],
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        // );
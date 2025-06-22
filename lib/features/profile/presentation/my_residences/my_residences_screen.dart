import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
import 'package:safar_khaneh/data/models/my_residence_model.dart';
import 'package:safar_khaneh/widgets/cards/my_residence_card.dart';

final List<MyResidenceModel> myResidenceList = [
  MyResidenceModel(
    id: '1',
    title: 'خانه بزرگ',
    city: 'اصفهان',
    province: 'کاشان',
    latitude: 38.8977,
    longitude: -77.0365,
    price: 120000,
    cleaningFee: 10000,
    serviceFee: 20000,
    rating: 4.5,
    backgroundImage: 'assets/images/Residences/2.jpg',
    phoneNumber: 09123456789,
    roomCount: 2,
    description: 'توضیحات',
    facilities: ['استخر', 'غذا', 'حسوم', 'عدم وجود پسر'],
    capacity: 2,
    manager: 'شاپرک مرادی',
  ),
  MyResidenceModel(
    id: '2',
    title: 'ویلا کوهستانی',
    city: 'قم',
    province: 'قم',
    latitude: 38.8977,
    longitude: -77.0365,
    price: 150000,
    cleaningFee: 10000,
    serviceFee: 20000,
    rating: 4.7,
    backgroundImage: 'assets/images/Residences/1.jpg',
    phoneNumber: 09123456789,
    roomCount: 4,
    description: 'توضیحات',
    facilities: ['استخر', 'غذا', 'حسوم', 'عدم وجود پسر'],
    capacity: 4,
    manager: 'مهدی حسومی',
  ),
  MyResidenceModel(
    id: '2',
    title: 'ویلا کوهستانی',
    city: 'تهران',
    province: 'تهران',
    latitude: 38.8977,
    longitude: -77.0365,
    price: 150000,
    cleaningFee: 10000,
    serviceFee: 20000,
    rating: 4.7,
    backgroundImage: 'assets/images/Residences/3.jpg',
    phoneNumber: 09123456789,
    roomCount: 2,
    description: 'توضیحات',
    facilities: ['استخر', 'غذا', 'حسوم', 'عدم وجود پسر'],
    capacity: 6,
    manager: 'حسین روحی',
  ),
  MyResidenceModel(
    id: '2',
    title: 'ویلا کوهستانی',
    city: 'گیلان',
    province: 'رشت',
    latitude: 38.8977,
    longitude: -77.0365,
    price: 150000,
    cleaningFee: 10000,
    serviceFee: 20000,
    rating: 4.7,
    backgroundImage: 'assets/images/Residences/5.jpg',
    phoneNumber: 09123456789,
    roomCount: 1,
    description: 'توضیحات',
    facilities: ['استخر', 'غذا', 'حسوم', 'عدم وجود پسر'],
    capacity: 7,
    manager: 'عادل پورسخن',
  ),
  MyResidenceModel(
    id: '2',
    title: 'ویلا کوهستانی',
    city: 'لرستان',
    province: 'درود',
    latitude: 38.8977,
    longitude: -77.0365,
    price: 150000,
    cleaningFee: 10000,
    serviceFee: 20000,
    rating: 4.7,
    backgroundImage: 'assets/images/Residences/4.jpg',
    phoneNumber: 09123456789,
    roomCount: 5,
    description: 'توضیحات',
    facilities: ['استخر', 'غذا', 'حسوم', 'عدم وجود پسر'],
    capacity: 10,
    manager: 'محمد جعفری',
  ),
];

class MyResidenceScreen extends StatelessWidget {
  const MyResidenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('اقامتگاه های من'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Iconsax.arrow_left),
              onPressed: () => context.pop(),
            ),
          ],
        ),
        body: Container(
          color: AppColors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: myResidenceList.length,
              itemBuilder: (context, index) {
                final item = myResidenceList[index];
                return Column(
                  children: [
                    MyResidenceCard(residence: item),
                    const SizedBox(height: 8),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

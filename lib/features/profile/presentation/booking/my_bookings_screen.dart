import 'package:flutter/material.dart';
import 'package:safar_khaneh/data/models/booked_residence_model.dart';
import 'package:safar_khaneh/widgets/booking_tab_bar.dart';
import 'package:safar_khaneh/widgets/cards/booked_residence_card.dart';

final List<BookedResidenceModel> bookedResidenceList = [
  BookedResidenceModel(
    id: '1',
    title: 'خانه بزرگ',
    city: 'کاشان',
    province: 'کاشان',
    latitude: 38.8977,
    longitude: -77.0365,
    price: 120000,
    rating: 4.5,
    backgroundImage: 'assets/images/Residences/3.jpg',
    phoneNumber: 09123456789,
    startDate: '1400/01/01',
    endDate: '1400/01/01',
    manager: 'میلادی',
    capacity: 4,
    status: 'passed',
  ),
  BookedResidenceModel(
    id: '2',
    title: 'ویلا کوهستانی',
    city: 'قم',
    province: 'قم',
    latitude: 38.8977,
    longitude: -77.0365,
    price: 150000,
    rating: 4.7,
    backgroundImage: 'assets/images/Residences/1.jpg',
    phoneNumber: 09123456789,
    startDate: '1400/01/01',
    endDate: '1400/01/01',
    manager: 'میلادی',
    capacity: 4,
    status: 'remaining',
  ),
  BookedResidenceModel(
    id: '3',
    title: 'آپارتمان لوکس',
    city: 'تهران',
    province: 'سعادت آباد',
    latitude: 38.8977,
    longitude: -77.0365,
    price: 200000,
    rating: 4.8,
    backgroundImage: 'assets/images/Residences/2.jpg',
    phoneNumber: 09123456789,
    startDate: '1400/01/01',
    endDate: '1400/01/01',
    manager: 'میلادی',
    capacity: 4,
    status: 'remaining',
  ),
  BookedResidenceModel(
    id: '4',
    title: 'خانه سنتی',
    city: 'کاشان',
    province: 'کاشان',
    latitude: 38.8977,
    longitude: -77.0365,
    price: 100000,
    rating: 4.3,
    backgroundImage: 'assets/images/Residences/4.jpg',
    phoneNumber: 09123456789,
    startDate: '1400/01/01',
    endDate: '1400/01/01',
    manager: 'میلادی',
    capacity: 4,
    status: 'passed',
  ),
  BookedResidenceModel(
    id: '4',
    title: 'خانه سنتی',
    city: 'کاشان',
    province: 'کاشان',
    latitude: 38.8977,
    longitude: -77.0365,
    price: 100000,
    rating: 4.3,
    backgroundImage: 'assets/images/Residences/4.jpg',
    phoneNumber: 09123456789,
    startDate: '1400/01/01',
    endDate: '1400/01/01',
    manager: 'میلادی',
    capacity: 4,
    status: 'remaining',
  ),
  BookedResidenceModel(
    id: '5',
    title: 'ویلا کوهستانی',
    city: 'قم',
    province: 'قم',
    latitude: 38.8977,
    longitude: -77.0365,
    price: 100000,
    rating: 4.3,
    backgroundImage: 'assets/images/Residences/4.jpg',
    phoneNumber: 09123456789,
    startDate: '1400/01/01',
    endDate: '1400/01/01',
    manager: 'میلادی',
    capacity: 4,
    status: 'passed',
  ),
  BookedResidenceModel(
    id: '6',
    title: 'ویلا کویری',
    city: 'قم',
    province: 'قم',
    latitude: 38.8977,
    longitude: -77.0365,
    price: 100000,
    rating: 4.3,
    backgroundImage: 'assets/images/Residences/2.jpg',
    phoneNumber: 09123456789,
    startDate: '1400/01/01',
    endDate: '1400/01/01',
    manager: 'میلادی',
    capacity: 4,
    status: 'remaining',
  ),
];

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  bool isBookedSelected = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          BookingTabBar(
            isBookedSelected: isBookedSelected,
            onTabSelected: (value) {
              setState(() {
                isBookedSelected = value;
              });
            },
          ),

          const SizedBox(height: 16),

          if (isBookedSelected)
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount:
                    bookedResidenceList
                        .where((item) => item.status == 'remaining')
                        .length,
                itemBuilder: (context, index) {
                  final filteredList =
                      bookedResidenceList
                          .where((item) => item.status == 'remaining')
                          .toList();
                  final item = filteredList[index];
                  return Column(
                    children: [
                      BookedResidenceCard(residence: item),
                      const SizedBox(height: 16),
                    ],
                  );
                },
              ),
            ),

          if (!isBookedSelected)
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount:
                    bookedResidenceList
                        .where((item) => item.status == 'passed')
                        .length,
                itemBuilder: (context, index) {
                  final filteredList =
                      bookedResidenceList
                          .where((item) => item.status == 'passed')
                          .toList();
                  final item = filteredList[index];
                  return Column(
                    children: [
                      BookedResidenceCard(residence: item),
                      const SizedBox(height: 16),
                    ],
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

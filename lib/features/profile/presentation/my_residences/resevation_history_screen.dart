import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh/data/models/my_residence_model.dart';
import 'package:safar_khaneh/data/models/vendor_reservation_model.dart';
import 'package:safar_khaneh/widgets/booking_tab_bar.dart';
import 'package:safar_khaneh/widgets/cards/vendor_reservation_card.dart';

final List<VendorReservationModel> vendorReservationList = [
  VendorReservationModel(
    id: '1',
    title: 'خانه بزرگ',
    city: 'کاشان',
    province: 'کاشان',
    price: 120000,
    rating: 4.5,
    backgroundImage: 'assets/images/Residences/3.jpg',
    booker: 'احمدی',
    startDate: '1400/01/01',
    endDate: '1400/01/01',
    phoneNumber: 09123456789,
    capacity: 4,
    status: 'passed',
  ),
  VendorReservationModel(
    id: '2',
    title: 'ویلا کوهستانی',
    city: 'قم',
    province: 'قم',
    price: 150000,
    rating: 4.7,
    backgroundImage: 'assets/images/Residences/1.jpg',
    booker: 'میلادی',
    startDate: '1400/01/01',
    endDate: '1400/01/01',
    phoneNumber: 09123456789,
    capacity: 4,
    status: 'remaining',
  ),
  VendorReservationModel(
    id: '3',
    title: 'آپارتمان لوکس',
    city: 'تهران',
    province: 'سعادت آباد',
    price: 200000,
    rating: 4.8,
    backgroundImage: 'assets/images/Residences/2.jpg',
    booker: 'شمسایی',
    startDate: '1400/01/01',
    endDate: '1400/01/01',
    phoneNumber: 09123456789,
    capacity: 4,
    status: 'remaining',
  ),
  VendorReservationModel(
    id: '4',
    title: 'ویلا کوهستانی',
    city: 'قم',
    province: 'قم',
    price: 150000,
    rating: 4.7,
    backgroundImage: 'assets/images/Residences/1.jpg',
    booker: 'میلادی',
    startDate: '1400/01/01',
    endDate: '1400/01/01',
    phoneNumber: 09123456789,
    capacity: 4,
    status: 'passed',
  ),
  VendorReservationModel(
    id: '5',
    title: 'ویلا کوهستانی',
    city: 'قم',
    province: 'قم',
    price: 150000,
    rating: 4.7,
    backgroundImage: 'assets/images/Residences/1.jpg',
    booker: 'محمدی',
    startDate: '1400/01/01',
    endDate: '1400/01/01',
    phoneNumber: 09123456789,
    capacity: 4,
    status: 'passed',
  ),
];

class ReservationHistoryScreen extends StatefulWidget {
  final MyResidenceModel residence;
  const ReservationHistoryScreen({super.key, required this.residence});

  @override
  State<ReservationHistoryScreen> createState() =>
      _ReservationHistoryScreenState();
}

class _ReservationHistoryScreenState extends State<ReservationHistoryScreen> {
  bool isBookedSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('تاریخچه رزرو'),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.arrow_left),
            onPressed: () => context.pop(),
          ),
        ],
      ),
      body: Container(
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
                      vendorReservationList
                          .where((item) => item.status == 'remaining')
                          .length,
                  itemBuilder: (context, index) {
                    final filteredList =
                        vendorReservationList
                            .where((item) => item.status == 'remaining')
                            .toList();
                    final item = filteredList[index];
                    return Column(
                      children: [
                        VendorReservationCard(
                          vendorReservation: item,
                          link: '/profile/my_residence/menu_residence/${widget.residence.id}/reservation_history/${item.id}',
                        ),
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
                      vendorReservationList
                          .where((item) => item.status == 'passed')
                          .length,
                  itemBuilder: (context, index) {
                    final filteredList =
                        vendorReservationList
                            .where((item) => item.status == 'passed')
                            .toList();
                    final item = filteredList[index];
                    return Column(
                      children: [
                        VendorReservationCard(
                          vendorReservation: item,
                          link: '/profile/my_residence/menu_residence/${widget.residence.id}/reservation_history/${item.id}',
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

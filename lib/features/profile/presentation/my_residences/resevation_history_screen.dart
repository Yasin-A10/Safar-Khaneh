import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh/config/router/app_router.dart';
import 'package:safar_khaneh/features/profile/data/models/vendor_reservation_model.dart';
import 'package:safar_khaneh/features/profile/data/services/vendor_reservation_service.dart';
import 'package:safar_khaneh/widgets/booking_tab_bar.dart';
import 'package:safar_khaneh/widgets/cards/vendor_reservation_card.dart';

class ReservationHistoryScreen extends StatefulWidget {
  final ResidenceContextModel contextModel;
  const ReservationHistoryScreen({super.key, required this.contextModel});

  @override
  State<ReservationHistoryScreen> createState() =>
      _ReservationHistoryScreenState();
}

class _ReservationHistoryScreenState extends State<ReservationHistoryScreen> {
  final VendorReservationService _vendorReservationService =
      VendorReservationService();
  bool isBookedSelected = true;
  late Future<List<VendorReservationModel>> _vendorReservations;

  @override
  void initState() {
    super.initState();
    _vendorReservations = _vendorReservationService.fetchVendorReservations(
      widget.contextModel.residence.id!.toInt(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final residence = widget.contextModel.residence;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

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
                child: FutureBuilder(
                  future: _vendorReservations,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    final reservationList = snapshot.data ?? [];

                    final upcomingReservations =
                        reservationList.where((item) {
                          final start = DateTime.parse(item.checkIn!);
                          return start.isAfter(today);
                        }).toList();

                    if (upcomingReservations.isEmpty) {
                      return const Center(
                        child: Text('هیچ رزرو آینده‌ای یافت نشد'),
                      );
                    }
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: upcomingReservations.length,
                      itemBuilder: (context, index) {
                        final item = upcomingReservations[index];
                        return Column(
                          children: [
                            VendorReservationCard(
                              vendorReservation: item,
                              link:
                                  '/profile/my_residence/menu_residence/${residence.id}/reservation_history/${item.id}',
                            ),
                            const SizedBox(height: 8),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),

            if (!isBookedSelected)
              Expanded(
                child: FutureBuilder(
                  future: _vendorReservations,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    final reservationList = snapshot.data ?? [];

                    final pastReservations =
                        reservationList.where((item) {
                          final start = DateTime.parse(item.checkIn!);
                          return !start.isAfter(today);
                        }).toList();

                    if (pastReservations.isEmpty) {
                      return const Center(
                        child: Text('هیچ رزرو گذشته یافت نشد'),
                      );
                    }
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: pastReservations.length,
                      itemBuilder: (context, index) {
                        final item = pastReservations[index];
                        return Column(
                          children: [
                            VendorReservationCard(
                              vendorReservation: item,
                              link:
                                  '/profile/my_residence/menu_residence/${residence.id}/reservation_history/${item.id}',
                            ),
                            const SizedBox(height: 8),
                          ],
                        );
                      },
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

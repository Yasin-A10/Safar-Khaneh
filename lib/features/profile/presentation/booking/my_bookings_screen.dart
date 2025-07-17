import 'package:flutter/material.dart';
import 'package:safar_khaneh/features/profile/data/my_booking_model.dart';
import 'package:safar_khaneh/features/profile/data/my_booking_service.dart';
import 'package:safar_khaneh/widgets/booking_tab_bar.dart';
import 'package:safar_khaneh/widgets/cards/booked_residence_card.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  final UserReservationService userReservationService =
      UserReservationService();

  late Future<List<UserReservationModel>> _userReservations;

  bool isBookedSelected = true;

  @override
  void initState() {
    super.initState();
    _userReservations = userReservationService.fetchUserReservations();
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _userReservations = userReservationService.fetchUserReservations();
    });
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return Container(
      height: double.infinity,
      padding: const EdgeInsets.all(16),
      child: RefreshIndicator(
        onRefresh: _handleRefresh,
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

            // لیست رزروهای آینده
            if (isBookedSelected)
              Expanded(
                child: FutureBuilder<List<UserReservationModel>>(
                  future: _userReservations,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('خطا: ${snapshot.error}'));
                    }

                    final residences = snapshot.data ?? [];

                    final upcomingReservations =
                        residences.where((item) {
                          final start = DateTime.parse(item.checkIn!);
                          return start.isAfter(today);
                        }).toList();

                    if (upcomingReservations.isEmpty) {
                      return const Center(
                        child: Text('هیچ رزرو آینده‌ای یافت نشد'),
                      );
                    }

                    return ListView.builder(
                      itemCount: upcomingReservations.length,
                      itemBuilder: (context, index) {
                        final item = upcomingReservations[index];
                        return Column(
                          children: [
                            BookedResidenceCard(reservation: item),
                            const SizedBox(height: 8),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),

            // لیست رزروهای در گذشته یا فعال
            if (!isBookedSelected)
              Expanded(
                child: FutureBuilder<List<UserReservationModel>>(
                  future: _userReservations,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('خطا: ${snapshot.error}'));
                    }

                    final residences = snapshot.data ?? [];

                    final pastReservations =
                        residences.where((item) {
                          final start = DateTime.parse(item.checkIn!);
                          return !start.isAfter(today);
                        }).toList();

                    if (pastReservations.isEmpty) {
                      return const Center(
                        child: Text('هیچ رزروی در گذشته یافت نشد'),
                      );
                    }

                    return ListView.builder(
                      itemCount: pastReservations.length,
                      itemBuilder: (context, index) {
                        final item = pastReservations[index];
                        return Column(
                          children: [
                            BookedResidenceCard(reservation: item),
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

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
  UserReservationService userReservationService = UserReservationService();

  late Future<List<UserReservationModel>> _userReservations;

  bool isBookedSelected = true;

  @override
  void initState() {
    super.initState();
    _userReservations = userReservationService.fetchUserReservations();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
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
                future: _userReservations,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (snapshot.data!
                      .where((item) => item.status == 'confirmed')
                      .isEmpty) {
                    return const Center(child: Text('هیچ اقامتگاهی یافت نشد'));
                  }
                  final residences = snapshot.data ?? [];
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount:
                        residences
                            .where((item) => item.status == 'confirmed')
                            .length,
                    itemBuilder: (context, index) {
                      final item = residences[index];
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

          if (!isBookedSelected)
            Expanded(
              child: FutureBuilder(
                future: _userReservations,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (snapshot.data!
                      .where((item) => item.status == 'pending')
                      .isEmpty) {
                    return const Center(child: Text('هیچ اقامتگاهی یافت نشد'));
                  }
                  final residences = snapshot.data ?? [];
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount:
                        residences
                            .where((item) => item.status == 'pending')
                            .length,
                    itemBuilder: (context, index) {
                      final item = residences[index];
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
    );
  }
}

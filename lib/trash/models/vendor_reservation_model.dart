class VendorReservationModel {
  final String id;
  final String title;
  final String? city;
  final String? province;
  final int price;
  final double rating;
  final String backgroundImage;
  final String booker;
  final String startDate;
  final String endDate;
  final double? latitude;
  final double? longitude;
  final int phoneNumber;
  final int capacity;
  final String? status;

  VendorReservationModel({
    required this.id,
    required this.title,
    this.city,
    this.province,
    required this.price,
    required this.rating,
    required this.backgroundImage,
    required this.startDate,
    required this.endDate,
    this.latitude,
    this.longitude,
    required this.phoneNumber,
    required this.booker,
    required this.capacity,
    required this.status,
  });
}

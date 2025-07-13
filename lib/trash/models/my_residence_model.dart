class MyResidenceModel {
  final String id;
  final String title;
  final String? city;
  final String? province;
  final double latitude;
  final double longitude;
  final int price;
  final int? maxDays;
  final int? cleaningFee;
  final int? serviceFee;
  final double rating;
  final String backgroundImage;
  final int phoneNumber;
  final int roomCount;
  final List<String> facilities;
  final String? description;
  final int capacity;
  final String manager;

  MyResidenceModel({
    required this.id,
    required this.title,
    this.city,
    this.province,
    required this.latitude,
    required this.longitude,
    required this.price,
    this.maxDays,
    required this.cleaningFee,
    required this.serviceFee,
    required this.rating,
    required this.backgroundImage,
    required this.phoneNumber,
    required this.roomCount,
    required this.facilities,
    this.description,
    required this.capacity,
    required this.manager,
  });
}

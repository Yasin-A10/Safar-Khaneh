class ResidenceCardModel {
  final String id;
  final String title;
  final String? city;
  final String? province;
  final String? startDate;
  final double? latitude;
  final double? longitude;
  final String? endDate;
  final int price;
  final double rating;
  final String? description;
  final List<String>? facilities;
  final String backgroundImage;
  bool? isFavorite;
  final int capacity;
  final int? roomCount;
  final String? manager;
  final int? cleaningFee;
  final int? serviceFee;
  final int? phoneNumber;

  ResidenceCardModel({
    required this.id,
    required this.title,
    this.city,
    this.province,
    this.startDate,
    this.latitude,
    this.longitude,
    this.endDate,
    required this.price,
    required this.rating,
    this.description,
    this.facilities,
    this.isFavorite,
    required this.backgroundImage,
    required this.capacity,
    this.roomCount,
    this.manager,
    this.cleaningFee,
    this.serviceFee,
    this.phoneNumber,
  });
}

class ReviewModel {
  final int id;
  final double? rating;
  final String comment;
  final DateTime createdAt;
  final ReviewResidenceModel residence;

  ReviewModel({
    required this.id,
    this.rating,
    required this.comment,
    required this.createdAt,
    required this.residence,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      rating: json['rating']?.toDouble(),
      comment: json['comment'],
      createdAt: DateTime.parse(json['created_at']),
      residence: ReviewResidenceModel.fromJson(json['residence']),
    );
  }
}

class ReviewResidenceModel {
  final int id;
  final String title;
  final String description;
  final String type;
  final LocationModel location;
  final DateTime createdAt;

  ReviewResidenceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.location,
    required this.createdAt,
  });

  factory ReviewResidenceModel.fromJson(Map<String, dynamic> json) {
    return ReviewResidenceModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      type: json['type'],
      location: LocationModel.fromJson(json['location']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

class LocationModel {
  final int id;
  final String address;
  final CityModel city;
  final String lat;
  final String lng;

  LocationModel({
    required this.id,
    required this.address,
    required this.city,
    required this.lat,
    required this.lng,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      address: json['address'],
      city: CityModel.fromJson(json['city']),
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}

class CityModel {
  final int id;
  final String name;
  final ProvinceModel province;

  CityModel({
    required this.id,
    required this.name,
    required this.province,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'],
      name: json['name'],
      province: ProvinceModel.fromJson(json['province']),
    );
  }
}

class ProvinceModel {
  final int id;
  final String name;

  ProvinceModel({
    required this.id,
    required this.name,
  });

  factory ProvinceModel.fromJson(Map<String, dynamic> json) {
    return ProvinceModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

import 'package:safar_khaneh/data/real-models/feature_model.dart';

class VendorReservationModel {
  int? id;
  String? checkIn;
  String? checkOut;
  int? totalPrice;
  int? guestCount;
  String? status;
  int? pricePerNightSnapshot;
  int? cleaningPriceSnapshot;
  int? servicesPriceSnapshot;
  int? maxNightsStaySnapshot;
  int? capacitySnapshot;
  String? createdAt;
  String? updatedAt;
  Residence? residence;
  Owner? user;

  VendorReservationModel({
    this.id,
    this.checkIn,
    this.checkOut,
    this.totalPrice,
    this.guestCount,
    this.status,
    this.pricePerNightSnapshot,
    this.cleaningPriceSnapshot,
    this.servicesPriceSnapshot,
    this.maxNightsStaySnapshot,
    this.capacitySnapshot,
    this.createdAt,
    this.updatedAt,
    this.residence,
    this.user,
  });

  VendorReservationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    checkIn = json['check_in'];
    checkOut = json['check_out'];
    totalPrice = json['total_price'];
    guestCount = json['guest_count'];
    status = json['status'];
    pricePerNightSnapshot = json['price_per_night_snapshot'];
    cleaningPriceSnapshot = json['cleaning_price_snapshot'];
    servicesPriceSnapshot = json['services_price_snapshot'];
    maxNightsStaySnapshot = json['max_nights_stay_snapshot'];
    capacitySnapshot = json['capacity_snapshot'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    residence =
        json['residence'] != null
            ? new Residence.fromJson(json['residence'])
            : null;
    user = json['user'] != null ? new Owner.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['check_in'] = this.checkIn;
    data['check_out'] = this.checkOut;
    data['total_price'] = this.totalPrice;
    data['guest_count'] = this.guestCount;
    data['status'] = this.status;
    data['price_per_night_snapshot'] = this.pricePerNightSnapshot;
    data['cleaning_price_snapshot'] = this.cleaningPriceSnapshot;
    data['services_price_snapshot'] = this.servicesPriceSnapshot;
    data['max_nights_stay_snapshot'] = this.maxNightsStaySnapshot;
    data['capacity_snapshot'] = this.capacitySnapshot;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.residence != null) {
      data['residence'] = this.residence!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Residence {
  int? id;
  String? title;
  String? description;
  String? type;
  String? avgRating;
  int? ratingCount;
  int? capacity;
  int? maxNightsStay;
  int? pricePerNight;
  int? roomCount;
  int? cleaningPrice;
  int? servicesPrice;
  String? status;
  String? imageUrl;
  bool? isActive;
  Location? location;
  String? createdAt;
  Owner? owner;
  List<FeatureModel>? features;

  Residence({
    this.id,
    this.title,
    this.description,
    this.type,
    this.avgRating,
    this.ratingCount,
    this.capacity,
    this.maxNightsStay,
    this.pricePerNight,
    this.roomCount,
    this.cleaningPrice,
    this.servicesPrice,
    this.status,
    this.imageUrl,
    this.isActive,
    this.location,
    this.createdAt,
    this.owner,
    this.features,
  });

  Residence.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    type = json['type'];
    avgRating = json['avg_rating'];
    ratingCount = json['rating_count'];
    capacity = json['capacity'];
    maxNightsStay = json['max_nights_stay'];
    pricePerNight = json['price_per_night'];
    roomCount = json['room_count'];
    cleaningPrice = json['cleaning_price'];
    servicesPrice = json['services_price'];
    status = json['status'];
    imageUrl = json['image_url'];
    isActive = json['is_active'];
    location =
        json['location'] != null
            ? new Location.fromJson(json['location'])
            : null;
    createdAt = json['created_at'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    if (json['features'] != null) {
      features = <FeatureModel>[];
      json['features'].forEach((v) {
        features!.add(FeatureModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['type'] = this.type;
    data['avg_rating'] = this.avgRating;
    data['rating_count'] = this.ratingCount;
    data['capacity'] = this.capacity;
    data['max_nights_stay'] = this.maxNightsStay;
    data['price_per_night'] = this.pricePerNight;
    data['room_count'] = this.roomCount;
    data['cleaning_price'] = this.cleaningPrice;
    data['services_price'] = this.servicesPrice;
    data['status'] = this.status;
    data['image_url'] = this.imageUrl;
    data['is_active'] = this.isActive;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['created_at'] = this.createdAt;
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    if (this.features != null) {
      data['features'] = this.features!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Location {
  int? id;
  String? address;
  City? city;
  String? lat;
  String? lng;

  Location({this.id, this.address, this.city, this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address'] = this.address;
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class City {
  int? id;
  String? name;
  Province? province;

  City({this.id, this.name, this.province});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    province =
        json['province'] != null
            ? new Province.fromJson(json['province'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.province != null) {
      data['province'] = this.province!.toJson();
    }
    return data;
  }
}

class Province {
  int? id;
  String? name;

  Province({this.id, this.name});

  Province.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Owner {
  int? id;
  String? fullName;
  String? phoneNumber;

  Owner({this.id, this.fullName, this.phoneNumber});

  Owner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['phone_number'] = this.phoneNumber;
    return data;
  }
}

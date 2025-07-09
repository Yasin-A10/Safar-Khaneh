import 'package:safar_khaneh/data/real-models/feature_model.dart';

class ResidenceModel {
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
  Location? location;
  String? createdAt;
  Owner? owner;
  List<FeatureModel>? features;
  bool? isActive;

  ResidenceModel({
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
    this.location,
    this.createdAt,
    this.owner,
    this.features,
    this.isActive,
  });

  ResidenceModel.fromJson(Map<String, dynamic> json) {
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
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    createdAt = json['created_at'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    if (json['features'] != null) {
      features = <FeatureModel>[];
      json['features'].forEach((v) {
        features!.add(FeatureModel.fromJson(v));
      });
    }
    isActive = json['is_active'];
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
    data['is_active'] = this.isActive;
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
    city = json['city'] != null ? City.fromJson(json['city']) : null;
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

// class City {
//   int? id;
//   String? name;
//   Province? province;

//   City({this.id, this.name, this.province});

//   City.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     province =
//         json['province'] != null ? Province.fromJson(json['province']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     if (this.province != null) {
//       data['province'] = this.province!.toJson();
//     }
//     return data;
//   }
// }

class City {
  int? id;
  String? name;
  Province? province;

  City({this.id, this.name, this.province});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    province =
        json['province'] != null ? Province.fromJson(json['province']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    if (province != null) {
      data['province'] = province!.toJson();
    }
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is City && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'City(id: $id, name: $name)';
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

// class Province {
//   int? id;
//   String? name;

//   Province({this.id, this.name});

//   Province.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     return data;
//   }
// }

class Province {
  int? id;
  String? name;

  Province({this.id, this.name});

  Province.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  // Override کردن == برای مقایسه صحیح در DropdownButton و غیره
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Province && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Province(id: $id, name: $name)';
  }
}

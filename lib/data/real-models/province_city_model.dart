class Province {
  final int id;
  final String name;

  Province({required this.id, required this.name});

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Province && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class City {
  final int id;
  final String name;
  final Province province;

  City({required this.id, required this.name, required this.province});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      province: Province.fromJson(json['province']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'province': province.toJson()};
  }
}

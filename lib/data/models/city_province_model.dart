class CityModel {
  final int id;
  final String name;

  CityModel({required this.id, required this.name});
}

class ProvinceModel {
  final int id;
  final String name;
  final List<CityModel> cities;

  ProvinceModel({required this.id, required this.name, required this.cities});
}

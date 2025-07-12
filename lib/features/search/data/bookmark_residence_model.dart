import 'package:safar_khaneh/features/search/data/residence_model.dart';

class BookmarkedResidenceModel {
  final int id;
  final ResidenceModel residence;

  BookmarkedResidenceModel({
    required this.id,
    required this.residence,
  });

  factory BookmarkedResidenceModel.fromJson(Map<String, dynamic> json) {
    return BookmarkedResidenceModel(
      id: json['id'],
      residence: ResidenceModel.fromJson(json['residence']),
    );
  }
}

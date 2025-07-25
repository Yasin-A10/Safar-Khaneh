import 'package:safar_khaneh/features/search/data/residence_model.dart';

class HomePageModel {
  final List<ResidenceModel> topRatedResidences;
  final List<ResidenceModel> newestResidences;

  HomePageModel({
    required this.topRatedResidences,
    required this.newestResidences,
  });

  factory HomePageModel.fromJson(Map<String, dynamic> json) {
    return HomePageModel(
      topRatedResidences: List<ResidenceModel>.from(
        json['top_rated_residences'].map((x) => ResidenceModel.fromJson(x)),
      ),
      newestResidences: List<ResidenceModel>.from(
        json['newest_residences'].map((x) => ResidenceModel.fromJson(x)),
      ),
    );
  }
}

class CommentModel {
  final int id;
  final double? rating;
  final String comment;
  final String createdAt;
  final UserModel user;

  CommentModel({
    required this.id,
    this.rating,
    required this.comment,
    required this.createdAt,
    required this.user,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      rating: json['rating']?.toDouble(),
      comment: json['comment'],
      createdAt: json['created_at'],
      user: UserModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rating': rating,
      'comment': comment,
      'created_at': createdAt,
      'user': user.toJson(),
    };
  }
}
class UserModel {
  final int id;
  final String fullName;

  UserModel({
    required this.id,
    required this.fullName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      fullName: json['full_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
    };
  }
}

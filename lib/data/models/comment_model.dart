class CommentModel {
  final int id;
  final String name;
  final int residenceId;
  final String text;
  final double rating;
  final String createdAt;

  CommentModel({
    required this.id,
    required this.name,
    required this.residenceId,
    required this.text,
    required this.rating,
    required this.createdAt,
  });
}

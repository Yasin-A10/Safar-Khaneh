import 'package:safar_khaneh/features/search/data/models/residence_model.dart';

class ChatModel {
  final int id; // آیدی روم
  final ResidenceModel residence;
  final ChatUserModel user;
  final DateTime createdAt;

  ChatModel({
    required this.id,
    required this.residence,
    required this.user,
    required this.createdAt,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      residence: ResidenceModel.fromJson(json['residence']),
      user: ChatUserModel.fromJson(json['user']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

class ChatUserModel {
  final int id;
  final String fullName;

  ChatUserModel({required this.id, required this.fullName});

  factory ChatUserModel.fromJson(Map<String, dynamic> json) {
    return ChatUserModel(id: json['id'], fullName: json['full_name']);
  }
}

extension ChatModelExtension on ChatModel {
  ChatModel copyWithLastMessage({
    String? message,
    String? senderName,
    String? createdAt,
  }) {
    return ChatModel(
      id: id,
      user: ChatUserModel(id: user.id, fullName: senderName ?? user.fullName),
      residence: residence,
      createdAt: DateTime.parse(createdAt ?? this.createdAt.toIso8601String()),
    );
  }
}

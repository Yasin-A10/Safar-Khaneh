import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:safar_khaneh/core/network/secure_token_storage.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';

class ChatWebSocketService {
  final int roomId;
  WebSocketChannel? _channel;
  Function(TextMessage message)? onMessageReceived;

  ChatWebSocketService({required this.roomId});

  Future<void> connect() async {
    final token = await TokenStorage.getAccessToken();
    final uri = Uri.parse('ws://127.0.0.1:8008/api/ws/chat/$roomId/?token=$token');

    _channel = WebSocketChannel.connect(uri);

    _channel!.stream.listen((data) {
      final json = jsonDecode(data);
      final msg = TextMessage(
        id: json['message_id'].toString(),
        text: json['message'],
        authorId: json['sender_id'].toString(),
        createdAt: DateTime.parse(json['created_at']),
      );
      onMessageReceived?.call(msg);
    });
  }

  void sendMessage(String text) {
    _channel?.sink.add(jsonEncode({'message': text}));
  }

  void disconnect() {
    _channel?.sink.close();
  }
}

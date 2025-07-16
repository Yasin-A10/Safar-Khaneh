import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

typedef OnNotificationMessage = void Function(Map<String, dynamic>);

class ChatNotificationWebSocketService {
  WebSocketChannel? _channel;
  final OnNotificationMessage onMessage;

  ChatNotificationWebSocketService({required this.onMessage});

  void connect(String token) {
    final uri = Uri.parse(
      'ws://127.0.0.1:8008/api/ws/notifications/?token=$token',
    );
    _channel = WebSocketChannel.connect(uri);

    _channel!.stream.listen(
      (data) {
        final decoded = jsonDecode(data);
        onMessage(decoded);
      },
      onError: (error) {
        disconnect();
      },
    );
  }

  void disconnect() {
    _channel?.sink.close();
  }
}

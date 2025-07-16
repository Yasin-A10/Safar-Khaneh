import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
// import 'package:safar_khaneh/config/theme/app_theme.dart';
import 'package:safar_khaneh/data/service/chat_services.dart';
import 'package:safar_khaneh/data/service/chat_web_socket_service.dart';

class ChatScreen extends StatefulWidget {
  final int roomId;
  final int currentUserId;
  final String receiverName;

  const ChatScreen({
    super.key,
    required this.roomId,
    required this.currentUserId,
    required this.receiverName,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final InMemoryChatController _chatController;
  late final ChatService _chatService;
  late final ChatWebSocketService _wsService;

  final Map<String, User> _userCache = {};

  @override
  void initState() {
    super.initState();
    _chatController = InMemoryChatController();
    _chatService = ChatService();
    _wsService = ChatWebSocketService(roomId: widget.roomId);

    _wsService.onMessageReceived = (message) {
      _chatController.insertMessage(message);
    };

    _initializeChat();
  }

  Future<void> _initializeChat() async {
    await _wsService.connect();
    await _loadMessages();
  }

  Future<void> _loadMessages() async {
    final messages = await _chatService.getMessages(widget.roomId);
    for (var item in messages) {
      final userId = item['sender']['id'].toString();
      final userName = item['sender']['full_name'];

      _userCache[userId] = User(id: userId, name: userName);

      final message = TextMessage(
        id: item['id'].toString(),
        authorId: userId,
        text: item['message'],
        createdAt: DateTime.parse(item['created_at']),
      );

      _chatController.insertMessage(message);
    }
  }

  @override
  void dispose() {
    _chatController.dispose();
    _wsService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.receiverName),
            leading: IconButton(
              icon: const Icon(Iconsax.arrow_left_2),
              onPressed: () => context.pop(),
            ),
          ),
          body: Chat(
            chatController: _chatController,
            currentUserId: widget.currentUserId.toString(),
            onMessageSend: (text) {
              _wsService.sendMessage(text);
            },
            resolveUser: (userId) async {
              return Future.value(
                _userCache[userId] ?? User(id: userId, name: 'نامشخص'),
              );
            },
            // theme: AppChatTheme.light,
          ),
        ),
      ),
    );
  }
}

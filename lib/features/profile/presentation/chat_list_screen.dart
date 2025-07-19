import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh/core/network/secure_token_storage.dart';
import 'package:safar_khaneh/core/utils/convert_to_jalali.dart';
import 'package:safar_khaneh/core/utils/number_formater.dart';
import 'package:safar_khaneh/data/models/chat_model.dart';
import 'package:safar_khaneh/data/service/chat_notification_service.dart';
import 'package:safar_khaneh/data/service/chat_services.dart';
import 'package:safar_khaneh/features/search/data/residence_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final ChatService _chatService = ChatService();
  final List<ChatModel> _chatList = [];
  ChatNotificationWebSocketService? _wsService;
  int? _currentUserId;
  bool _isLoading = true;

  final Set<int> _roomsWithUnreadMessages = {};

  @override
  void initState() {
    super.initState();
    _loadUnreadRooms();
    _initChatListAndSocket();
  }

  Future<void> _loadUnreadRooms() async {
    final saved = await loadUnreadRooms();
    setState(() {
      _roomsWithUnreadMessages.addAll(saved);
    });
  }

  Future<void> _saveUnreadRooms() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = _roomsWithUnreadMessages.map((id) => id.toString()).toList();
    await prefs.setStringList('unread_rooms', ids);
  }

  Future<Set<int>> loadUnreadRooms() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList('unread_rooms') ?? [];
    return ids.map((id) => int.tryParse(id)).whereType<int>().toSet();
  }

  Future<void> _initChatListAndSocket() async {
    final token = await TokenStorage.getAccessToken();
    final userId = await TokenStorage.getUserId();

    setState(() {
      _currentUserId = userId;
    });

    try {
      final initialChats = await _chatService.getChatRooms();
      _chatList.addAll(initialChats);
    } catch (e) {
      debugPrint('خطا در دریافت چت‌ها: $e');
    }

    _wsService = ChatNotificationWebSocketService(
      onMessage: (data) async {
        final roomId = data['room_id'];
        final message = data['message'];
        final fromUser = data['from_user'];
        final createdAt = data['created_at'];

        final index = _chatList.indexWhere((c) => c.id == roomId);
        if (index != -1) {
          final chat = _chatList[index];
          _chatList[index] = chat.copyWithLastMessage(
            message: message,
            senderName: fromUser,
            createdAt: createdAt,
          );
        } else {
          _chatList.insert(
            0,
            ChatModel(
              id: roomId,
              user: ChatUserModel(id: _currentUserId!, fullName: fromUser),
              residence: ResidenceModel(title: 'اقامتگاه نامشخص'),
              createdAt: DateTime.parse(createdAt),
            ),
          );
        }

        if (fromUser != _currentUserId.toString()) {
          _roomsWithUnreadMessages.add(roomId);
          await _saveUnreadRooms();
        }

        setState(() {});
      },
    );

    if (token != null) {
      _wsService!.connect(token);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _wsService?.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('چت‌ها'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Iconsax.arrow_left),
            onPressed: () => context.pop(),
          ),
        ],
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _chatList.isEmpty
              ? const Center(child: Text('هیچ چتی یافت نشد.'))
              : ListView.builder(
                itemCount: _chatList.length,
                itemBuilder: (context, index) {
                  final chat = _chatList[index];
                  final receiverName =
                      _currentUserId == chat.residence.owner?.id
                          ? chat.user.fullName
                          : chat.residence.owner?.fullName ?? 'نامشخص';

                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        chat.residence.imageUrl ?? '',
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (_, __, ___) =>
                                const Icon(Icons.image_not_supported),
                      ),
                    ),
                    title: Text(receiverName),
                    subtitle: Text(chat.residence.title ?? 'بدون عنوان'),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          formatNumberToPersianWithoutSeparator(
                            convertToJalaliDate(
                              chat.createdAt.toIso8601String(),
                            ),
                          ),
                          style: const TextStyle(fontSize: 12),
                        ),
                        if (_roomsWithUnreadMessages.contains(chat.id))
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                          ),
                      ],
                    ),
                    onTap: () async {
                      _roomsWithUnreadMessages.remove(chat.id);
                      await _saveUnreadRooms();
                      setState(() {});

                      context.push(
                        '/chat/${chat.id}',
                        extra: {
                          'roomId': chat.id,
                          'receiverName': receiverName,
                          'currentUserId': _currentUserId,
                        },
                      );
                    },
                  );
                },
              ),
    );
  }
}

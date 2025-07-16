import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh/core/network/secure_token_storage.dart';
import 'package:safar_khaneh/data/service/chat_services.dart';
import 'package:safar_khaneh/data/models/chat_model.dart';
import 'package:go_router/go_router.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final ChatService _chatService = ChatService();
  late Future<List<ChatModel>> _futureChats;
  int? _currentUserId;

  Future<int?> _getCurrentUserId() async {
    final userId = await TokenStorage.getUserId();
    return userId;
  }

  @override
  void initState() {
    super.initState();
    _futureChats = _chatService.getChatRooms();
    _loadCurrentUserId();
  }

  Future<void> _loadCurrentUserId() async {
    final userId = await _getCurrentUserId();
    if (mounted) {
      setState(() {
        _currentUserId = userId;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('چت ها'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Iconsax.arrow_left),
            onPressed: () => context.pop(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: _futureChats,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final chats = snapshot.data!;

              return ListView.builder(
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  final chat = chats[index];
                  return ListTile(
                    title: Text(chat.residence.title!),
                    subtitle: Text(
                      _currentUserId == chat.residence.owner?.id
                          ? chat.user.fullName
                          : chat.residence.owner!.fullName!,
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        chat.residence.imageUrl!,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // trailing: const Icon(Iconsax.arrow_left_2),
                    onTap: () {
                      context.push(
                        '/chat/${chat.id}',
                        extra: {
                          'roomId': chat.id,
                          'receiverName':
                              _currentUserId == chat.residence.owner?.id
                                  ? chat.user.fullName
                                  : chat.residence.owner!.fullName!,
                          'currentUserId': _currentUserId,
                        },
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

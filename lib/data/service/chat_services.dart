import 'package:safar_khaneh/core/network/auth_api_client.dart';
import 'package:safar_khaneh/data/models/chat_model.dart';

class ChatService {
  final _client = AuthApiClient();

  Future<List<ChatModel>> getChatRooms() async {
  final res = await _client.get('chat/room/');
  final List data = res.data;

  return data.map((e) => ChatModel.fromJson(e)).toList();
}


  Future<List<dynamic>> getMessages(int roomId) async {
    final res = await _client.get('chat/room/$roomId/messages/');
    return res.data;
  }

  Future<dynamic> createRoom(int residenceId) async {
    final res = await _client.post(
      'chat/room/create/',
      data: {'residence_id': residenceId},
    );
    return res.data;
  }
}

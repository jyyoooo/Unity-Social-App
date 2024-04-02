import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unitysocial/features/auth/data/models/user_model.dart';
import 'package:unitysocial/features/community/models/message_model.dart';
import 'package:unitysocial/features/community/repository/chat_room_repo.dart';

class ChatRepo {
  final chatRooms = ChatRoomRepo().chatroomsRef;
  final users = FirebaseFirestore.instance.collection('users');

  sendMessage(Message message) async {
    try {
      final messagesCollection =
          chatRooms.doc(message.roomId).collection('messages');
      await messagesCollection.add(message.toMap());
    } catch (e) {
      log('send message error: $e');
    }
  }

  Stream<List<Message>> fetchMessages(String roomId) async* {
    try {
      final messagesCollection = chatRooms.doc(roomId).collection('messages');
      yield* messagesCollection.orderBy('sentAt').snapshots().map((data) {
        return data.docs
            .map((message) => Message.fromMap(message.data()))
            .toList();
      });
    } catch (e) {
      log('fetch messages error: $e');
    }
  }

  Future<Message> fetchLastMessage(String roomId) async {
    try {
      final messagesCollection = chatRooms.doc(roomId).collection('messages');
      final lastMsg = await messagesCollection
          .orderBy('sentAt', descending: true)
          .limit(1)
          .get();
      return Message.fromMap(lastMsg.docs.first.data());
    } catch (e) {
      log('fetch last message error: $e');
      // maybe replace the throw with an empty Message object return
      throw Exception(e);
    }
  }

  Future<String> getSenderUsername(String senderId) async {
    final senderDoc = await users.where('uid', isEqualTo: senderId).get();
    final sender = UserProfile.fromMap(senderDoc.docs.first.data());
    return sender.userName;
  }

}

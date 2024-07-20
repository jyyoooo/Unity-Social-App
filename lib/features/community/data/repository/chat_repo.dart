import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unitysocial/features/auth/data/models/user_profile.dart';
import 'package:unitysocial/features/community/data/models/message_model.dart' ;
import 'package:unitysocial/features/community/data/repository/chat_room_repo.dart';
import 'package:unitysocial/features/push_notification/push_notification_service.dart';

class ChatRepo {
  final chatRooms = ChatRoomRepo().chatroomsRef;
  final users = FirebaseFirestore.instance.collection('users');

  sendMessage(Message message) async {
    try {
      final messagesCollection =
          chatRooms.doc(message.roomId).collection('messages');
      await messagesCollection.add(message.toMap());
      PushNotificationService.sendNotificationToTopic(message);
    } catch (e) {
      log('send message error: $e');
    }
  }

  Stream<List<Message>> fetchMessages(String roomId) {
    final messagesCollection = chatRooms.doc(roomId).collection('messages');

    return messagesCollection
        .orderBy('sentAt')
        .snapshots()
        .map((querySnapshot) {
      List<Message> messages = [];

      for (var doc in querySnapshot.docs) {
        final message = Message.fromMap(doc.data());
        messages.add(message);
      }
      // log('logging msgs from repo: ${messages.toString()}');
      return messages;
    });
  }

  Future<Message> fetchLastMessage(String roomId) async {
    try {
      final messagesCollection = chatRooms.doc(roomId).collection('messages');
      final lastMsg = await messagesCollection
          .orderBy('sentAt', descending: true)
          .limit(1)
          .get();
      if (lastMsg.docs.isEmpty) {
        return Message(
            text: 'No messages', senderId: '', sentAt: DateTime.now());
      }
      return Message.fromMap(lastMsg.docs.first.data());
    } catch (e) {
      log('fetch last message error: $e');
      return Message(text: 'No messages', senderId: '', sentAt: DateTime.now());
    }
  }

  Future<String> getSenderUsername(String senderId) async {
    final senderDoc = await users.where('uid', isEqualTo: senderId).get();
    final sender = UserProfile.fromMap(senderDoc.docs.first.data());
    return sender.userName;
  }
}

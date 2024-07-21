import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unitysocial/features/auth/data/models/user_profile.dart';
import 'package:unitysocial/features/community/data/models/message_model.dart';
import 'package:unitysocial/features/community/data/repository/chat_room_repo.dart';
import 'package:unitysocial/features/push_notification/push_notification_service.dart';

class ChatRepo {
  static final chatRooms = ChatRoomRepo().chatroomsRef;
  static final users = FirebaseFirestore.instance.collection('users');
  static String? senderName;

  static sendMessage(Message message, String roomName) async {
    try {
      final messagesCollection =
          chatRooms.doc(message.roomId).collection('messages');
      await messagesCollection.add(message.toMap());
      // get user name for push notification
      senderName = await getSenderUsername(message.senderId);
      PushNotificationService.sendNotificationToTopic(
          message, roomName, senderName!);
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

  static Stream<Message> fetchLastMessage(String roomId) {
  final messagesCollection = chatRooms.doc(roomId).collection('messages');

  return messagesCollection
      .orderBy('sentAt', descending: true)
      .limit(1)
      .snapshots()
      .map((snapshot) {
    if (snapshot.docs.isEmpty) {
      return Message(
        text: 'No messages',
        senderId: '',
        sentAt: DateTime.now(),
      );
    }
    return Message.fromMap(snapshot.docs.first.data());
  }).handleError((error) {
    log('fetch last message error: $error');
    return Message(
      text: 'No messages',
      senderId: '',
      sentAt: DateTime.now(),
    );
  });
}


  static Future<String> getSenderUsername(String senderId) async {
    final senderDoc = await users.where('uid', isEqualTo: senderId).get();
    final sender = UserProfile.fromMap(senderDoc.docs.first.data());
    return sender.userName;
  }
}

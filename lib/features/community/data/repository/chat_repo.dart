import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unitysocial/features/auth/data/models/user_profile.dart';
import 'package:unitysocial/features/community/data/models/message_model.dart';
import 'package:unitysocial/features/community/data/repository/chat_room_repo.dart';
import 'package:unitysocial/features/push_notification/push_notification_service.dart';

class ChatRepo {
  static final chatRooms = ChatRoomRepo.chatroomsRef;
  static final users = FirebaseFirestore.instance.collection('users');
  static String? senderName;

  // Stream new single messages
  Stream<List<Message>> streamNewMessages(String roomId) {
    final messagesCollection = chatRooms.doc(roomId).collection('messages');

    return messagesCollection
        .orderBy('sentAt', descending: true)
        .limit(20)
        .snapshots()
        .transform(StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
            List<Message>>.fromHandlers(
      handleData: (data, sink) async {
        List<Message> messages = [];
        for (DocumentSnapshot doc in data.docs) {
          messages.add(Message.fromMap(doc));
        }
        sink.add(messages);
      },
    ));
  }

  Future<List<Message>> fetchPreviousMessages(
      String roomId, String previousDocId) async {
    final messagesCollection = chatRooms.doc(roomId).collection('messages');
    final previousDoc = await messagesCollection.doc(previousDocId).get();
    if (previousDoc.exists) {
      var querySnapshot = await messagesCollection
          .orderBy('sentAt', descending: true)
          .startAfterDocument(previousDoc)
          .limit(20)
          .get();
      return querySnapshot.docs.map((doc) => Message.fromMap(doc)).toList();
    }
    return [];
  }

  ///////////////////////

  Stream<List<Message>> fetchMessages(String roomId) {
    final messagesCollection = chatRooms.doc(roomId).collection('messages');

    return messagesCollection
        .orderBy('sentAt')
        .limitToLast(1)
        .snapshots()
        .map((querySnapshot) {
      List<Message> messages = [];

      for (var doc in querySnapshot.docs) {
        final message = Message.fromMap(doc);
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
      return Message.fromMap(snapshot.docs.first);
    }).handleError((error) {
      log('fetch last message error: $error');
      return Message(
        text: 'No messages',
        senderId: '',
        sentAt: DateTime.now(),
      );
    });
  }

  static sendMessage(Message message, String roomName) async {
    try {
      final messagesCollection =
          chatRooms.doc(message.roomId).collection('messages');
      await messagesCollection.add(message.toMap());
      // get user name for push notification
      senderName = await getSenderUsername(message.senderId);
      // PushNotificationService.sendNotificationToTopic(
      //     message, roomName, senderName!);
    } catch (e) {
      log('send message error: $e');
    }
  }

  static Future<String> getSenderUsername(String senderId) async {
    final senderDoc = await users.where('uid', isEqualTo: senderId).get();
    final sender = UserProfile.fromMap(senderDoc.docs.first.data());
    return sender.userName;
  }
}

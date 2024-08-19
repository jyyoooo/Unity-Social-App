import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unitysocial/core/enums/message_type.dart';

class Message {
  final String? roomId;
  final String? messageId;
  final String senderId;
  final String text;
  final DateTime sentAt;
  final MessageType? type;
  Message({
    this.roomId,
    this.messageId,
    required this.text,
    required this.senderId,
    required this.sentAt,
    this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'senderId': senderId,
      'sentAt': sentAt.millisecondsSinceEpoch,
    };
  }

  factory Message.fromMap(DocumentSnapshot doc) {
    final Map<String,dynamic> message = doc.data() as Map<String,dynamic>;
    return Message(
      messageId: doc.id,
      text: message['text'] as String,
      senderId: message['senderId'] as String,
      sentAt: DateTime.fromMillisecondsSinceEpoch(message['sentAt']),
    );
  }
}

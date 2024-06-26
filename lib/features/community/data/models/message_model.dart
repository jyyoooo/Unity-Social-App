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

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      messageId: map['messageId'],
      text: map['text'] as String,
      senderId: map['senderId'] as String,
      sentAt: DateTime.fromMillisecondsSinceEpoch(map['sentAt']),
    );
  }
}

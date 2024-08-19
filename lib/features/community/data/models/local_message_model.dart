// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

part 'local_message_model.g.dart';

@HiveType(typeId: 0)
class LocalMessage extends HiveObject {
  @HiveField(0)
  final String senderId;

  @HiveField(1)
  final String text;

  @HiveField(2)
  final DateTime sentAt;

  // Add other fields if necessary

  LocalMessage({
    required this.senderId,
    required this.text,
    required this.sentAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'text': text,
      'sentAt': sentAt.millisecondsSinceEpoch,
    };
  }

  factory LocalMessage.fromMap(Map<String, dynamic> map) {
    return LocalMessage(
      senderId: map['senderId'] as String,
      text: map['text'] as String,
      sentAt: DateTime.fromMillisecondsSinceEpoch(map['sentAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory LocalMessage.fromJson(String source) => LocalMessage.fromMap(json.decode(source) as Map<String, dynamic>);
}

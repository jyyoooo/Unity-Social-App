import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  final String? roomId;
  final String? postId;
  final String admin;
  List<String>? members = [];
  final String name;

  ChatRoom(
      {this.roomId,
      required this.postId,
      required this.admin,
      this.members,
      required this.name});

  factory ChatRoom.fromMap(DocumentSnapshot doc) {
    return ChatRoom(
        roomId: doc.id,
        postId: doc['postId'],
        members: List<String>.from(doc['members'] ?? []),
        name: doc['name'] as String,
        admin: doc['admin'] as String);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'roomId': roomId,
      'postId': postId,
      'members': members,
      'name': name,
      'admin': admin
    };
  }
}

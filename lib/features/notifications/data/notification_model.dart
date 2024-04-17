import 'package:cloud_firestore/cloud_firestore.dart';

class UnityNotification {
  String? id;
  String recepientId;
  String title;
  String description;
  bool isRead;
  
  UnityNotification({
    this.id,
    required this.recepientId,
    required this.title,
    required this.description,
     this.isRead = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'recepientId': recepientId,
      'title': title,
      'description': description,
      'isRead': isRead,
    };
  }

  factory UnityNotification.fromMap(DocumentSnapshot doc) {
    return UnityNotification(
      id: doc.id,
      recepientId: doc['recepientId'] as String,
      title: doc['title'] as String,
      description: doc['description'] as String,
      isRead: doc['isRead'] as bool,
    );
  }
}

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:unitysocial/features/notifications/data/notification_model.dart';

class NotificationRepository {
  static final FirebaseMessaging messaging = FirebaseMessaging.instance;
  final notifications = FirebaseFirestore.instance.collection('notifications');
  final userId = FirebaseAuth.instance.currentUser!.uid;

  Stream<List<UnityNotification>> fetchNotification() {
    Stream<List<UnityNotification>> allNotifications;
    try {
      allNotifications = notifications
          .where('recepientId', isEqualTo: userId)
          .orderBy('timeStamp', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) {
                return UnityNotification.fromMap(doc);
              }).toList());
      log("Fetched notifications successfully");
      return allNotifications;
    } catch (e) {
      log('Error fetching notifications: $e');
      return const Stream.empty();
    }
  }
}

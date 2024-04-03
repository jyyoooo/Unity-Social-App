import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationRepository {
  static final FirebaseMessaging messaging = FirebaseMessaging.instance;
  final notifications = FirebaseFirestore.instance.collection('notifications');

  sendNotification() {
    TODO: 'impement';
  }
}

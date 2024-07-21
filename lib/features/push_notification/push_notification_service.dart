import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis/servicecontrol/v1.dart' as servicecontrol;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:unitysocial/core/enums/message_type.dart';
import 'package:unitysocial/core/secrets/secrets.dart';
import 'package:unitysocial/features/community/data/models/message_model.dart'
    as unityMessage;

class PushNotificationService {
  final firelytics = FirebaseAnalytics.instance;
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final _localNotificationPlugin = FlutterLocalNotificationsPlugin();

  // topics push notification

  static subscribeToTopic(String groupId) async {
    await _firebaseMessaging.subscribeToTopic(groupId);
  }

  static void sendNotificationToTopic(
      unityMessage.Message message, String roomName, String senderName) async {
    log(senderName);
    final token = await getToken();
    final payload = {
      'message': {
        'notification': {
          'title': '$roomName - Unity Social',
          'body': '$senderName : ${message.text}'
        },
        'data': {'senderId': message.senderId, 'roomId': message.roomId},
        'topic': message.roomId
      }
    };

    try {
      final response = await http.post(
          Uri.parse(endpointFirebaseCloudMessaging),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(payload));

      if (response.statusCode == 200) {
        log('message sent ${response.statusCode}');
      } else {
        log('something went wrong ${response.body}');
      }
    } catch (e) {
      log('push notif error: $e');
    }
  }

  static void display(RemoteMessage message) async {
    log('display called');
    try {
      const notification = NotificationDetails(
          android: AndroidNotificationDetails('Channel', 'channelName',
              importance: Importance.max, priority: Priority.high));

      log('sender id ${message.data['senderId']}');

      if (message.data['senderId'] != FirebaseAuth.instance.currentUser!.uid) {
        await _localNotificationPlugin.show(
            message.hashCode,
            message.notification!.title,
            message.notification!.body,
            notification);
      }
    } catch (e) {
      log('failed to display notif : $e');
    }
  }

  // requests notification permission
  static init() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    final token = await _firebaseMessaging.getToken();
    log('FCM device token: $token');
  }

  // local notification setup
  static initLocalNotifications() async {
    const androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOSInitSettings = DarwinInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) => 0);

    final initializationSettings = InitializationSettings(
      android: androidInitSettings,
      iOS: iOSInitSettings,
    );

    // requesting permission for Android 13+
    _localNotificationPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();

    _localNotificationPlugin.initialize(initializationSettings,
        onDidReceiveBackgroundNotificationResponse: onNotificationTapped,
        onDidReceiveNotificationResponse: onNotificationTapped);
  }

  static void onNotificationTapped(NotificationResponse response) {}

  ////////////////////////////////////////////////////////////////////////////////////////////
  // V1 API

  static getToken() async {
    
    http.Client client = await auth.clientViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccountJSON), scopes);

    //  obtains the access token
    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJSON),
      scopes,
      client,
    );

    client.close();

    return credentials.accessToken.data;
  }
}

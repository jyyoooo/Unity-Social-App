import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:unitysocial/core/secrets/secrets.dart';
import 'package:unitysocial/features/community/data/models/message_model.dart'
    as unitymessage;
import 'package:unitysocial/main.dart';

class PushNotificationService {
  final firelytics = FirebaseAnalytics.instance;
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final _localNotificationPlugin = FlutterLocalNotificationsPlugin();

  static void onNotificationTapped(NotificationResponse response) {
    // Assuming the payload is a JSON string with roomId and roomName
    log('in on notification tapped in service class');
    final payload = json.decode(response.payload!);
    final roomId = payload['roomId'];
    final roomName = payload['roomName'];

    // navigatorKey.currentState?.pushNamed(
    //   '/chatScreen',
    //   arguments: {'roomId': roomId, 'roomName': roomName},
    // );
  }

  // group topic subsctiption

  static subscribeToTopic(String groupId) async {
    await _firebaseMessaging.subscribeToTopic(groupId);
  }

  //notification payload format
  static Map<String, Map<String, Object?>> notificationPayload(
      String roomName, String senderName, unitymessage.Message message) {
    return {
      'message': {
        'notification': {
          'title': '$roomName - Unity Social',
          'body': '$senderName : ${message.text}'
        },
        'data': {
          'senderId': message.senderId,
          'roomId': message.roomId,
          'roomname': roomName
        },
        'topic': message.roomId
      }
    };
  }

  // sends notification to the topic
  static void sendNotificationToTopic(
      unitymessage.Message message, String roomName, String senderName) async {
    log(senderName);
    final token = await getTokenFromGoogleServiceAccount();
    final payload = notificationPayload(roomName, senderName, message);

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

  // requests notification permission
  static init() async {
    log('initializing notifications');
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
    log('initializing local notifications');
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
        onDidReceiveBackgroundNotificationResponse: _onNotificationTap,
        onDidReceiveNotificationResponse: _onNotificationTap);
  }

  // V1 API token
  static getTokenFromGoogleServiceAccount() async {
    try {
      http.Client client = await auth.clientViaServiceAccount(
          auth.ServiceAccountCredentials.fromJson(serviceAccountJSON), scopes);

      auth.AccessCredentials credentials =
          await auth.obtainAccessCredentialsViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccountJSON),
        scopes,
        client,
      );
      client.close();

      return credentials.accessToken.data;
    } catch (e) {
      log('ERROR getTokenFromGoogleServiceAccount: $e');
    }
  }

  //diaplays local notification
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

  // Handle background message tap
  static Future<void> _onNotificationTap(NotificationResponse response) async {
    log('onNotifTap');
    if (response.payload!.isNotEmpty) {
      try {
        log('payload ${response.payload}');
        // final data = jsonDecode(response.payload!);
        _navigateToChatScreen(await jsonDecode(response.payload!));
      } catch (e) {
        log('onNotifTapErr: $e');
      }
    }
  }

  // Navigate to chat screen
  static void _navigateToChatScreen(Map<String, dynamic> data) {
    log('notif route called');
    log(data.toString());
    final String? roomId = data['roomId'];
    final String? roomName = data['roomName'];
    log(roomId ?? 'no roomiD');

    if (roomId != null) {
      log(navigatorKey.currentState.toString());
      navigatorKey.currentState?.pushNamed(
        '/chatScreen',
        arguments: {'roomId': roomId, 'roomName': roomName},
      );
    }
  }
}

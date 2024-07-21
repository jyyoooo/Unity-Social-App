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
          Uri.parse(
              'https://fcm.googleapis.com/v1/projects/unity-social-6483e/messages:send'),
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
    final serviceAccountJSON = {
      "type": "service_account",
      "project_id": "unity-social-6483e",
      "private_key_id": "2fc4a91af817de0cfd8fc43b37aec663846b06e3",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDQfa9008rQCOGQ\nNMXFYezqHDSnnmREbtpFoWhsMzi6y37GEpEvEKg7ou+XvJKoEaOSC74+VZ+7rFW1\nXPv0S7YglzCfJWTj99rfT1vpeZArPDqJD7vnOWFiiKbOS4teF1xawfkjfRaIJbd7\n+adLy8Lp0ZeEorn18SBc4oLbJXHmFeHQyNYwXRV7ualjxKfX5RZo6LAvYTh5sAEb\n1fLfnmjDDQ8MFBuM7/9oiMQsNQBNvPHiK4U9T/lcl76GkPYe2J1QrpfKkVCjrChq\nqm7UKji1QQPphr2ESOhPsWaVP6vtipKNY185+qsDHivOqwCyGV7BD7ncBfNuCvHH\n2OMqW5J/AgMBAAECggEABfsp3rZtHo7qqnO0USdjUwudGePqD3aFdEyFmnkIgX9X\nmZoSjscx2rtS/hQVIJVk9ZcfQMC9e0Md44nEpp6XanoiSHNO4IvA1fnIv4fS8kXH\njhzX8KTnEM5HyF16Plt5zrBUekd0r1IzRqJQwaFmUl8TZpgxsO1w1ryFMYE/ZVc7\ngkoi7FichouQOXaS32qatYyqGos/Ie4TlS0ZWENcFt3vGVutx+ymbuAcbtBuJujt\npqOleRwKMsi69yaWfO+flJ6LpHUi4FueKi3iXMyNEbDn8Kgxxreal4jPs7ZVHgRD\nVS46Oqqi4GqcRVxa5qVCATb6AS/flCZco0W1i3VjYQKBgQDnVTPJh0naxxFarVNu\nZxXgXyZTyGfa1bvHq//DpTEqrW0lMD0t1vgI0dfz2xREwTmtjq48SzyapztQC4AF\nx8BWK/4dvvSghatipWjMuPOrg5sw3JOJEWCLZrrpK6LnT6UP3oyTDh2SQrtG/Ys7\nRBpXlFYbKe5EYrX8YlzF+GB5nwKBgQDmuPVUG4dryOSM05vPrylccT8lpmRWr4pN\nLF7SOHApsn6uRmBhN6jbu9tufnYm+dqz1Ztqh4bA3XUHi0ofO0L2dgCZqXf8xxrG\nzkb+C7rBqliTLnt1aR7JOPHNCZXmwn/0EtQ1iPoDBr5UNzqrKeuatgVPbTJxyAjb\n2PxILDP7IQKBgG3NOEaIy5pncKpMqNQ3Y9/a6fNMpVbuqjHNRxoTF7I9HRhQvEk8\nxwBQsiMSMp2r5XemyLbfs0Vo6TNGMh8MQBPmz7hIwg5LRB0PjB3YD/iyAACCQhkG\nQYAJY+B3ENygJiXRKYJHaevZdtDsWaDo42P8iZ5dGbYl8GF6QrTI/unbAoGBAJHE\n/cr78Z1ZuXx4HZMjueAb9KeW7wINujVz+RycZ9EQYxU8hZwmjFr333V6FLAfX9wK\n8zxlD/A+ergfet8sk+wfNdXfyl08dmBw502On5nIRFoJHhtaJQdBIRRIIBtBe5H7\na3O/bSYIVqvikQCfZanDoqtB9IMKvP4Zo5r9woHBAoGBAK0Od/6aJcUTbPwWS3G7\nSKRCQMTQe0T8vx9cBqmzQRPJg7xtzxfDCap58l+Sxj0bN4pO6pK7XkzqC9vezk6p\nIQTRnV0FlRzmhh5tJCDafWC4f/SslL86pf+FxeDMkHM7nDmJOcnWQvRzT+wT2+Wf\nVkkbhAeNChpKVXZpu5R0lDNk\n-----END PRIVATE KEY-----\n",
      "client_email": "unitysocial@unity-social-6483e.iam.gserviceaccount.com",
      "client_id": "100876926404640167222",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/unitysocial%40unity-social-6483e.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    List<String> scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];

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

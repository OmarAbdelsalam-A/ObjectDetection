import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> initializeNotifications() async {
    await _messaging.requestPermission();
    FirebaseMessaging.onMessage.listen((message) {
      print("Notification Received: ${message.notification?.title}");
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Background notification received: ${message.notification?.title}");
  }
}

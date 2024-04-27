import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<String?> getToken() async {
    String? token = await _fcm.getToken();
    print('Token: $token');
    return token;
  }
}
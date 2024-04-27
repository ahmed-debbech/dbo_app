import 'package:dbo_app/services/PushNotificationService.dart';
import 'package:dbo_app/services/UserService.dart';

class BackgroundService {
  void refreshUser() {
    PushNotificationService pns = PushNotificationService();
    pns.getToken().then((value) {
      print(value);
      UserService us = UserService();
      us.updateUser(value);
    });
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import '../global.dart' as globals;

class UserService {
  void updateUser(fcm) async {
    try {
      final response = await http.post(
        Uri.parse('${globals.api}/users/refresh'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          'fcmToken': fcm,
        }),
      );
    } catch (e) {
      print("error connecting");
    }
  }
}

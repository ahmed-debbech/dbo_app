import 'dart:convert';

import 'package:dbo_app/dto/NotifConfig.dart';
import 'package:dbo_app/services/PushNotificationService.dart';
import 'package:http/http.dart' as http;
import '../global.dart' as globals;

class NotificationService{
  Future<NotifConfig?> getNotifsForUser() async{
    try {
      PushNotificationService pns = PushNotificationService();
      String? token = await pns.getToken();
      if(token == null) throw Exception();

      final response = await http.get(Uri.parse(globals.api + '/users/notif/' + token));
      dynamic data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        print(data);
        return NotifConfig.fromJson(data);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  void sendChange(String field, bool val) async{
    print("f" + field + " " + val.toString());
    try {
      PushNotificationService pns = PushNotificationService();
      String? token = await pns.getToken();
      if(token == null) throw Exception();

      final response = await http.post(
        Uri.parse('${globals.api}/users/update/notif'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, dynamic>{
          'fieldName': field as String,
          'activated' : val as bool,
          'userId' : token as String
        }),
      );
      print(response.body);
    } catch (e) {
      print("error connecting");
    } 
  }
}
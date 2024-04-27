import 'dart:convert';

import 'package:dbo_app/dto/FirebaseEvent.dart';
import 'package:dbo_app/dto/NextEvent.dart';
import 'package:dbo_app/utils/utilities.dart';
import 'package:http/http.dart' as http;
import '../global.dart' as globals;

class BudoService {
  void getNext() async {
    try {
      final response = await http.get(Uri.parse(globals.api + '/s/next'));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        NextEvent ne = NextEvent.fromJson(data);
        globals.serverNextEvent = int.parse(ne.nextEvent);
        globals.serverNextNotif = int.parse(ne.nextNotification);
        return;
      }
      globals.serverNextEvent = int.parse('0');
      globals.serverNextNotif = int.parse('0');
    } catch (e) {
      globals.serverNextEvent = int.parse('0');
      globals.serverNextNotif = int.parse('0');
    }
  }

  void getList() async {
    try {
      final response =
          await http.get(Uri.parse(globals.api + '/s/past_events'));
      var data = jsonDecode(response.body.toString());
      print(data);
      if (response.statusCode == 200) {
        List<FirebaseEvent> firebaseEvents = [];
        try {
          data.sort((a, b) =>
              int.parse(b["fe"]["time"]) - int.parse(a["fe"]["time"]));

          for (dynamic d in data) {
            firebaseEvents.add(FirebaseEvent.fromJson(d));
          }

          globals.firebaseBudoEvents = firebaseEvents;
        } catch (e) {
          globals.firebaseBudoEvents = [];
        }
      } else {
        globals.firebaseBudoEvents = [];
      }
    } catch (e) {
      globals.firebaseBudoEvents = [];
    }
  }
}

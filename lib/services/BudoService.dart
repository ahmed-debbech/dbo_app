import 'dart:convert';

import 'package:dbo_app/dto/FirebaseEvent.dart';
import 'package:dbo_app/dto/NextEvent.dart';
import 'package:dbo_app/dto/AppState.dart';
import 'package:dbo_app/utils/utilities.dart';
import 'package:http/http.dart' as http;
import '../global.dart' as globals;

class BudoService {
  void getState() async {
    try {
      final response = await http.get(Uri.parse(globals.api + '/app/state'));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        AppState ne = AppState.fromJson(data);
        globals.appState = ne;
        return;
      }
      globals.appState = null;
    } catch (e) {
      print(e);
      globals.appState = null;
    }
  }
}

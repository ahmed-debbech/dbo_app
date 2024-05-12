import 'dart:convert';

import 'package:http/http.dart' as http;
import '../global.dart' as globals;

class BossService {

  Future<Map<String, dynamic>> getPercentage() async{
    try {
      final response = await http.get(Uri.parse(globals.api + '/app/boss'));
      Map<String, dynamic> data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        return data;
      }
      return {"percentage" : "-1", "eta" : null};
    } catch (e) {
      return {"percentage" : "-1", "eta" : null};
    }
  }
}

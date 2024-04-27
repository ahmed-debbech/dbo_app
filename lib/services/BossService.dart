import 'dart:convert';

import 'package:http/http.dart' as http;
import '../global.dart' as globals;

class BossService {
  void getList() async {
    globals.worldBossTimes = [];
    final response = await http.get(Uri.parse(globals.api + '/s/past_boss'));
    List<dynamic> data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      data.sort((a, b) =>
              int.parse(b) - int.parse(a));

      for (int i = 0; i <= data.length - 1; i++) {
        globals.worldBossTimes.add(data[i] as String);
      }
      print(globals.worldBossTimes);
      return;
    } else {
      globals.worldBossTimes = [];
    }
  }
}
